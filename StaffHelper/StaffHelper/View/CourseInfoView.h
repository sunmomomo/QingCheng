//
//  CourseInfoView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Course.h"

@interface CourseInfoView : UIView

@property(nonatomic,strong)Course *course;

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
