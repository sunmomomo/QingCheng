//
//  CardRestListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRestListInfo.h"

#define API @"/api/staffs/%ld/leaves/"

#define DeleteAPI @"/api/staffs/%ld/leaves/%ld/"

@interface CardRestListInfo ()

{
    
    Card *_card;
    
}

@end

@implementation CardRestListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.rests = [NSMutableArray array];
        
    }
    return self;
}

-(void)requestWithCard:(Card *)card
{
    
    Parameters *para = [[Parameters alloc]init];
    
    _card = card;
    
    [para setParameter:[NSNumber numberWithInteger:_card.cardId] forKey:@"card_id"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:@"-created_at" forKey:@"order_by"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"leaves"]];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
    
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}

-(void)createDataWithArray:(NSArray *)array
{
    if (array.count <= 0) {
        return;
    }
//#warning !!!!!!
//    array = [NSMutableArray arrayWithObjects:array[0],array[0],array[0],array[0], nil];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CardRest *rest = [[CardRest alloc]init];
        
        rest.status = [obj[@"status"] integerValue];
        
//#warning !!!!!!!
//        if (idx %2 == 0) {
//        rest.status = CardRestStatusStop;
//        }
        
        
        rest.start = [obj[@"start"] length]>=10?[obj[@"start"] substringToIndex:10]:@"";
        
        rest.end = [obj[@"end"] length]>=10?[obj[@"end"] substringToIndex:10]:@"";
        
        rest.operateTime = [obj[@"created_at"] length]>=16?[[obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:16]:@"";
        
        rest.price = [obj[@"price"] integerValue];
        
        rest.cancelTime = [obj[@"cancel_at"] length]>=10?[obj[@"cancel_at"] substringToIndex:10]:@"";
        
        rest.restId = [obj[@"id"] integerValue];
        
        rest.remark = obj[@"remarks"];
        
        rest.message = obj[@"message"];
        
        rest.staffName = obj[@"created_by"][@"username"];
        
        [self.rests addObject:rest];
        

        
    }];
    
}

-(void)addRest:(CardRest *)rest result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithInteger:rest.card.cardId] forKey:@"card_id"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:rest.start forKey:@"start"];
    
    [para setParameter:rest.end forKey:@"end"];
    
    [para setParameter:rest.message forKey:@"message"];
    
    [para setParameter:[NSNumber numberWithInteger:rest.price] forKey:@"price"];
    
    [para setParameter:rest.remark forKey:@"remarks"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)cancelRest:(CardRest *)rest result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:DeleteAPI,StaffId,(long)rest.restId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

@end
