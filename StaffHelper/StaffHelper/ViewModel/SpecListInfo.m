//
//  SpecListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SpecListInfo.h"

#define API @"/api/staffs/%ld/cardtpls/%ld/options/"

#define CreateAPI @"/api/staffs/%ld/cardtpls/%ld/options/"

#define ChangeAPI @"/api/staffs/%ld/options/%ld/"

#define PositionAPI @"/api/staffs/%ld/permissions/positions/"

@implementation SpecListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.specs = [NSMutableArray array];
        
    }
    return self;
}

-(void)requestWithCardKind:(CardKind *)cardKind result:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)cardKind.cardKindId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"options"];
            
            [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Spec *spec = [[Spec alloc]init];
                
                spec.canCreate = [obj[@"can_create"] boolValue];
                
                spec.canRecharge = [obj[@"can_charge"] boolValue];
                
                spec.charge = [obj[@"charge"] stringValue];
                
                spec.price = [obj[@"price"] stringValue];
                
                spec.checkValid = [obj[@"limit_days"] boolValue];
                
                spec.validTime = [obj[@"days"] integerValue];
                
                spec.specId = [obj[@"id"] integerValue];
                
                spec.summary = obj[@"description"];
                
                spec.onlyStaffCanSee = [obj[@"for_staff"] boolValue];
                
                spec.cardKind.cardKindId = cardKind.cardKindId;
                
                spec.cardKind.type = cardKind.type;
                
                spec.cardKind.cardKindName = cardKind.cardKindName;
                
                [self.specs addObject:spec];
                
            }];
            
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

-(void)createSpec:(Spec *)spec result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:spec.charge forKey:@"charge"];
    
    [para setParameter:spec.price forKey:@"price"];
    
    if (spec.cardKind.type != CardKindTypeTime) {
        
        [para setParameter:[NSNumber numberWithInteger:spec.validTime] forKey:@"days"];
        
        [para setParameter:[NSNumber numberWithBool:spec.checkValid] forKey:@"limit_days"];
        
    }
    
    [para setParameter:spec.summary forKey:@"description"];
    
    [para setParameter:[NSNumber numberWithBool:spec.canCreate] forKey:@"can_create"];
    
    [para setParameter:[NSNumber numberWithBool:spec.canRecharge] forKey:@"can_charge"];
    
    [para setParameter:[NSNumber numberWithBool:spec.onlyStaffCanSee] forKey:@"for_staff"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CreateAPI,StaffId,(long)spec.cardKind.cardKindId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)changeSpec:(Spec *)spec result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:spec.charge forKey:@"charge"];
    
    [para setParameter:spec.price forKey:@"price"];
    
    if (spec.cardKind.type != CardKindTypeTime) {
        
        [para setParameter:[NSNumber numberWithInteger:spec.validTime] forKey:@"days"];
        
        [para setParameter:[NSNumber numberWithBool:spec.checkValid] forKey:@"limit_days"];
        
    }
    
    [para setParameter:spec.summary forKey:@"description"];
    
    [para setParameter:[NSNumber numberWithBool:spec.canCreate] forKey:@"can_create"];
    
    [para setParameter:[NSNumber numberWithBool:spec.canRecharge] forKey:@"can_charge"];
    
    [para setParameter:[NSNumber numberWithBool:spec.onlyStaffCanSee] forKey:@"for_staff"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)spec.specId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)deleteSpec:(Spec *)spec result:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)spec.specId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)requestPositionsResult:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"cardsetting_can_change" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PositionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSMutableArray *postions = [NSMutableArray array];
            
            [responseDic[@"data"][@"positions"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [postions addObject:obj[@"name"]];
                
            }];
            
            self.positions = postions;
            
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
