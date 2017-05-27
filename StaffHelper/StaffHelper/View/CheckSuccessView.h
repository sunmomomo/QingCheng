//
//  CheckSuccessView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckSuccessView : UIView

@property(nonatomic,copy)NSString *title;

+(instancetype)defaultSuccessView;

-(void)show;

@end
