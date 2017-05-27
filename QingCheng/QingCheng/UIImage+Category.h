//
//  UIImage+Category.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

- (UIImage *)fixOrientation;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

+(UIImage *)imageWithMediaURL:(NSURL *)url;

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage*) imageWithUIView:(UIView*) view;

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;

- (UIImage *)thumbnailWithSize:(CGSize)asize;

+ (UIImage *)imageWithColor:(UIColor *)color;

+(UIImage*)qingchengImageWithName:(NSString*)name;

@end
