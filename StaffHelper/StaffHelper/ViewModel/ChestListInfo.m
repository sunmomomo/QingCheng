//
//  ChestListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestListInfo.h"

#define API @"/api/v2/staffs/%ld/locker/regions/"

#define ChestAPI @"/api/v2/staffs/%ld/lockers/"

#define EditAPI @"/api/v2/staffs/%ld/lockers/%ld/"

@implementation ChestListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)requestDataResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.areas = [NSMutableArray array];
            
            [responseDic[@"data"][@"locker_regions"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                ChestArea *area = [[ChestArea alloc]init];
                
                area.areaId = [obj[@"id"] integerValue];
                
                area.areaName = obj[@"name"];
                
                [self.areas addObject:area];
                
            }];
            
            Parameters *chestPara = [[Parameters alloc]init];
            
            if (AppGym.gymId) {
                
                [chestPara setParameter:AppGym.type forKey:@"model"];
                
                [chestPara setInteger:AppGym.gymId forKey:@"id"];
                
            }else{
                
                [chestPara setInteger:AppGym.brand.brandId forKey:@"brand_id"];
                
                [chestPara setInteger:AppGym.shopId forKey:@"shop_id"];
                
            }
            
            [chestPara setParameter:@"1" forKey:@"show_all"];
            
            [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:ChestAPI,StaffId] param:chestPara.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                if ([responseDic[@"status"] integerValue] == 200) {
                    
                    [responseDic[@"data"][@"lockers"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Chest *chest = [[Chest alloc]init];
                        
                        chest.chestId = [obj[@"id"] integerValue];
                        
                        chest.name = obj[@"name"];
                        
                        chest.isUsed = [obj[@"is_used"] boolValue];
                        
                        chest.area.areaId = [obj[@"region"][@"id"] integerValue];
                        
                        chest.area.areaName = obj[@"region"][@"name"];
                        
                        chest.longTermUse = [obj[@"is_long_term_borrow"] boolValue];
                        
                        for (ChestArea *area in self.areas) {
                            
                            if (area.areaId == chest.area.areaId) {
                                
                                [area.chests addObject:chest];
                                
                            }
                            
                        }
                        
                        if ([obj[@"user"][@"id"] integerValue]) {
                            
                            Student *user = [[Student alloc]init];
                            
                            user.stuId = [obj[@"user"][@"id"] integerValue];
                            
                            user.name = obj[@"user"][@"username"];
                            
                            user.phone = obj[@"user"][@"phone"];
                            
                            chest.borrowUser = user;
                            
                        }
                        
                        if (chest.longTermUse) {
                            
                            chest.start = [obj[@"start"]length]?[obj[@"start"] substringToIndex:10]:@"";
                            
                            chest.end = [obj[@"end"]length]?[obj[@"end"] substringToIndex:10]:@"";
                            
                            chest.remain = [obj[@"balance"] integerValue];
                            
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

-(void)createChest:(Chest *)chest result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [para setParameter:chest.name forKey:@"name"];
    
    [para setInteger:chest.area.areaId forKey:@"region_id"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:ChestAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
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

-(void)editChest:(Chest *)chest result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [para setParameter:chest.name forKey:@"name"];
    
    [para setInteger:chest.area.areaId forKey:@"region_id"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:EditAPI,StaffId,(long)chest.chestId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
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

-(void)deleteChest:(Chest *)chest result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:EditAPI,StaffId,(long)chest.chestId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
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
