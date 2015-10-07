//
//  JotTouchObject.h
//  DrawModules
//
//  Created by Martin Prot on 23/09/2015.
//  Copyright © 2015 appricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

extern NSString *const kType;
extern NSString *const kColor;
extern NSString *const kPoint;
extern NSString *const kPointA;
extern NSString *const kPointB;
extern NSString *const kPointAControl;
extern NSString *const kPointBControl;
extern NSString *const kStrokeWidth;
extern NSString *const kStrokeStartWidth;
extern NSString *const kStrokeEndWidth;
extern NSString *const kIsDashed;

@interface JotTouchObject : NSObject

/**
 *  The stroke color of the object
 */
@property (nonatomic, strong) UIColor *strokeColor;

/**
 *  The enclosing rect of the bezier path
 *
 *  @note this method should be overriden in subclasses
 */
@property (nonatomic, readonly) CGRect rect;

/**
 *  Draw the object on current context
 *
 *  @note this method should be overriden in subclasses
 */
- (void)jotDraw;

#pragma mark - Serialization

/**
 *  Creates a new JotTouchObject from a serialized dictionary
 *
 *  @param dictionary the serialization
 *
 *  @return the new JotTouchObject.
 */
+ (instancetype)fromSerialized:(NSDictionary*)dictionary;

/**
 *  Convert the object to a dictionary
 *
 *  @return the object, as a NSDictionary
 */
- (NSMutableDictionary*)serialize;

/**
 *  Unserialize the object from a dictionary
 *
 *  @param the NSDictionary representing the object
 */
- (void)unserialize:(NSDictionary*)dictionary;

@end
