//
//  CardKindInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindInfo.h"

#import "UIColor+Hex.h"

#define kUpdateAPI @"/api/staffs/%ld/cardtpls/%ld/"

#define kUpdateGymAPI @"/api/staffs/%ld/cardtpls/%ld/shops/"

#define kCreateAPI @"/api/staffs/%ld/cardtpls/"

#define kRenewAPI @"/api/v2/staffs/%ld/cardtpls/%ld/recovery/"

@implementation CardKindInfo

-(void)requestDataWithCardKind:(CardKind *)cardKind result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kUpdateAPI,StaffId,(long)cardKind.cardKindId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSDictionary *dict = responseDic[@"data"][@"card_tpl"];
            
            cardKind.color = [UIColor colorWithHexString:dict[@"color"]];
            
            cardKind.dayTimes = [dict[@"day_times"] integerValue];
            
            cardKind.cardKindId = [dict[@"id"] integerValue];
            
            cardKind.summary = dict[@"description"];
            
            cardKind.monthTimes = [dict[@"month_times"] integerValue];
            
            cardKind.cardKindName = dict[@"name"];
            
            cardKind.preTimes = [dict[@"pre_times"] integerValue];
            
            cardKind.type = [dict[@"type"] integerValue];
            
            cardKind.typeName = dict[@"type_name"];
            
            cardKind.weekTimes = [dict[@"week_times"] integerValue];
            
            cardKind.isLimit = [dict[@"is_limit"] boolValue];
            
            cardKind.maxCardCount = [dict[@"buy_limit"] integerValue];
            
            cardKind.state = [dict[@"is_enable"]boolValue]?CardKindStateNormal:CardKindStateStop;
            
            if (cardKind.isLimit) {
                
                cardKind.astrict = cardKind.preTimes?(cardKind.dayTimes||cardKind.weekTimes||cardKind.monthTimes)?[NSString stringWithFormat:@"可提前预约%ld节课，每%@共计可上%ld节课",(long)cardKind.preTimes,cardKind.dayTimes?@"天":cardKind.weekTimes?@"周":@"月",(long)(cardKind.dayTimes?cardKind.dayTimes:cardKind.weekTimes?cardKind.weekTimes:cardKind.monthTimes)]:[NSString stringWithFormat:@"可提前预约%ld节课",(long)cardKind.preTimes]:(cardKind.dayTimes||cardKind.weekTimes||cardKind.monthTimes)?[NSString stringWithFormat:@"每%@共计可上%ld节课",cardKind.dayTimes?@"天":cardKind.weekTimes?@"周":@"月",(long)(cardKind.dayTimes?cardKind.dayTimes:cardKind.weekTimes?cardKind.weekTimes:cardKind.monthTimes)]:@"";
                
                if (cardKind.maxCardCount) {
                    
                    if (cardKind.astrict.length) {
                        
                        cardKind.astrict = [NSString stringWithFormat:@"%@，每个会员限购%ld张",cardKind.astrict,(long)cardKind.maxCardCount];
                        
                    }else{
                        
                        cardKind.astrict = [NSString stringWithFormat:@"每个会员限购%ld张",(long)cardKind.maxCardCount];
                        
                    }
                    
                }
            
            }else
            {
                
                cardKind.astrict = nil;
                
            }
            
            NSMutableArray *options = [NSMutableArray array];
            
            [dict[@"options"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Spec *spec = [[Spec alloc]init];
                
                CardKind *specCardKind = [[CardKind alloc]init];
                
                specCardKind.cardKindName = obj[@"card_tpl"][@"name"];
                
                specCardKind.cardKindId = [obj[@"card_tpl"][@"id"] integerValue];
                
                specCardKind.type = [obj[@"card_tpl"][@"type"] integerValue];
                
                spec.cardKind =  specCardKind;
                
                spec.canCreate = [obj[@"can_create"] boolValue];
                
                spec.canRecharge = [obj[@"can_charge"] boolValue];
                
                spec.charge = [obj[@"charge"] stringValue];
                
                spec.price = [obj[@"price"] stringValue];
                
                spec.checkValid = [obj[@"limit_days"] boolValue];
                
                spec.validTime = [obj[@"days"] integerValue];
                
                spec.specId = [obj[@"id"] integerValue];
                
                spec.summary = obj[@"description"];
                
                spec.onlyStaffCanSee = [obj[@"for_staff"]boolValue];
                
                [options addObject:spec];
                
            }];
            
            cardKind.specs = options;
            
            NSMutableArray *gyms = [NSMutableArray array];
            
            [dict[@"shops"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Gym *gym = [[Gym alloc]init];
                
                gym.shopId = [obj[@"id"] integerValue];
                
                gym.name = obj[@"name"];
                
                [gyms addObject:gym];
                
            }];
            
            cardKind.gyms = gyms;
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)createCardKind:(CardKind *)cardKind result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:cardKind.cardKindName forKey:@"name"];
    
    [para setInteger:cardKind.type forKey:@"type"];
    
    [para setInteger:cardKind.isLimit forKey:@"is_limit"];
    
    [para setParameter:cardKind.summary forKey:@"description"];
    
    if (cardKind.isLimit) {
        
        [para setInteger:cardKind.preTimes forKey:@"pre_times"];
        
        [para setInteger:cardKind.dayTimes forKey:@"day_times"];
        
        [para setInteger:cardKind.weekTimes forKey:@"week_times"];
        
        [para setInteger:cardKind.monthTimes forKey:@"month_times"];
        
        [para setInteger:cardKind.maxCardCount forKey:@"buy_limit"];
        
    }else
    {
        
        [para setInteger:0 forKey:@"pre_times"];
        
        [para setInteger:0 forKey:@"day_times"];
        
        [para setInteger:0 forKey:@"week_times"];
        
        [para setInteger:0 forKey:@"month_times"];
        
        [para setInteger:0 forKey:@"buy_limit"];
        
    }
    
    NSString *shops = @"";
    
    for (NSInteger i = 0;i<cardKind.gyms.count;i++) {
        
        Gym *gym = cardKind.gyms[i];
        
        shops = [shops stringByAppendingString:[NSString stringWithInteger:gym.shopId]];
        
        if (i<cardKind.gyms.count-1) {
            
            shops = [shops stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:shops forKey:@"shops"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kCreateAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
                
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
                
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
            
        self.callBack = nil;
        
    }];
    
}

