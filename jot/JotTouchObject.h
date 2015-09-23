//
//  JotTouchObject.h
//  DrawModules
//
//  Created by Martin Prot on 23/09/2015.
//  Copyright © 2015 appricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

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

@end
