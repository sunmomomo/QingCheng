//
//  CoursePlanBatchCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/3.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Course.h"

@interface CoursePlanBatchCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,assign)CourseType type;

@property(nonatomic,assign)BOOL outOfTime;

@end
