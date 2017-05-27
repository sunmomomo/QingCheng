//
//  PayHelp.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "PayHelp.h"

#define CreateAPI @"/api/staffs/%ld/cards/create/"

#define RechargeAPI @"/api/staffs/%ld/cards/%ld/charge/"

#define IntegralAPI @""

@implementation PayHelp

-(void)rechargeWithCard:(Card *)card andSpec:(Spec *)spec andGym:(Gym*)gym andSellerId:(NSInteger)sellerId andRemarks:(NSString *)remarks andPayWay:(PayWay)way result:(void (^)(BOOL, NSString *,NSURL *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:spec.price forKey:@"price"];
    
    if (card.cardKind.type != CardKindTypeTime) {
        
        [para setParameter:[NSNumber numberWithBool:card.checkValid] forKey:@"check_valid"];
        
    }
    
    if (card.cardKind.type != CardKindTypeTime && card.checkValid) {
        
        [para setParameter:card.validFrom forKey:@"valid_from"];
        
        [para setParameter:card.validTo forKey:@"valid_to"];
        
    }
    
    switch (card.cardKind.type) {
        case CardKindTypeTime:
            
            [para setParameter:card.start forKey:@"start"];
            
            [para setParameter:card.end forKey:@"end"];
            
            break;
        case CardKindTypeCount:
            
            [para setParameter:spec.charge forKey:@"times"];
            
            break;
        case CardKindTypePrepaid:
            
            [para setParameter:spec.charge forKey:@"account"];
            
            break;
        default:
            break;
    }
    
    if (sellerId) {
        
        [para setParameter:[NSNumber numberWithInteger:sellerId] forKey:@"seller_id"];
        
    }
    
    if (remarks.length) {
        
        [para setParameter:remarks forKey:@"remarks"];
        
    }
    
    [para setParameter:[NSString stringWithInteger:way] forKey:@"charge_type"];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if(gym.gymId && gym.type){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if (gym.shopId){
        
        [para setInteger:gym.shopId forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        self.callBack(NO,nil,nil);
        
        self.callBack = nil;
        
        return;
        
    }
    
    if (way>=6) {
        
        [para setParameter:[NSNumber numberWithInteger:card.cardId] forKey:@"card_id"];
        
    }
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:RechargeAPI,StaffId,(long)card.cardId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSURL *url = [NSURL URLWithString:responseDic[@"data"][@"url"]];
            
            self.callBack(YES,nil,url);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"],nil);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error,nil);
        
        self.callBack = nil;
        
    }];
    
}

-(void)createWithCard:(Card *)card andSpec:(Spec *)spec andGym:(Gym*)gym andSellerId:(NSInteger)sellerId andRemarks:(NSString *)remarks andPayWay:(PayWay)way result:(void (^)(BOOL, NSString *,NSURL *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithInteger:card.cardKind.cardKindId] forKey:@"card_tpl_id"];
    
    [para setParameter:spec.price forKey:@"price"];
    
    if (card.cardKind.type != CardKindTypeTime) {
        
        [para setParameter:[NSNumber numberWithBool:card.checkValid] forKey:@"check_valid"];
        
        if (card.checkValid) {
            
            [para setParameter:card.validFrom forKey:@"valid_from"];
            
            [para setParameter:card.validTo forKey:@"valid_to"];
            
        }
        
    }
    
    switch (card.cardKind.type) {
            
        case CardKindTypeTime:
            
            [para setParameter:card.start forKey:@"start"];
            
            [para setParameter:card.end forKey:@"end"];
            
            break;
            
        case CardKindTypeCount:
            
            [para setParameter:spec.charge forKey:@"times"];
            
            break;
            
        case CardKindTypePrepaid:
            
            [para setParameter:spec.charge forKey:@"account"];
            
            break;
            
        default:
            break;
            
    }
    
    if (sellerId) {
        
        [para setParameter:[NSNumber numberWithInteger:sellerId] forKey:@"seller_id"];
        
    }
    
    [para setParameter:remarks forKey:@"remarks"];
    
    if (card.cardNumber) {
        
        [para setParameter:card.cardNumber forKey:@"card_no"];
        
    }
    
    NSString *userIds = @"";
    
    for (NSInteger i = 0; i<card.users.count; i++) {
        
        Student *stu = card.users[i];
        
        userIds = [userIds stringByAppendingString:[NSString stringWithInteger:stu.stuId]];
        
        if (i<card.users.count-1) {
            
            userIds = [userIds stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIds forKey:@"user_ids"];
    
    [para setParameter:[NSString stringWithInteger:way] forKey:@"charge_type"];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if(gym.gymId && gym.type){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if (gym.shopId){
        
        [para setInteger:gym.shopId forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        self.callBack(NO,nil,nil);
        
        self.callBack = nil;
        
        return;
        
    }
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CreateAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSURL *url = [NSURL URLWithString:responseDic[@"data"][@"url"]];
            
            self.callBack(YES,nil,url);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"],nil);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error,nil);
        
        self.callBack = nil;
        
    }];
    
}

-(void)calculateWithSpec:(Spec *)spec andGym:(Gym *)gym andPayWay:(PayType)type result:(void (^)(BOOL, NSString *, NSURL *))result
{
    
    self.callBack = result;
    
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
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [para setParameter:spec.price forKey:@"price"];
    
    [para setParameter:type == PayTypeCreate?@"buycard":@"chargecard" forKey:@"type"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:IntegralAPI] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil,nil);
                
            }
            
        }else
        {
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"],nil);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error,nil);
            
        }
        
    }];
    
}

@end
