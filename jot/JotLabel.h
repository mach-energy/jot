//
//  JotLabel.h
//  DrawModules
//
//  Created by Martin Prot on 24/09/2015.
//  Copyright © 2015 appricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JotLabel : UILabel

@property (nonatomic) BOOL selected;

@property (nonatomic, assign) CGFloat unscaledFontSize;

@property (nonatomic, assign) CGRect unscaledFrame;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, assign) BOOL fitOriginalFontSizeToViewWidth;

@property (nonatomic, assign) UIEdgeInsets initialTextInsets;

/**
 *  The rotation transform before the movement. Used as reference during the 
 *  movement.
 */
@property (nonatomic) CGAffineTransform initialRotationTransform;

- (void)refreshFont;

- (void)autosize;

@end
