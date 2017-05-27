//
//  CourseCoachView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Coach.h"

@protocol CourseCoachViewDelegate <NSObject>

-(void)coachDidSelectedAtIndex:(NSInteger)index;

@end

@interface CourseCoachView : UIView

@property(nonatomic,strong)NSArray *coaches;

@property(nonatomic,weak)id<CourseCoachViewDelegate> delegate;

@end