-(void)updateCardKind:(CardKind *)cardKind result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:cardKind.cardKindName forKey:@"name"];
    
    [para setInteger:cardKind.type forKey:@"type"];
    
    [para setInteger:cardKind.isLimit forKey:@"is_limit"];
    
    [para setParameter:cardKind.summary forKey:@"description"];
    
    if (cardKind.isLimit) {
        
        [para setInteger:cardKind.preTimes forKey:@"pre_times"];
        
        [para setInteger:cardKind.dayTimes forKey:@"day_times"];
        
        [para setInteger:cardKind.weekTimes forKey:@"week_times"];
        
        [para setInteger:cardKind.monthTimes forKey:@"month_times"];
        
        [para setInteger:cardKind.maxCardCount forKey:@"buy_limit"];
        
    }else
    {
        
        [para setInteger:0 forKey:@"pre_times"];
        
        [para setInteger:0 forKey:@"day_times"];
        
        [para setInteger:0 forKey:@"week_times"];
        
        [para setInteger:0 forKey:@"month_times"];
        
        [para setInteger:0 forKey:@"buy_limit"];
        
    }
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:kUpdateAPI,StaffId,(long)cardKind.cardKindId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)updateCardKindGyms:(CardKind *)cardKind result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    NSString *shops = @"";
    
    for (NSInteger i = 0;i<cardKind.gyms.count;i++) {
        
        Gym *gym = cardKind.gyms[i];
        
        shops = [shops stringByAppendingString:[NSString stringWithInteger:gym.shopId]];
        
        if (i<cardKind.gyms.count-1) {
            
            shops = [shops stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:shops forKey:@"shops"];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:kUpdateGymAPI,StaffId,(long)cardKind.cardKindId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)deleteCardKind:(CardKind *)cardKind result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:kUpdateAPI,StaffId,(long)cardKind.cardKindId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)renewCardKind:(CardKind *)cardKind result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kRenewAPI,StaffId,(long)cardKind.cardKindId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

@end
