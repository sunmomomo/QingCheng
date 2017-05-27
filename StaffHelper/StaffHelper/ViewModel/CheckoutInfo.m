//
//  CheckoutInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckoutInfo.h"

#define API @"/api/v2/staffs/%ld/checkin/"

#define CheckoutAPI @"/api/v2/staffs/%ld/doublecheckout/"

#define IgnoreAPI @"/api/v2/staffs/%ld/checkin/ignore/"

@implementation CheckoutInfo

-(void)requestWithStudent:(Student *)stu result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"0" forKey:@"status"];
    
    [para setInteger:stu.stuId forKey:@"user_id"];
    
    [para setParameter:@"-created_at" forKey:@"order_by"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSMutableArray *checkouts = [NSMutableArray array];
            
            [responseDic[@"data"][@"check_in"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Checkout *checkout = [[Checkout alloc]init];
                
                checkout.checkoutId = [obj[@"id"] integerValue];
                
                checkout.card = [[Card alloc]init];
                
                checkout.card.cardKind.cardKindName = obj[@"card"][@"name"];
                
                checkout.card.cardKind.cardKindId = [obj[@"card"][@"id"] integerValue];
                
                checkout.card.remain = [obj[@"card"][@"balance"] floatValue];
                
                checkout.card.cardKind.type = [obj[@"card"][@"card_tpl_type"] integerValue];
                
                checkout.card.cardKind.cost = [obj[@"cost"] integerValue];
                
                checkout.card.end = obj[@"card"][@"end"];
                
                checkout.student = [[Student alloc]init];
                
                checkout.student.phone = obj[@"user_phone"];
                
                checkout.student.sex = [obj[@"user_gender"] integerValue];
                
                checkout.student.name = obj[@"user_name"];
                
                checkout.student.stuId = [obj[@"user_id"] integerValue];
                
                checkout.student.photo = [NSURL URLWithString:obj[@"checkin_avatar"]];
                
                if ([obj[@"created_at"]length]) {
                    
                    checkout.createdTime = [[obj[@"created_at"] substringToIndex:[obj[@"created_at"]length]-3] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                    
                }
                
                if (obj[@"locker"][@"name"]) {
                    
                    checkout.chest = [[Chest alloc]init];
                    
                    checkout.chest.name = obj[@"locker"][@"name"];
                    
                    checkout.chest.chestId = [obj[@"locker"][@"id"] integerValue];
                    
                    checkout.chest.area.areaName = obj[@"locker"][@"region_name"];
                    
                }
                
                checkout.createdTime = [obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                
                [checkouts addObject:checkout];
                
            }];
            
            self.checkouts = [checkouts copy];
            
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

-(void)checkoutWithCheckout:(Checkout *)checkout result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:checkout.checkoutId forKey:@"checkin_id"];
    
    [para setInteger:4 forKey:@"status"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:CheckoutAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)manualCheckoutWithCheckout:(Checkout *)checkout result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:checkout.checkoutId forKey:@"checkin_id"];
    
    [para setInteger:4 forKey:@"status"];
    
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
-(void)ignoreWithCheckout:(Checkout *)checkout result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:checkout.checkoutId forKey:@"checkin_id"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_ignore"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:IgnoreAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
