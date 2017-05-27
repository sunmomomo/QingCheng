//
//  Checkin.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

#import "Card.h"

#import "Chest.h"

#import "CoursePlanBatch.h"

@interface Checkin : NSObject

@property(nonatomic,strong)NSArray *courseBatches;

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)Card *card;

@property(nonatomic,strong)Chest *chest;

@property(nonatomic,assign)NSInteger checkinId;

@property(nonatomic,copy)NSString *createTime;

@property(nonatomic,copy)NSString *checkoutTime;

@property(nonatomic,strong)Staff *checkinStaff;

@property(nonatomic,strong)Staff *checkoutStaff;

@property(nonatomic,assign)BOOL canceled;

@end
