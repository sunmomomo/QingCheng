//
//  ProgrammeCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Programme.h"

@interface NoPrivateProgrammeCell : UITableViewCell

@end

@interface ProgrammeCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *gym;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *total;

@property(nonatomic,assign)NSInteger orderCount;

@property(nonatomic,assign)NSString *orderUserName;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)ProgrammeStyle style;

@property(nonatomic,assign)BOOL completed;

@property(nonatomic,copy)NSString *clash;

@end
