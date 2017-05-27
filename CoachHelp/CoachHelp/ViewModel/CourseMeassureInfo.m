//
//  CourseMeassureInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseMeassureInfo.h"

#define API @"/api/v2/coaches/%ld/plantpls/"

@implementation CourseMeassureInfo

-(void)requestResult:(void (^)(BOOL, NSString *))result
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

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.meassures = [NSMutableArray array];
            
            [responseDic[@"data"][@"plans"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CourseMeassure *meassure = [[CourseMeassure alloc]init];
                
                meassure.meassureId = [obj[@"id"] integerValue];
                
                meassure.name = obj[@"name"];
                
                meassure.tags = obj[@"tags"];
                
                meassure.url = [NSURL URLWithString:obj[@"url"]];
                
                [self.meassures addObject:meassure];
                
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

@end
