//
//  YFButton.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFButton : UIButton

@property(nonatomic, assign)BOOL isSelectStateYF;


//YFButton *button=[[YFButton alloc] initWithFrame:CGRectMake(50, 100, 150, 100) imageFrame:CGRectMake(40, 10, 100, 50) titleFrame:CGRectMake(60, 10, 100, 50)];
//
//
//[button setBackgroundColor:[UIColor redColor]];
//
//[button setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
//
//[button setTitle:@"帅气" forState:UIControlStateNormal];
//

//------点击后的text 高亮为 浅灰色 根据需要改变－－－－－－－－－－－－－－－－

/***
 **传入图片和 textLabel的frame
 */
- (id)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect )titleFrame;

@end
