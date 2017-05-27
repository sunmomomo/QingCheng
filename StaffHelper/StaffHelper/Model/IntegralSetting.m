//
//  IntegralSetting.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralSetting.h"

@implementation IntegralCourseSetting

-(id)copy
{
    
    IntegralCourseSetting *setting = [[IntegralCourseSetting alloc]init];
    
    setting.integral = self.integral;
    
    setting.used = self.used;
    
    return setting;
    
}

@end

@implementation IntegralCardSetting

@end

@implementation IntegralAwardItem

-(id)copy
{
    
    IntegralAwardItem *item = [[IntegralAwardItem alloc]init];
    
    item.used = self.used;
    
    item.times = self.times;
    
    return item;
    
}

@end

@implementation IntegralAwardSetting

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.groupItem = [[IntegralAwardItem alloc]init];
        
        self.privateItem = [[IntegralAwardItem alloc]init];
        
        self.checkinItem = [[IntegralAwardItem alloc]init];
        
        self.chargeItem = [[IntegralAwardItem alloc]init];
        
        self.rechargeItem = [[IntegralAwardItem alloc]init];
        
    }
    
    return self;
    
}

-(id)copy
{
    
    IntegralAwardSetting *setting = [[IntegralAwardSetting alloc]init];
    
    setting.isActive = self.isActive;
    
    setting.settingId = self.settingId;
    
    setting.groupItem = [self.groupItem copy];
    
    setting.privateItem = [self.privateItem copy];
    
    setting.checkinItem = [self.checkinItem copy];
    
    setting.checkinItem = [self.chargeItem copy];
    
    setting.rechargeItem = [self. rechargeItem copy];
    
    setting.start = self.start;
    
    setting.end = self.end;
    
    return setting;
    
}

@end

@implementation  IntegralSetting

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.groupSetting = [[IntegralCourseSetting alloc]init];
        
        self.privateSetting = [[IntegralCourseSetting alloc]init];
        
        self.checkinSetting = [[IntegralCourseSetting alloc]init];
        
        self.chargeSettings = [NSMutableArray array];
        
        self.rechargeSettings = [NSMutableArray array];
        
        self.normalAwards = [NSMutableArray array];
        
        self.expireAwards = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(id)copy
{
    
    IntegralSetting *setting = [[IntegralSetting alloc]init];
    
    setting.chargeUsed = self.chargeUsed;
    
    setting.changer = [[Staff alloc]init];
    
    setting.changer.name = self.changer.name;
    
    setting.changer.staffId = self.changer.staffId;
    
    setting.changeTime = self.changeTime;
    
    setting.rechargeUsed = self.rechargeUsed;
    
    setting.chargeSettings = self.chargeSettings;
    
    setting.rechargeSettings = [self.rechargeSettings mutableCopy];
    
    setting.normalAwards = [self.normalAwards mutableCopy];
    
    setting.expireAwards = [self.expireAwards mutableCopy];
    
    setting.groupSetting = [self.groupSetting copy];
    
    setting.privateSetting = [self.privateSetting copy];
    
    setting.checkinSetting = [self.checkinSetting copy];
    
    return setting;
    
}

@end
