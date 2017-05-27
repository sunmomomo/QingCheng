//
//  CoursePlanCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Course.h"

@interface CoursePlanCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,assign)BOOL outTime;

@property(nonatomic,assign)CourseType type;

@end
