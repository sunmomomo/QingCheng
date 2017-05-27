//
//  ScheduleReportDetailCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/5/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Card.h"

#import "ScheduleReportDetailInfo.h"

@interface ScheduleReportDetailCell : UITableViewCell

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,assign)NSInteger count;

@property(nonatomic,assign)float price;

@property(nonatomic,assign)float realPrice;

@property(nonatomic,assign)ScheduleReportDetailPayStatus status;

@property(nonatomic,assign)ScheduleReportDetailPayType type;

@property(nonatomic,strong)Card *card;

@end
