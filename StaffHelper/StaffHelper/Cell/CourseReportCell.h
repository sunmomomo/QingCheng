//
//  CourseReportCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseReportCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,copy)NSString *shopName;

@property(nonatomic,assign)BOOL sectionFirst;

@property(nonatomic,assign)BOOL sectionLast;

@property(nonatomic,copy)NSString *month;

@property(nonatomic,copy)NSString *day;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSString *userText;

@property(nonatomic,assign)float realPrice;

@property(nonatomic,assign)CourseType courseType;

@end
