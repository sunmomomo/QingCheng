//
//  CoursePictureCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoursePicture.h"

@protocol CoursePictureCellDelegate;

@interface CoursePictureCell : UITableViewCell

@property(nonatomic,strong)NSArray *pictures;

@property(nonatomic,copy)NSString *courseName;

@property(nonatomic,copy)NSString *coachName;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,copy)NSString *courseTime;

@property(nonatomic,weak)id<CoursePictureCellDelegate> delegate;

@end

@protocol CoursePictureCellDelegate <NSObject>

-(void)manageOfCoursePictureCellClick:(CoursePictureCell*)cell;

-(void)pictureCell:(CoursePictureCell*)cell pictureSelectedAtIndex:(NSInteger)index;

@end
