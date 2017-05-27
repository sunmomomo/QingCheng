//
//  CourseRateView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseRateView : UIView

@property(nonatomic,strong)NSArray *grades;

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

-(void)setCoachGrade:(float)coachGrade andCourseGrade:(float)courseGrade andServiceGrade:(float)serviceGrade;

@end
