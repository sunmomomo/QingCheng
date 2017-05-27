//
//  SignInAlertView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Student.h"

#import "Card.h"

@protocol SignInAlertViewDelegate <NSObject>

-(void)confirmWithStudent:(Student *)stu andCard:(Card *)card andNumber:(NSString *)number;

@end

@interface SignInAlertView : UIView

@property(nonatomic,assign)id<SignInAlertViewDelegate> delegate;

+(instancetype)defaultAlertVieWithStudent:(Student*)stu;

-(void)showInView:(UIView *)view;

@end
