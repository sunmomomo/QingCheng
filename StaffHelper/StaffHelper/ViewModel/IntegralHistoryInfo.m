//
//  IntegralHistoryInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralHistoryInfo.h"

#define IntegralAPI @"/api/v2/staffs/%ld/users/%ld/scores/"

#define API @"/api/v2/staffs/%ld/users/%ld/scores/histories/"

@interface IntegralHistoryInfo ()

{
    
    NSInteger _page;
    
    NSInteger _totalPages;
    
}

@end

@implementation IntegralHistoryInfo

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        _page = 0;
        
        _totalPages = 1;
        
        self.histories = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(void)requestWithStudent:(Student *)student result:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:IntegralAPI,StaffId,(long)student.stuId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.integral = [responseDic[@"data"][@"shopbrand"][@"score"] floatValue];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

-(void)requestHistoriesWithStudent:(Student *)student result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.histories = [NSMutableArray array];
    
    if (_page>=_totalPages) {
        
        if (self.callBack) {
            self.callBack(YES,nil);
        }
        
        return;
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:@"-created_at" forKey:@"order_by"];
    
    [para setParameter:[NSNumber numberWithInteger:_page+1] forKey:@"page"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)student.stuId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            _page = [responseDic[@"data"][@"current_page"] integerValue];
            
            _totalPages = [responseDic[@"data"][@"pages"] integerValue];
            
            [responseDic[@"data"][@"histories"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                IntegralHistory *history = [[IntegralHistory alloc]init];
                
                history.historyId = [obj[@"id"] integerValue];
                
                history.place = obj[@"shop"][@"name"];
                
                history.integral = [obj[@"change_score"] floatValue];
                
                history.currentIntegral = [obj[@"after_score"] floatValue];
                
                history.staffName = obj[@"created_by"][@"username"];
                
                if ([obj[@"type"] isEqualToString:@"teamarrange"]) {
                    
                    history.type = IntegralHistoryTypeGroup;
                    
                    history.title = @"团课预约";
                    
                }else if ([obj[@"type"] isEqualToString:@"teamarrange_cancel"]) {
                    
                    history.type = IntegralHistoryTypeGroupCancel;
                    
                    history.title = @"团课取消";
                    
                }else if ([obj[@"type"] isEqualToString:@"priarrange"]) {
                    
                    history.type = IntegralHistoryTypePrivate;
                    
                    history.title = @"私教预约";
                    
                }else if ([obj[@"type"] isEqualToString:@"priarrange_cancel"]) {
                    
                    history.type = IntegralHistoryTypePrivateCancel;
                    
                    history.title = @"私教取消";
                    
                }else if ([obj[@"type"] isEqualToString:@"checkin"]) {
                    
                    history.type = IntegralHistoryTypeCheckin;
                    
                    history.title = @"入场签到";
                    
                }else if ([obj[@"type"] isEqualToString:@"checkin_cancel"]) {
                    
                    history.type = IntegralHistoryTypeCheckinCancel;
                    
                    history.title = @"撤销签到";
                    
                }else if ([obj[@"type"] isEqualToString:@"buycard"]) {
                    
                    history.type = IntegralHistoryTypeCharge;
                    
                    history.title = @"新购会员卡";
                    
                }else if ([obj[@"type"] isEqualToString:@"chargecard"]) {
                    
                    history.type = IntegralHistoryTypeRecharge;
                    
                    history.title = @"会员卡续费";
                    
                }else if ([obj[@"type"] isEqualToString:@"add"]) {
                    
                    history.type = IntegralHistoryTypeAdd;
                    
                    history.title = @"添加";
                    
                }else if ([obj[@"type"] isEqualToString:@"dec"]) {
                    
                    history.type = IntegralHistoryTypeSub;
                    
                    history.title = @"扣除";
                    
                }
                
                history.award = [obj[@"favor_id"] integerValue]?[NSString stringWithFormat:@"奖励规则%ld",(long)[obj[@"favor_id"] integerValue]]:@"无";
                
                history.summary = [obj[@"remarks"]length]?obj[@"remarks"]:@"无";
                
                history.time = [obj[@"created_at"]stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                
                [self.histories addObject:history];
                
            }];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

-(void)changeIntegral:(float)integral withStudent:(Student *)student andSummary:(NSString *)summary result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:summary forKey:@"remarks"];
    
    [para setParameter:[NSNumber numberWithFloat:integral] forKey:@"change_score"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)student.stuId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

@end
