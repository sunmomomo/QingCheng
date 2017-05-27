//
//  GymDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GymDetailInfo.h"

#import "UIColor+Hex.h"

#import "DistrictInfo.h"

#import "YFDateService.h"

#import "YFHomeLineChartModel.h"

#import "YFStaticsSubModel.h"

#define API @"/api/v2/staffs/%ld/gyms/welcome/"

#define kRenewAPI @"/api/gyms/orders/"

#define QuitAPI @"/api/v2/staffs/%ld/dimission/"

#define AllAPI @"/api/staffs/%ld/shops/detail/"

@implementation GymDetailInfo

-(void)requestWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *,NSInteger))result
{
    
    self.callBack = result;
    
    if (!StaffId) {
        
        self.haveNew = NO;
        
        if (self.callBack) {
            
            self.callBack(NO,nil,-1);
            
            self.callBack = nil;
            
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
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }
    
    self.gym = [gym copy];

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSDictionary *gymDict = responseDic[@"data"][@"gym"];
            
            self.haveNew = [responseDic[@"data"][@"qingcheng_activity_count"] integerValue]?YES:NO;
            
            NSMutableArray *dateArray = [NSMutableArray array];
            
            for (NSInteger i = 6; i >= 0; i --)
            {
                NSString *string = [YFDateService getDateFromDays:-i formating:nil];
                [dateArray addObject:string];
            }
            
            if ([responseDic[@"data"][@"stat"] isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *statDict = responseDic[@"data"][@"stat"];
                
                NSMutableArray *statArray = [NSMutableArray array];
                
                if (statDict[@"new_sells"]) {
                    
                    YFHomeLineChartModel *linemodel = [[YFHomeLineChartModel alloc]init];
                    
                    linemodel.chartDesStr = @"会员卡销售";
                    
                    linemodel.defaultColor = UIColorFromRGB(0xF8B359);
                    
                    YFStaticsModel *model = [YFStaticsModel defaultWithDic:statDict[@"new_sells"]];
                    // 填满 没有数据的 地方
                    [model fullEmptyArrayWithDateArray:dateArray];
                    
                    for (YFStaticsSubModel *submodel in model.arrayModels) {
                        
                        submodel.count = [NSString stringWithFormat:@"%.2f元",submodel.count.doubleValue];
                        
                    }
                    
                    linemodel.chartStaticModel = model;
                    
                    [statArray addObject:linemodel];
                    
                }
                
                if (statDict[@"new_orders"]) {
                    
                    YFHomeLineChartModel *linemodel = [[YFHomeLineChartModel alloc]init];
                    
                    linemodel.chartDesStr = @"课程报表";
                    
                    linemodel.defaultColor = UIColorFromRGB(0x0DB14B);
                    
                    YFStaticsModel *model = [YFStaticsModel defaultWithDic:statDict[@"new_orders"]];
                    // 填满 没有数据的 地方
                    [model fullEmptyArrayWithDateArray:dateArray];
                    
                    for (YFStaticsSubModel *submodel in model.arrayModels) {
                        
                        submodel.count = [submodel.count stringByAppendingString:@"人次"];
                        
                    }
                    
                    linemodel.chartStaticModel = model;
                    
                    [statArray addObject:linemodel];
                    
                }
                
                if (statDict[@"new_checkin"]) {
                    
                    YFHomeLineChartModel *linemodel = [[YFHomeLineChartModel alloc]init];
                    
                    linemodel.chartDesStr = @"签到报表";
                    
                    linemodel.defaultColor = UIColorFromRGB(0x8CB5BA);
                    
                    YFStaticsModel *model = [YFStaticsModel defaultWithDic:statDict[@"new_checkin"]];
                    // 填满 没有数据的 地方
                    [model fullEmptyArrayWithDateArray:dateArray];
                    
                    for (YFStaticsSubModel *submodel in model.arrayModels) {
                        
                        submodel.count = [submodel.count stringByAppendingString:@"人次"];
                        
                    }
                    
                    linemodel.chartStaticModel = model;
                    
                    [statArray addObject:linemodel];
                    
                }
                
                if (statDict[@"new_users"]) {
                    
                    YFHomeLineChartModel *linemodel = [[YFHomeLineChartModel alloc]init];
                    
                    linemodel.chartDesStr = @"新增注册";
                    
                    linemodel.defaultColor = UIColorFromRGB(0x6EB8F1);
                    
                    YFStaticsModel *model = [YFStaticsModel defaultWithDic:statDict[@"new_users"]];
                    // 填满 没有数据的 地方
                    [model fullEmptyArrayWithDateArray:dateArray];
                    
                    for (YFStaticsSubModel *submodel in model.arrayModels) {
                        
                        submodel.count = [submodel.count stringByAppendingString:@"人"];
                        
                    }
                    
                    linemodel.chartStaticModel = model;
                    
                    [statArray addObject:linemodel];
                    
                }
                
                self.stats = statArray;
                
            }
            
            self.banners = responseDic[@"data"][@"banners"];
            
            
            [self.gym resultJson:gymDict];
            
            
            // ---------
            self.gym.previewURL = [NSURL URLWithString:responseDic[@"data"][@"welcome_url"]];
            
            self.gym.hintURL = [NSURL URLWithString:responseDic[@"data"][@"hint_url"]];
            //-----
        
            
            self.gym.isFirstShop = [responseDic[@"data"][@"recharge"][@"is_first_shop"] boolValue];
            
            self.gym.isRecharged = [responseDic[@"data"][@"recharge"][@"is_recharged"] boolValue];
            
            self.gym.renewPrice = [responseDic[@"data"][@"recharge"][@"recharge_price"] integerValue];
            
            if (!self.gym.shopId && gym.shopId) {
                
                self.gym.shopId = gym.shopId;
                
            }
            
            if (!self.gym.brand.brandId && gym.brand.brandId) {
                
                self.gym.brand.brandId = gym.brand.brandId;
                
            }
            
            if (!self.gym.gymId && gym.gymId) {
                
                self.gym.gymId = gym.gymId;
                
            }
            
            if (!self.gym.type.length && gym.type.length) {
                
                self.gym.type = gym.type;
                
            }
            
            
            self.gym.admin = [[Staff alloc]init];
            
            NSDictionary *adminDict = responseDic[@"data"][@"superuser"];
            
            self.gym.admin.iconUrl = [NSURL URLWithString:adminDict[@"avatar"]];
            
            self.gym.admin.name = adminDict[@"username"];
            
            self.gym.admin.staffId = [adminDict[@"id"]integerValue];
            
            self.gym.admin.sex = [adminDict[@"gender"] integerValue];
            
            self.gym.admin.phone = adminDict[@"phone"];
            
            self.gym.admin.country = [[[CountryPhoneInfo alloc]init]getCountryWithCode:adminDict[@"area_code"]];
            
            AppGym = [self.gym copy];
            
            if (self.callBack) {
                
                self.callBack(YES,nil,0);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"],[responseDic[@"error_code"] integerValue]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error,-1);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)renewGym:(Gym *)gym payWay:(PayWay)way result:(void (^)(BOOL, NSString *))result
{
    
    self.renewCallBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }

    if (way == PayWayWeChat) {
        
        [para setParameter:@"12" forKey:@"channel"];
        
    }
    
    [para setParameter:WXKEY forKey:@"app_id"];
    
    [MOAFHelp  AFPostHost:ROOT bindPath:kRenewAPI postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.renewCallBack(YES,responseDic[@"data"][@"url"]);
            
        }else{
            
            self.renewCallBack(NO,nil);
            
            self.renewCallBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.renewCallBack(NO,nil);
        
        self.renewCallBack = nil;
        
    }];
    
}

-(void)quitGymResult:(void (^)(BOOL, NSString *,NSInteger))result
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
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:QuitAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil,0);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"],[responseDic[@"error_code"] integerValue]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error,-1);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)requestWechatResult:(void (^)(BOOL, NSString *))result
{
    
    self.normalCallBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:AllAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSDictionary *dict = responseDic[@"data"][@"shop"];
            
            self.gym = [[Gym alloc]init];
            
            self.gym.wechatImg = [NSURL URLWithString:dict[@"weixin_image"]];
            
            self.gym.wechatName = dict[@"weixin"];
            
            self.gym.wechatSuccess = [dict[@"weixin_success"] boolValue];
            
            if (self.normalCallBack) {
                
                self.normalCallBack(YES,nil);
                
            }
            
        }else{
            
            if (self.normalCallBack) {
                
                self.normalCallBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.normalCallBack) {
            
            self.normalCallBack(NO,error);
            
        }
        
    }];
    
}

-(void)uploadWechatImg:(NSURL *)wechatImg andWechatName:(NSString *)wechatName result:(void (^)(BOOL, NSString *))result
{
    
    self.normalCallBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:wechatName forKey:@"weixin"];
    
    [para setParameter:wechatImg.absoluteString forKey:@"weixin_image"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"weixin_success"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:AllAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.normalCallBack) {
                
                self.normalCallBack(YES,nil);
            }
        }else{
            
            if (self.normalCallBack) {
                
                self.normalCallBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.normalCallBack) {
            
            self.normalCallBack(NO,error);
            
        }
        
    }];
    
}

-(void)gymTryResult:(void (^)(BOOL, NSString *))result
{
    
    self.normalCallBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
}

@end
