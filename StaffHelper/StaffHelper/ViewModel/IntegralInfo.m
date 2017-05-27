//
//  IntegralInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralInfo.h"

#define ListAPI @"/api/v2/staffs/%ld/scores/rank/"

@implementation IntegralInfo

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        _page = 0;
        
        _totalPages = 1;
        
    }
    
    return self;
    
}

-(void)requestListResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.users = [NSMutableArray array];
    
    if (_page>=_totalPages) {
        
        if (self.callBack) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithInteger:_page+1] forKey:@"page"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:ListAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            _page = [responseDic[@"data"][@"current_page"] integerValue];
            
            _totalPages = [responseDic[@"data"][@"pages"] integerValue];
            
            [responseDic[@"data"][@"ranks"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Student *student = [[Student alloc]init];
                
                student.integral = [obj[@"score"] floatValue];
                
                student.phone = obj[@"user"][@"phone"];
                
                student.stuId = [obj[@"user"][@"id"] integerValue];
                
                student.avatar = [NSURL URLWithString:obj[@"user"][@"avatar"]];
                
                student.name = obj[@"user"][@"username"];
                
                student.sex = [obj[@"user"][@"gender"] integerValue];
                
                [self.users addObject:student];
                
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

-(id)copy
{
    
    IntegralInfo *info = [[IntegralInfo alloc]init];
    
    info.totalPages = self.totalPages;
    
    info.page = self.page;
    
    info.setting = [self.setting copy];
    
    info.users = [self.users mutableCopy];
    
    return info;
    
}

@end
