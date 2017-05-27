//
//  YFFPopBaseView.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFFPopBaseView : UIView

+(instancetype)defaultView;

-(void)showInView:(UIView*)view;

-(void)close;

@end
