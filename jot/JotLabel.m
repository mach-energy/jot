//
//  JotLabel.m
//  DrawModules
//
//  Created by Martin Prot on 24/09/2015.
//  Copyright © 2015 appricot. All rights reserved.
//

#import "JotLabel.h"

@interface JotLabel ()

@property (nonatomic, strong) CAShapeLayer *borderLayer;

@end

@implementation JotLabel

- (instancetype)init
{
	self = [super init];
	if (self) {
		_initialRotationTransform = CGAffineTransformIdentity;
		_scale = 1;
		_unscaledFrame = self.frame;
	}
	return self;
}

- (void)setSelected:(BOOL)selected {
	if (_selected != selected) {
		_selected = selected;
		if (selected) {
			self.layer.borderColor = [UIColor redColor].CGColor;
			self.layer.borderWidth = 1.f;
		}
		else {
			self.layer.borderColor = [UIColor clearColor].CGColor;
			self.layer.borderWidth = 0.f;
		}
	}
}

- (void)setUnscaledFrame:(CGRect)unscaledFrame
{
	if (!CGRectEqualToRect(_unscaledFrame, unscaledFrame)) {
		_unscaledFrame = unscaledFrame;
		CGPoint labelCenter = self.center;
		CGRect scaledFrame = CGRectMake(0.f,
										0.f,
										_unscaledFrame.size.width * self.scale * 1.05f,
										_unscaledFrame.size.height * self.scale * 1.05f);
		CGAffineTransform labelTransform = self.transform;
		self.transform = CGAffineTransformIdentity;
		self.frame = scaledFrame;
		self.transform = labelTransform;
		self.center = labelCenter;
	}
}

- (void)setScale:(CGFloat)scale
{
	if (_scale != scale) {
		_scale = scale;
		// Get only the rotation component
		CGFloat angle = atan2f(self.transform.b, self.transform.a);
		// Convert a scale trasform (which pixelate) into a scaled font size (vector)
		self.transform = CGAffineTransformIdentity;
		CGPoint labelCenter = self.center;
		CGRect scaledFrame = CGRectMake(0.f,
										0.f,
										_unscaledFrame.size.width * _scale * 1.05f,
											 _unscaledFrame.size.height* _scale * 1.05f);
		CGFloat currentFontSize = self.unscaledFontSize * _scale;
		self.font = [self.font fontWithSize:currentFontSize];
		
		self.frame = scaledFrame;
		self.center = labelCenter;
		self.transform = CGAffineTransformMakeRotation(angle);
	}
}

- (void)refreshFont {
	CGFloat currentFontSize = self.unscaledFontSize * _scale;
	CGPoint center = self.center;
	self.font = [self.font fontWithSize:currentFontSize];
	[self autosize];
	self.center = center;
}


- (void)autosize
{
	JotLabel *temporarySizingLabel = [JotLabel new];
	temporarySizingLabel.text = self.text;
	temporarySizingLabel.font = [self.font fontWithSize:self.unscaledFontSize];
	temporarySizingLabel.textAlignment = self.textAlignment;
	
	CGRect insetViewRect;
	
	if (_fitOriginalFontSizeToViewWidth) {
		temporarySizingLabel.numberOfLines = 0;
		insetViewRect = CGRectInset(self.bounds,
									_initialTextInsets.left + _initialTextInsets.right,
									_initialTextInsets.top + _initialTextInsets.bottom);
	} else {
		temporarySizingLabel.numberOfLines = 1;
		insetViewRect = CGRectMake(0.f, 0.f, CGFLOAT_MAX, CGFLOAT_MAX);
	}
	
	CGSize originalSize = [temporarySizingLabel sizeThatFits:insetViewRect.size];
	temporarySizingLabel.frame = CGRectMake(0.f,
											0.f,
											originalSize.width * 1.05f,
											originalSize.height * 1.05f);
	temporarySizingLabel.center = self.center;
	self.unscaledFrame = temporarySizingLabel.frame;
}

@end
