//
//  UIImageView+ImageFrame.m
//  Pods
//
//  Created by Ritchie on 2016-06-28.
//
//

#import "UIImageView+ImageFrame.h"

@implementation UIImageView (ImageFrame)

- (CGRect)frameForAspectFillImage {
    if (!self.image) {
        return CGRectZero;
    }
    
    CGSize imageSize = self.image.size;
    CGSize containerSize = self.bounds.size;
    CGFloat scale = [self scaleFactorForAspectFill];
    CGSize scaledImageSize = CGSizeMake(imageSize.width / scale,
                                        imageSize.height / scale);
    CGPoint offset = CGPointMake(containerSize.width - scaledImageSize.width,
                                 containerSize.height - scaledImageSize.height);
    return CGRectMake(offset.x / 2.f, offset.y / 2.f, scaledImageSize.width, scaledImageSize.height);
}

- (CGFloat)scaleFactorForAspectFill {
    CGFloat heightRatio = self.image.size.height / self.bounds.size.height;
    CGFloat widthRatio = self.image.size.width / self.bounds.size.width;
    
    CGFloat scale = heightRatio < widthRatio ? heightRatio : widthRatio;
    return scale;
}

@end
