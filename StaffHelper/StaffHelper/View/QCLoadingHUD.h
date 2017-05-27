//
//  QCLoadingHUD.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCLoadingHUD : UIView

+(QCLoadingHUD*)defaultHUDInView:(UIView *)view;

-(void)loading;

-(void)stopLoading;

@end
