//
//  GymProHintView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GymProController.h"

#import "GymProInfo.h"

#import "GymTrySuccessAlert.h"

@protocol GymProHintViewDelegate <GymTrySuccessAlertDelegate>

@end

@interface GymProHintView : UIView

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL canTry;

@property(nonatomic,weak)id<GymProHintViewDelegate> delegate;

+(instancetype)defaultView;

-(void)showInView:(UIView*)view;

@end
