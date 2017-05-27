//
//  CourseCoverCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CourseCoverCellDelegate;

@interface CourseCoverCell : UITableViewCell

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,weak)id<CourseCoverCellDelegate> delegate;

@end

@protocol CourseCoverCellDelegate <NSObject>

-(void)deleteClickOfCourseCoverCell:(CourseCoverCell*)cell;

@end
