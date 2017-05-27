//
//  LoginLineView.h
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/10.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginLineView : UIView

@property(nonatomic,strong)UIView *leftLine;

@property(nonatomic,strong)UIView *rightLine;

-(void)setLeftColor:(UIColor *)color;

-(void)setRightColor:(UIColor *)color;

@end
