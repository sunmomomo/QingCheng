//
//  GTFYButton.h
//  FYRrefresh
//
//  Created by FYWCQ on 16/4/2.
//  Copyright © 2016年 FYWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTFYButton : UIButton

@property(nonatomic, assign)BOOL isSelectStateYF;

@property(nonatomic, assign)CGRect imageFrame;

/***
 **传入图片和 textLabel 相对于button 的frame
 */
- (instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect )titleFrame;


@end
