//
//  OrderReport.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/14.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

#import "ReportOrder.h"

@interface OrderReport : NSObject

@property(nonatomic,strong)Course *course;

@property(nonatomic,assign)NSInteger reportId;

@property(nonatomic,assign)NSInteger count;

@property(nonatomic,assign)NSInteger userCount;

@property(nonatomic,assign)NSInteger orderCount;

@property(nonatomic,assign)NSInteger courseCount;

@property(nonatomic,assign)float price;

@property(nonatomic,assign)float realPrice;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *users;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,strong)NSArray *orders;

@property(nonatomic,strong)Coach *coach;

@end
