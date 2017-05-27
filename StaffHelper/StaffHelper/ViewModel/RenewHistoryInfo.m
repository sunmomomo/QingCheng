//
//  RenewHistoryInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "RenewHistoryInfo.h"

#define API @"/api/gyms/orders/"

@interface RenewHistoryInfo ()

{
    
    NSInteger _page;
    
    NSInteger _totalPage;
    
}

@end

@implementation RenewHistoryInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _page = 0;
        
        _totalPage = 1;
        
    }
    
    return self;
    
}

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    if (_totalPage && _page>=_totalPage) {
        
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
    
    [para setParameter:[NSNumber numberWithInteger:_page+1] forKey:@"page"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:API param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            _page = [responseDic[@"data"][@"current_page"] integerValue];
            
            _totalPage = [responseDic[@"data"][@"pages"] integerValue];
            
            self.histories = [NSMutableArray array];
            
            [responseDic[@"data"][@"orders"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RenewHistory *history = [[RenewHistory alloc]init];
                
                history.historyId = [obj[@"id"] integerValue];
                
                history.realPrice = [NSString stringWithFormat:@"%ld",(long)[obj[@"price"]integerValue]];
                
                history.success = [obj[@"status"] integerValue] == 2;
                
                history.staff = [[Staff alloc]init];
                
                history.staff.name = obj[@"created_by"][@"username"];
                
                history.staff.phone = obj[@"created_by"][@"phone"];
                
                if (obj[@"extra"][@"start"]) {
                    
                    history.start = [[obj[@"extra"][@"start"] componentsSeparatedByString:@"T"]firstObject];
                    
                }
                
                if (obj[@"extra"][@"end"]) {
                    
                    history.end = [[obj[@"extra"][@"end"] componentsSeparatedByString:@"T"]firstObject];
                    
                }
                
                history.date = [[obj[@"created_at"] componentsSeparatedByString:@"T"]firstObject];
                
                history.type = [obj[@"channel"] integerValue];
                
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

@end
