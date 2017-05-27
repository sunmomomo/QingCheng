//
//  CoursePlanAddCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIButton+Category.h"

@protocol CoursePlanAddCellDelegate <NSObject>

-(void)cellWeekClick:(UIButton*)button;

-(void)cellTimeClick:(UIButton*)button;

-(void)cellDelete:(UIButton*)button;

@end

@interface CoursePlanAddCell : UITableViewCell

@property(nonatomic,copy)NSString *week;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,weak)id<CoursePlanAddCellDelegate> delegate;

@end
