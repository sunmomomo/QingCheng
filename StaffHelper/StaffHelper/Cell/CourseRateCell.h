//
//  CourseRateCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CourseRateCellDelegate;

@interface CourseRateCell : UITableViewCell

@property(nonatomic,weak)id<CourseRateCellDelegate>delegate;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,strong)NSArray *rates;

@property(nonatomic,assign)CGFloat cellHeight;

-(void)setCoachRate:(float)coachRate andCourseRate:(float)courseRate andServiceRate:(float)serviceRate;

+(CGFloat)getHeightWithRates:(NSArray *)rates;

@end

@protocol CourseRateCellDelegate <NSObject>

-(void)showDetailOfCourseRateCell:(CourseRateCell*)cell;

@end
