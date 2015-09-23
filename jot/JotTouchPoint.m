//
//  JotTouchPoint.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import "JotTouchPoint.h"

@implementation JotTouchPoint

+ (instancetype)withPoint:(CGPoint)point
{
    JotTouchPoint *touchPoint = [JotTouchPoint new];
    touchPoint.point = point;
    touchPoint.timestamp = [NSDate date];
    return touchPoint;
}

- (CGFloat)velocityFromPoint:(JotTouchPoint *)fromPoint
{
    CGFloat distance = (CGFloat)sqrt((double)(pow((double)(self.point.x - fromPoint.point.x),
                                                  (double)2.f)
                                              + pow((double)(self.point.y - fromPoint.point.y),
                                                    (double)2.f)));
    
    CGFloat timeInterval = (CGFloat)fabs((double)([self.timestamp timeIntervalSinceDate:fromPoint.timestamp]));
    return distance / timeInterval;
}

- (CGPoint)CGPointValue
{
    return self.point;
}

- (void)jotDraw
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (!context) {
		return;
	}
	[self.strokeColor setFill];
	CGContextFillEllipseInRect(context, self.rect);

}

- (CGRect)rect
{
	return CGRectInset(CGRectMake(self.point.x, self.point.y, 0.f, 0.f), -self.strokeWidth / 2.f, -self.strokeWidth / 2.f);
}

@end
