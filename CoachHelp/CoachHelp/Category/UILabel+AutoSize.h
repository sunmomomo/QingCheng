//
//  UILabel+AutoSize.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoSize)

@property(nonatomic,copy)NSString *autoSizeText;

-(void)autoHeight;

-(void)autoWidth;

-(void)autoSize;

@end
