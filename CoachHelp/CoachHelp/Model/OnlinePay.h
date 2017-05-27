//
//  OnlinePay.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    OnlinePayTypeWechat,
} OnlinePayType;

@interface OnlinePay : NSObject

@property(nonatomic,assign)BOOL isUsed;

@property(nonatomic,assign)float cost;

@property(nonatomic,copy)NSString *costStr;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)OnlinePayType type;

@property(nonatomic,assign)BOOL astrict;

@property(nonatomic,assign)NSInteger astrictNumber;

@property(nonatomic,assign)BOOL astrictNewLogin;

@property(nonatomic,assign)BOOL astrictFollowing;

@property(nonatomic,assign)BOOL astrictNormal;

@end
