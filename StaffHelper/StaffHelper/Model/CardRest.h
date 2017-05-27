//
//  CardRest.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

typedef enum : NSUInteger {
    CardRestStatusNormal=1,
    CardRestStatusStop=2,// 已删除
    CardRestStatusAreadyBackFromLeave=3,//已提前销假
    CardRestStatusEndRest=4//请假已结束
} CardRestStatus;

@interface CardRest : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,assign)NSInteger restId;

@property(nonatomic,copy)NSString *message;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,copy)NSString *remark;

@property(nonatomic,copy)NSString *staffName;

@property(nonatomic,assign)NSInteger price;

@property(nonatomic,copy)NSString *operateTime;

@property(nonatomic,copy)NSString *cancelTime;

@property(nonatomic,strong)Card *card;

@property(nonatomic,assign)CardRestStatus status;

/**
 * 备注 高度
 */
@property(nonatomic, assign)CGFloat remarkHeight;

@property(nonatomic, assign)CGFloat cellHeight;

-(void)deleteRestResult:(void(^)(BOOL success,NSString *error))result;

@end
