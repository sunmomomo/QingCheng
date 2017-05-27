//
//  CardDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardDetailInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/staffs/%ld/cards/%ld/"

#define RenewAPI @"/api/staffs/%ld/cards/%ld/recovery/"

@implementation CardDetailInfo

-(void)requestWithCard:(Card*)card Result:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)card.cardId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSDictionary *cardDict = responseDic[@"data"][@"card"];
            
            if (card.cardKind == nil)
            {
                card.cardKind = [[CardKind alloc] init];
            }
            
            card.cardKind.type = [cardDict[@"type"] integerValue];

            
            NSString *path = card.cardKind.type == CardKindTypePrepaid?@"total_account":card.cardKind.type == CardKindTypeCount?@"total_times":@"";
            
            if (card.cardKind.type == CardKindTypePrepaid) {
                
                self.totalRecharge = [NSString stringWithFormat:@"%.2f",[responseDic[@"data"][@"card"][path] floatValue]];
                
                self.totalCost = [NSString stringWithFormat:@"%.2f",[responseDic[@"data"][@"card"][@"total_cost"] floatValue]];
                
            }else if (card.cardKind.type == CardKindTypeCount){
                
                self.totalRecharge = [responseDic[@"data"][@"card"][path] stringValue];
                
                self.totalCost = [responseDic[@"data"][@"card"][@"total_cost"] stringValue];
                
            }else
            {
                
                self.totalRecharge = @"";
                
                self.totalCost = @"";
                
            }
            
            
            card.cardId = [cardDict[@"id"] integerValue];
            
            card.color = [UIColor colorWithHexString:cardDict[@"color"]];
            
            card.cardNumber = cardDict[@"card_no"];
            
            card.cardName = cardDict[@"name"];
            
            card.state = [cardDict[@"is_locked"] boolValue]?CardStateRest:CardStateNormal;
            
            if (![cardDict[@"is_active"] boolValue]) {
                
                card.state = CardStateStop;
                
            }
            
            if ([cardDict[@"expired"] boolValue]) {
                
                card.state = CardStateExpired;
                
                NSString *trial_daysStr =  [cardDict[@"trial_days"] guardStringYF];
                
                card.trial_days = trial_daysStr.integerValue;
            }else
            {
                card.trial_days = 0;
            }


            
            
            card.checkValid = [cardDict[@"check_valid"] boolValue];
            
            card.lockStart = [cardDict[@"lock_start"] length]?[cardDict[@"lock_start"] substringToIndex:10]:@"";
            
            card.lockEnd = [cardDict[@"lock_end"] length]?[cardDict[@"lock_end"] substringToIndex:10]:@"";
            
            card.start = [cardDict[@"start"] length]?[cardDict[@"start"] substringToIndex:10]:@"";
            
            card.end = [cardDict[@"end"] length]?[cardDict[@"end"] substringToIndex:10]:@"";
            
            card.validFrom = [cardDict[@"valid_from"] length]?[cardDict[@"valid_from"] substringToIndex:10]:@"";
            
            card.validTo = [cardDict[@"valid_to"] length]?[cardDict[@"valid_to"] substringToIndex:10]:@"";
            
            card.remain = [cardDict[@"balance"] floatValue];
            
            NSMutableArray *array = [NSMutableArray array];
            
            [cardDict[@"users"] enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Student *stu = [[Student alloc]init];
                
                stu.stuId = [object[@"id"] integerValue];
                
                stu.name = object[@"username"];
                
                NSString *avatar = object[@"avatar"];
                NSString *gender = object[@"gender"];
                
                if ([avatar isStringValueYF]) {
                    stu.avatar = [NSURL URLWithString:avatar];
                }

                if (gender) {
                    stu.sex = gender.integerValueYF;
                }
                
                stu.phone = object[@"phone"];
                
                [array addObject:stu];
                
            }];
            
            card.users = array;
            
            card.cardKind.gyms = [NSMutableArray array];
            
            [cardDict[@"shops"] enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Gym *gym = [[Gym alloc]init];
                
                gym.name = object[@"name"];
                
                gym.shopId = [object[@"id"] integerValue];
                
                gym.brand.brandId = [BRANDID integerValue];
                
                [card.cardKind.gyms addObject:gym];
                
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

-(void)stopWithCardId:(NSInteger)cardId Result:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)cardId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)renewWithCardId:(NSInteger)cardId Result:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:RenewAPI,StaffId,(long)cardId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)changeCard:(Card *)card withGym:(Gym *)gym Result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:card.cardNumber forKey:@"card_no"];
    
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
    
    NSString *userIds = @"";
    
    for (NSInteger i = 0; i<card.users.count; i++) {
        
        Student *stu = card.users[i];
        
        userIds = [userIds stringByAppendingString:[NSString stringWithInteger:stu.stuId]];
        
        if (i<card.users.count-1) {
            
            userIds = [userIds stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIds forKey:@"user_ids"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)card.cardId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else{
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

@end
