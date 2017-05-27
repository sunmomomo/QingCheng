//
//  HorizontalGradientView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalGradientView : UIImageView

@property(nonatomic,strong)UIColor *leftColor;

@property(nonatomic,strong)UIColor *rightColor;

-(void)reload;

@end
