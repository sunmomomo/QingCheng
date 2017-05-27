//
//  IntegralSettingInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralSettingInfo.h"

#define SwitchAPI @"/api/v2/staffs/%ld/modules/"

#define BasicAPI @"/api/v2/staffs/%ld/scores/rules/"

#define AwardAPI @"/api/v2/staffs/%ld/scores/favors/"

#define ChangeAPI @"/api/v2/staffs/%ld/scores/favors/%ld/"

#define CreateAPI @"/api/v2/staffs/%ld/scores/favors/"

@implementation IntegralSettingInfo

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.setting = [[IntegralSetting alloc]init];
        
    }
    
    return self;
    
}

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.setting = [[IntegralSetting alloc]init];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:SwitchAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.setting.used = [responseDic[@"data"][@"module"][@"score"] boolValue];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)requestBasicResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.setting = [[IntegralSetting alloc]init];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:BasicAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            NSDictionary *dict = responseDic[@"data"][@"rule"];
            
            self.setting.groupSetting.integral = [dict[@"teamarrange"] floatValue];
            
            self.setting.groupSetting.used = [dict[@"teamarrange_enable"]boolValue];
            
            self.setting.privateSetting.integral = [dict[@"priarrange"] floatValue];
            
            self.setting.privateSetting.used = [dict[@"priarrange_enable"]boolValue];
            
            self.setting.checkinSetting.integral = [dict[@"checkin"] floatValue];
            
            self.setting.checkinSetting.used = [dict[@"checkin_enable"]boolValue];
            
            self.setting.chargeSettings = [NSMutableArray array];
            
            self.setting.chargeUsed = [dict[@"buycard_enable"]boolValue];
            
            [dict[@"buycard"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                IntegralCardSetting *setting = [[IntegralCardSetting alloc]init];
                
                setting.fromPrice = [obj[@"start"] floatValue];
                
                setting.toPrice = [obj[@"end"] floatValue];
                
                setting.integral = [obj[@"money"] floatValue];
                
                [self.setting.chargeSettings addObject:setting];
                
            }];
            
            self.setting.rechargeSettings = [NSMutableArray array];
            
            self.setting.rechargeUsed = [dict[@"chargecard_enable"]boolValue];
            
            [dict[@"chargecard"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                IntegralCardSetting *setting = [[IntegralCardSetting alloc]init];
                
                setting.fromPrice = [obj[@"start"] floatValue];
                
                setting.toPrice = [obj[@"end"] floatValue];
                
                setting.integral = [obj[@"money"] floatValue];
                
                [self.setting.rechargeSettings addObject:setting];
                
            }];
            
            self.setting.changer = [[Staff alloc]init];
            
            self.setting.changer.name = dict[@"updated_by"][@"username"];
            
            self.setting.changer.phone = dict[@"updated_by"][@"phone"];
            
            self.setting.changeTime = [dict[@"updated_at"]stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)requestAwardResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.setting = [[IntegralSetting alloc]init];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:AwardAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.setting.normalAwards = [NSMutableArray array];

            self.setting.expireAwards = [NSMutableArray array];
            
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            
            df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            df.dateFormat = @"yyyy-MM-dd";
            
            [responseDic[@"data"][@"favors"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                IntegralAwardSetting *setting = [[IntegralAwardSetting alloc]init];
                
                setting.isActive = [obj[@"is_active"]boolValue];
                
                setting.start = [[obj[@"start"]componentsSeparatedByString:@"T"]firstObject];
                
                setting.end = [[obj[@"end"]componentsSeparatedByString:@"T"]firstObject];
                
                setting.settingId = [obj[@"id"]integerValue];
                
                setting.groupItem.times = [obj[@"teamarrange"] floatValue];
                
                setting.groupItem.used = [obj[@"teamarrange_enable"] boolValue];
                
                setting.privateItem.times = [obj[@"priarrange"] floatValue];
                
                setting.privateItem.used = [obj[@"priarrange_enable"] boolValue];
                
                setting.checkinItem.times = [obj[@"checkin"] floatValue];
                
                setting.checkinItem.used = [obj[@"checkin_enable"] boolValue];
                
                setting.chargeItem.times = [obj[@"buycard"] floatValue];
                
                setting.chargeItem.used = [obj[@"buycard_enable"] boolValue];
                
                setting.rechargeItem.times = [obj[@"chargecard"] floatValue];
                
                setting.rechargeItem.used = [obj[@"chargecard_enable"] boolValue];
                
                if (!setting.isActive) {
                    
                    [self.setting.expireAwards addObject:setting];
                    
                }else{
                    
                    [self.setting.normalAwards addObject:setting];
                    
                }
                
            }];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)uploadAward:(IntegralAwardSetting *)award result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithFloat:award.groupItem.times] forKey:@"teamarrange"];
    
    [para setParameter:[NSNumber numberWithBool:award.groupItem.used] forKey:@"teamarrange_enable"];
    
    [para setParameter:[NSNumber numberWithFloat:award.privateItem.times] forKey:@"priarrange"];
    
    [para setParameter:[NSNumber numberWithBool:award.privateItem.used] forKey:@"priarrange_enable"];
    
    [para setParameter:[NSNumber numberWithFloat:award.checkinItem.times] forKey:@"checkin"];
    
    [para setParameter:[NSNumber numberWithBool:award.checkinItem.used] forKey:@"checkin_enable"];
    
    [para setParameter:[NSNumber numberWithFloat:award.chargeItem.times] forKey:@"buycard"];
    
    [para setParameter:[NSNumber numberWithBool:award.chargeItem.used] forKey:@"buycard_enable"];
    
    [para setParameter:[NSNumber numberWithFloat:award.rechargeItem.times] forKey:@"chargecard"];
    
    [para setParameter:[NSNumber numberWithBool:award.rechargeItem.used] forKey:@"chargecard_enable"];
    
    [para setParameter:[NSString stringWithFormat:@"%@T00:00:00",award.start] forKey:@"start"];
    
    [para setParameter:[NSString stringWithFormat:@"%@T00:00:00",award.end] forKey:@"end"];
    
    if (award.settingId) {
    
        [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)award.settingId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"] integerValue] == 200) {
                
                if (self.callBack) {
                    
                    self.callBack(YES,nil);
                    
                    self.callBack = nil;
                    
                }
                
            }else{
                
                if (self.callBack) {
                    
                    self.callBack(NO,responseDic[@"msg"]);
                    
                    self.callBack = nil;
                    
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.callBack) {
                
                self.callBack(NO,error);
                
                self.callBack = nil;
                
            }
            
        }];
        
    }else{
        
        [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CreateAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"] integerValue] == 200) {
                
                if (self.callBack) {
                    
                    self.callBack(YES,nil);
                    
                    self.callBack = nil;
                    
                }
                
            }else{
                
                if (self.callBack) {
                    
                    self.callBack(NO,responseDic[@"msg"]);
                    
                    self.callBack = nil;
                    
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.callBack) {
            
                self.callBack(NO,error);
                
                self.callBack = nil;
                
            }
            
        }];
        
    }
    
}

