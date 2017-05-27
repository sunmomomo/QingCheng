//
//  CheckinNotificationInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinNotificationInfo.h"

#define API @"/api/staffs/%ld/checkin/notification/configs/"

@implementation CheckinNotificationInfo

-(void)requsetDataResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"app_checkin_notification" forKey:@"keys"];
    
    weakTypesYF
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        __block NSUInteger count = 0;
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSMutableArray *gyms = [NSMutableArray array];
            
            [responseDic[@"data"][@"configs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Gym *gym = [[Gym alloc]init];
                
                gym.shopId = [obj[@"shop"][@"id"] integerValue];
                
                gym.name = obj[@"shop"][@"name"];
                
                gym.brand.brandId = [obj[@"brand"][@"id"] integerValue];
                
                gym.receiveNotification = [obj[@"value"] boolValue];
                
                if (gym.receiveNotification) {
                    count ++;
                }
                
                gym.notificationConfigId = [obj[@"id"] integerValue];
                
                [gyms addObject:gym];
                
            }];
            weakS.recieveNotifiCount = count;
            self.gyms = [gyms copy];
            
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

-(void)editNotificationSettingWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@[@{@"brand_id":[NSNumber numberWithInteger:gym.brand.brandId],@"shop_id":[NSNumber numberWithInteger:gym.shopId],@"value":gym.receiveNotification?@"1":@"0",@"id":[NSNumber numberWithInteger:gym.notificationConfigId]}] forKey:@"configs"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

@end
