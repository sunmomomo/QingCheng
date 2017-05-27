//
//  MeasuresListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MeasuresListInfo.h"

#define API @"/api/staffs/%ld/users/%ld/measures/"

@interface MeasuresListInfo ()

{
    
    NSInteger _totalPage;
    
    NSInteger _currentPage;
    
}

@end

@implementation MeasuresListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.measures = [NSMutableArray array];
        
        _totalPage = 1;
        
        _currentPage = 0;
        
    }
    return self;
}

-(void)requestWithStuId:(NSInteger)stuId result:(void (^)(BOOL, NSString *))result
{
    
    if (_currentPage>=_totalPage) {
        
        if (self.callBack) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
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
    
    [para setParameter:[NSNumber numberWithInteger:_currentPage+1] forKey:@"page"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)stuId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"measures"]];
            
            _totalPage = [responseDic[@"data"][@"pages"] integerValue];
            
            _currentPage = [responseDic[@"data"][@"current_page"] integerValue];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
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

-(void)createDataWithArray:(NSArray*)array
{
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Measure *measure = [[Measure alloc]init];
        
        if ( [obj[@"created_at"] length]>=10) {
            
            measure.date = [obj[@"created_at"] substringToIndex:10];
            
        }
        
        measure.measureId = [obj[@"id"] integerValue];
        
        measure.student.stuId = [obj[@"user"][@"id"] integerValue];
        
        measure.student.name = obj[@"user"][@"username"];
        
        [self.measures addObject:measure];
        
    }];
    
}

@end
