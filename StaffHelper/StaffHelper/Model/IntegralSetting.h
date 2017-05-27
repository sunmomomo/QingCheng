//
//  IntegralSetting.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralCourseSetting : NSObject

@property(nonatomic,assign)float integral;

@property(nonatomic,assign)BOOL used;

@end

@interface IntegralCardSetting : NSObject

@property(nonatomic,assign)float fromPrice;

@property(nonatomic,assign)float toPrice;

@property(nonatomic,assign)float integral;

@end

@interface IntegralAwardItem : NSObject

@property(nonatomic,assign)BOOL used;

@property(nonatomic,assign)float times;

@end

@interface IntegralAwardSetting : NSObject

@property(nonatomic,assign)BOOL isActive;

@property(nonatomic,assign)NSInteger settingId;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,strong)IntegralAwardItem *groupItem;

@property(nonatomic,strong)IntegralAwardItem *privateItem;

@property(nonatomic,strong)IntegralAwardItem *checkinItem;

@property(nonatomic,strong)IntegralAwardItem *chargeItem;

@property(nonatomic,strong)IntegralAwardItem *rechargeItem;

@end

@interface IntegralSetting : NSObject

@property(nonatomic,assign)BOOL used;

@property(nonatomic,strong)IntegralCourseSetting *groupSetting;

@property(nonatomic,strong)IntegralCourseSetting *privateSetting;

@property(nonatomic,strong)IntegralCourseSetting *checkinSetting;

@property(nonatomic,strong)NSMutableArray *chargeSettings;

@property(nonatomic,assign)BOOL chargeUsed;

@property(nonatomic,assign)BOOL rechargeUsed;

@property(nonatomic,strong)NSMutableArray *rechargeSettings;

@property(nonatomic,strong)NSMutableArray *normalAwards;

@property(nonatomic,strong)NSMutableArray *expireAwards;

@property(nonatomic,strong)Staff *changer;

@property(nonatomic,copy)NSString *changeTime;

@end
