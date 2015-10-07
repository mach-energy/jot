//
//  JotTouchBezier.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import "JotTouchBezier.h"

NSUInteger const kJotDrawStepsPerBezier = 30;

@implementation JotTouchBezier

+ (instancetype)withStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2
{
	return [[JotTouchBezier alloc] initWithStartPoint:startPoint endPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
}

- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2
{
	self = [super init];
	if (self) {
		self.startPoint = startPoint;
		self.endPoint = endPoint;
		self.controlPoint1 = controlPoint1;
		self.controlPoint2 = controlPoint2;
		[self generatePath];
	}
	return self;
}

- (void)dealloc
{
	CGPathRelease(_path);
}

- (void)jotDraw
{
    if (self.constantWidth) {
		[self drawStrategy1];
    } else {
		[self drawStrategy2];
    }
}

- (void)generatePath {
	if (_path) CGPathRelease(_path);
	_path = CGPathCreateMutable();
	CGPathMoveToPoint(_path, NULL, self.startPoint.x, self.startPoint.y);
	CGPathAddCurveToPoint(_path, NULL, self.controlPoint1.x, self.controlPoint1.y, self.controlPoint2.x, self.controlPoint2.y, self.endPoint.x, self.endPoint.y);
}

- (void)drawStrategy1 {
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (!context) {
		return;
	}
	CGContextAddPath(context, _path);
	CGContextSetLineWidth(context, self.startWidth);
	CGContextSetLineCap(context, kCGLineCapRound);
	[self.strokeColor setStroke];
	CGContextStrokePath(context);
}

- (void)drawStrategy2 {
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (!context) {
		return;
	}
	CGFloat widthDelta = self.endWidth - self.startWidth;
	
	[self.strokeColor setStroke];
	CGContextSetLineCap(context, kCGLineCapRound);
	
	for (NSUInteger i = 0; i <= kJotDrawStepsPerBezier; i++) {
		
		CGFloat t = ((CGFloat)i) / (CGFloat)kJotDrawStepsPerBezier;
		CGFloat tt = t * t;
		CGFloat ttt = tt * t;
		CGFloat u = 1.f - t;
		CGFloat uu = u * u;
		CGFloat uuu = uu * u;
		
		CGFloat x = uuu * self.startPoint.x;
		x += 3 * uu * t * self.controlPoint1.x;
		x += 3 * u * tt * self.controlPoint2.x;
		x += ttt * self.endPoint.x;
		
		CGFloat y = uuu * self.startPoint.y;
		y += 3 * uu * t * self.controlPoint1.y;
		y += 3 * u * tt * self.controlPoint2.y;
		y += ttt * self.endPoint.y;
		
		CGFloat pointWidth = self.startWidth + (ttt * widthDelta);
		
		if (i > 0) {
			CGContextAddLineToPoint(context, x, y);
			CGContextSetLineWidth(context, pointWidth);
			CGContextStrokePath(context);
		}
		CGContextMoveToPoint(context, x, y);
	}
}


- (CGRect)rect {
	CGRect boundingBox = CGPathGetBoundingBox(_path);
	CGFloat largestWidth = -MAX(self.startWidth, self.endWidth)/2;
	return CGRectInset(boundingBox, largestWidth, largestWidth);
}

#pragma mark - Serialization

- (NSMutableDictionary*)serialize {
	NSMutableDictionary *dic = [super serialize];
	dic[kPointA] = [NSValue valueWithCGPoint:self.startPoint];
	dic[kPointB] = [NSValue valueWithCGPoint:self.endPoint];
	dic[kPointAControl] = [NSValue valueWithCGPoint:self.controlPoint1];
	dic[kPointBControl] = [NSValue valueWithCGPoint:self.controlPoint2];
	dic[kStrokeStartWidth]	= @(self.startWidth);
	dic[kStrokeEndWidth]	= self.constantWidth?@(self.startWidth):@(self.endWidth);
	
	return dic;
}

- (void)unserialize:(NSDictionary*)dictionary {
	[super unserialize:dictionary];
	if (dictionary[kPointA]) {
		self.startPoint = [dictionary[kPointA] CGPointValue];
	}
	if (dictionary[kPointB]) {
		self.endPoint = [dictionary[kPointB] CGPointValue];
	}
	if (dictionary[kPointAControl]) {
		self.controlPoint1 = [dictionary[kPointAControl] CGPointValue];
	}
	if (dictionary[kPointBControl]) {
		self.controlPoint2 = [dictionary[kPointBControl] CGPointValue];
	}
	[self generatePath];
	
	if (dictionary[kStrokeStartWidth]) {
		self.startWidth = [dictionary[kStrokeStartWidth] floatValue];
	}
	if (dictionary[kStrokeEndWidth]) {
		self.endWidth = [dictionary[kStrokeEndWidth] floatValue];
	}
	self.constantWidth = (self.startWidth == self.endWidth);
}

@end
