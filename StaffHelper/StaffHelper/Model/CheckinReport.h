//
//  CheckinReport.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckinReport : NSObject

@property(nonatomic,copy)NSString *date;

@property(nonatomic,strong)Student *user;

@property(nonatomic,strong)Card *card;

@property(nonatomic,assign)float cost;

@property(nonatomic,assign)float receive;

@property(nonatomic,copy)NSString *createTime;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,assign)CheckinType checkinType;

@property(nonatomic,copy)NSString *checkoutTime;

@end
