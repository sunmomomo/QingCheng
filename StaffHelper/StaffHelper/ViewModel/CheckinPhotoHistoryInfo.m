//
//  CheckinPhotoHistoryInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinPhotoHistoryInfo.h"

#define API @"/api/staffs/%ld/user/photos/"

#define kPhotoAPI @"/api/staffs/%ld/user/photos/"

@implementation CheckinPhotoHistoryInfo

-(void)requestDataWithStudent:(Student *)stu result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:stu.stuId forKey:@"user_id"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.histories = [NSMutableArray array];
            
            [responseDic[@"data"][@"photos"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CheckinPhotoHistory *history = [[CheckinPhotoHistory alloc]init];
                
                if ([obj[@"created_at"]length]) {
                    
                    history.time = [obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                    
                }
                
                history.staffName = obj[@"created_by"][@"username"];
                
                history.photo = [NSURL URLWithString:obj[@"photo"]];
                
                [self.histories addObject:history];
                
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

-(void)uploadPhoto:(NSString *)photo student:(Student *)stu result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:stu.photo.absoluteString forKey:@"photo"];
    
    [para setInteger:stu.stuId forKey:@"user_id"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kPhotoAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
