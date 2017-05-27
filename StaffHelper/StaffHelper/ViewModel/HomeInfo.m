//
//  HomeInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "HomeInfo.h"

#import "YFDateService.h"

#import "YFHomeLineChartModel.h"

#import "YFStaticsSubModel.h"

#define API @"/api/v2/staffs/%ld/ios/welcome/"

@implementation HomeInfo

-(void)requestSuccess:(void (^)(NSInteger))success failure:(void (^)(NSInteger))failure
{
    
    if (!StaffId || ![BRANDID integerValue]) {
        
        if (self.callBackSuccess) {
            
            self.callBackFailure();
            
            self.callBackSuccess = nil;
            
            self.callBackFailure = nil;
            
        }
        
        return;
        
    }
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:@{@"brand_id":BRANDID} success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSDictionary *dataDict = responseDic[@"data"];
            
            self.totalServices = [dataDict[@"services_total_count"] integerValue];
            
            NSMutableArray *dateArray = [NSMutableArray array];
            
            for (NSInteger i = 6; i >= 0; i --)
            {
                NSString *string = [YFDateService getDateFromDays:-i formating:nil];
                [dateArray addObject:string];
            }
            
            if ([dataDict[@"stat"] isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *statDict = dataDict[@"stat"];
                
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
                
                self.stats = statArray;
                
            }
            
            self.banners = dataDict[@"banners"];
            
            self.haveNew = [dataDict[@"qingcheng_activity_count"] integerValue]?YES:NO;
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess(self.totalServices);
                
                self.callBackSuccess = nil;
                
                self.callBackFailure = nil;
                
            }
            
        }else
        {
         
            if (self.callBackFailure) {
                
                self.callBackFailure([responseDic[@"error_code"] integerValue]);
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBackFailure) {
            
            self.callBackFailure(-1);
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}

@end
