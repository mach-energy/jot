//
//  JotTouchObject.m
//  DrawModules
//
//  Created by Martin Prot on 23/09/2015.
//  Copyright © 2015 appricot. All rights reserved.
//

#import "JotTouchObject.h"

NSString *const kType = @"Type";
NSString *const kColor = @"Color";
NSString *const kPoint = @"Point";
NSString *const kPointA = @"PointA";
NSString *const kPointB = @"PointB";
NSString *const kPointAControl = @"PointAControl";
NSString *const kPointBControl = @"PointBControl";
NSString *const kStrokeWidth = @"StrokeWidth";
NSString *const kStrokeStartWidth = @"StrokeStartWidth";
NSString *const kStrokeEndWidth = @"StrokeEndWidth";
NSString *const kIsDashed = @"IsDashed";

@implementation JotTouchObject

- (CGRect)rect {
	NSAssert(NO, @"this method should be overriden in subclass");
	return CGRectZero;
}

- (void)jotDraw {
	NSAssert(NO, @"this method should be overriden in subclass");
}

#pragma mark - Serialization

+ (instancetype)fromSerialized:(NSDictionary*)dictionary {
	NSString *className = dictionary[kType];
	JotTouchObject *object = nil;
	if (className) {
		object = [NSClassFromString(className) new];
		[object unserialize:dictionary];
	}
	return object;
}

- (NSMutableDictionary*)serialize {
	NSMutableDictionary *dic = [NSMutableDictionary new];
	dic[kType] = NSStringFromClass(self.class);
	dic[kColor] = self.strokeColor;
	return dic;
}

- (void)unserialize:(NSDictionary*)dictionary {
	self.strokeColor = dictionary[kColor];
}

@end