-(void)deleteAward:(IntegralAwardSetting *)award result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_active"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)award.settingId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }

    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)uploadBasicSetting:(IntegralSetting *)setting result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithBool:setting.groupSetting.used] forKey:@"teamarrange_enable"];
    
    [para setParameter:[NSNumber numberWithFloat:setting.groupSetting.integral] forKey:@"teamarrange"];
    
    [para setParameter:[NSNumber numberWithBool:setting.privateSetting.used] forKey:@"priarrange_enable"];
    
    [para setParameter:[NSNumber numberWithFloat:setting.privateSetting.integral] forKey:@"priarrange"];
    
    [para setParameter:[NSNumber numberWithBool:setting.checkinSetting.used] forKey:@"checkin_enable"];
    
    [para setParameter:[NSNumber numberWithFloat:setting.checkinSetting.integral] forKey:@"checkin"];
    
    [para setParameter:[NSNumber numberWithBool:setting.chargeUsed] forKey:@"buycard_enable"];
    
    NSMutableArray *charges = [NSMutableArray array];
    
    for (IntegralCardSetting *cardSetting in setting.chargeSettings) {
        
        [charges addObject:@{@"start":[NSNumber numberWithFloat:cardSetting.fromPrice],@"end":[NSNumber numberWithFloat:cardSetting.toPrice],@"money":[NSNumber numberWithFloat:cardSetting.integral]}];
        
    }
    
    [para setParameter:charges forKey:@"buycard"];
    
    [para setParameter:[NSNumber numberWithBool:setting.rechargeUsed] forKey:@"chargecard_enable"];
    
    NSMutableArray *recharges = [NSMutableArray array];
    
    for (IntegralCardSetting *cardSetting in setting.rechargeSettings) {
        
        [recharges addObject:@{@"start":[NSNumber numberWithFloat:cardSetting.fromPrice],@"end":[NSNumber numberWithFloat:cardSetting.toPrice],@"money":[NSNumber numberWithFloat:cardSetting.integral]}];
        
    }
    
    [para setParameter:recharges forKey:@"chargecard"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:BasicAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)changeUsed:(BOOL)used result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithBool:used] forKey:@"score"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:SwitchAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]== 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

@end
