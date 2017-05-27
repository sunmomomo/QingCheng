//
//  CourseCoachRateView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Coach.h"

@protocol CourseCoachRateViewDelegate <NSObject>

-(void)rateViewDidSelectedCoachAtIndex:(NSInteger)index;

@end

@interface CourseCoachRateView : UIView

@property(nonatomic,strong)NSArray *coaches;

@property(nonatomic,weak)id<CourseCoachRateViewDelegate> delegate;

@end
