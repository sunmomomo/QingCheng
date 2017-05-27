//
//  ChestBorrowInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestBorrowInfo.h"

#define API @"/api/v2/staffs/%ld/lockers/borrow/"

#define ReturnAPI @"/api/v2/staffs/%ld/lockers/return/"

#define ContinueAPI @"/api/v2/staffs/%ld/lockers/long/delay/"

@implementation ChestBorrowInfo

-(void)borrowTempChest:(Chest *)chest withUser:(Student*)user result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:chest.chestId forKey:@"locker_id"];
    
    [para setInteger:user.stuId forKey:@"user_id"];
    
    [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_long_term_borrow"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)borrowLongUseChest:(Chest *)chest withUser:(Student*)user andCard:(Card *)card orPayWay:(PayWay)payWay andCost:(NSInteger)cost result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:chest.chestId forKey:@"locker_id"];
    
    [para setInteger:user.stuId forKey:@"user_id"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_long_term_borrow"];
    
    if (card) {
        
        [para setInteger:card.cardId forKey:@"card_id"];
        
        [para setInteger:1 forKey:@"deal_mode"];
        
    }else{
        
        NSInteger deal_mode = 0;
        
        switch (payWay) {
            case PayWayCash:
                
                deal_mode = 2;
                
                break;
            case PayWayCard:
                
                deal_mode = 4;
                
                break;
            case PayWayTransfer:
                
                deal_mode = 5;
                
                break;
            case PayWayOther:
                
                deal_mode = 6;
                
                break;
                
            default:
                break;
        }
        
        [para setInteger:deal_mode forKey:@"deal_mode"];
        
    }
    
    [para setInteger:cost forKey:@"cost"];
    
    [para setParameter:chest.start forKey:@"start"];
    
    [para setParameter:chest.end forKey:@"end"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)returnLongUseChest:(Chest *)chest andCard:(Card *)card orPayWay:(PayWay)payWay andCost:(NSInteger)cost result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:chest.chestId forKey:@"locker_id"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_long_term_borrow"];
    
    if (card) {
        
        [para setInteger:card.cardId forKey:@"card_id"];
        
        [para setInteger:1 forKey:@"deal_mode"];
        
    }else{
        
        NSInteger deal_mode = 0;
        
        switch (payWay) {
            case PayWayCash:
                
                deal_mode = 2;
                
                break;
            case PayWayCard:
                
                deal_mode = 4;
                
                break;
            case PayWayTransfer:
                
                deal_mode = 5;
                
                break;
            case PayWayOther:
                
                deal_mode = 6;
                
                break;
                
            default:
                break;
        }
        
        [para setInteger:deal_mode forKey:@"deal_mode"];
        
    }
    
    [para setInteger:chest.remain>=0?-cost:cost forKey:@"cost"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ReturnAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)returnTempChest:(Chest *)chest result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:chest.chestId forKey:@"locker_id"];
    
    [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_long_term_borrow"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ReturnAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)returnLongUseChest:(Chest *)chest result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:chest.chestId forKey:@"locker_id"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_long_term_borrow"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ReturnAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)continueChest:(Chest *)chest andCard:(Card *)card orPayWay:(PayWay)payWay andCost:(NSInteger)cost result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:chest.chestId forKey:@"locker_id"];
    
    [para setInteger:chest.borrowUser.stuId forKey:@"user_id"];
    
    if (card) {
        
        [para setInteger:card.cardId forKey:@"card_id"];
        
        [para setInteger:1 forKey:@"deal_mode"];
        
    }else{
        
        NSInteger deal_mode = 0;
        
        switch (payWay) {
            case PayWayCash:
                
                deal_mode = 2;
                
                break;
            case PayWayCard:
                
                deal_mode = 4;
                
                break;
            case PayWayTransfer:
                
                deal_mode = 5;
                
                break;
            case PayWayOther:
                
                deal_mode = 6;
                
                break;
                
            default:
                break;
        }
        
        [para setInteger:deal_mode forKey:@"deal_mode"];
        
    }
    
    [para setInteger:cost forKey:@"cost"];
    
    [para setParameter:chest.end forKey:@"end"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ContinueAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
