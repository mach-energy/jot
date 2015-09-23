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
		_path = CGPathCreateMutable();
		CGPathMoveToPoint(_path, NULL, startPoint.x, startPoint.y);
		CGPathAddCurveToPoint(_path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
		self.startPoint = startPoint;
		self.endPoint = endPoint;
		self.controlPoint1 = controlPoint1;
		self.controlPoint2 = controlPoint2;
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

@end
