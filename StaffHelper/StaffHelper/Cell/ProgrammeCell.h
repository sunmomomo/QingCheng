//
//  ProgrammeCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Programme.h"

@interface ProgrammeCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *gym;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *total;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSString *coach;

@property(nonatomic,assign)ProgrammeStyle style;

@property(nonatomic,strong)UIColor *completedColor;

@end
