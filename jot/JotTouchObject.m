//
//  JotTouchObject.m
//  DrawModules
//
//  Created by Martin Prot on 23/09/2015.
//  Copyright © 2015 appricot. All rights reserved.
//

#import "JotTouchObject.h"

@implementation JotTouchObject

- (CGRect)rect {
	NSAssert(NO, @"this method should be overriden in subclass");
	return CGRectZero;
}

- (void)jotDraw {
	NSAssert(NO, @"this method should be overriden in subclass");
}

@end
