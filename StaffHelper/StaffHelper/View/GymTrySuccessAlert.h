//
//  GymTrySuccessAlert.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GymTrySuccessAlertDelegate <NSObject>

-(void)trySuccessAlertStart;

@end

@interface GymTrySuccessAlert : UIView

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,copy)NSString *systemEnd;

@property(nonatomic,weak)id<GymTrySuccessAlertDelegate>delegate;

+(instancetype)defaultAlert;

-(void)showInView:(UIView *)view;

@end
