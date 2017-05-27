//
//  CheckinSettingInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinSettingInfo.h"

#define API @"/api/staffs/%ld/shops/configs/"

#define CardKindAPI @"/api/v2/staffs/%ld/checkin/settings/"

#define SwitchAPI @"/api/v2/staffs/%ld/modules/"

@implementation CheckinSettingInfo

-(void)requestUsedResult:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"checkin" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:SwitchAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]== 200) {
            
            self.openCheckin = [responseDic[@"data"][@"module"][@"checkin"] boolValue];
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
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

-(void)requestSettingResult:(void (^)(BOOL, NSString *))result
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

    [para setParameter:@"user_checkin_with_locker,check_out_with_return_locker" forKey:@"keys"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            for (NSDictionary *dict in responseDic[@"data"][@"configs"]) {
                
                if ([dict[@"key"] isEqualToString:@"user_checkin_with_locker"]) {
                    
                    self.checkinId = [dict[@"id"] integerValue];
                    
                    self.autoChest = [dict[@"value"] boolValue];
                    
                }else if ([dict[@"key"]isEqualToString:@"check_out_with_return_locker"]){
                    
                    self.checkoutId = [dict[@"id"] integerValue];
                    
                    self.autoReturn = [dict[@"value"] boolValue];
                    
                }
                
            }
            
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

-(void)editSettingResult:(void (^)(BOOL, NSString *))result
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

    [para setParameter:@[@{@"id":[NSNumber numberWithInteger:self.checkinId],@"value":self.autoChest?@"1":@"0"},@{@"id":[NSNumber numberWithInteger:self.checkoutId],@"value":self.autoReturn?@"1":@"0"}] forKey:@"configs"];
    
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

-(void)requestCardKindsResult:(void (^)(BOOL, NSString *))result
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

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CardKindAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.cardKinds = [NSMutableArray array];
            
            [responseDic[@"data"][@"card_costs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CardKind *cardKind = [[CardKind alloc]init];
                
                cardKind.cardKindId = [obj[@"id"] integerValue];
                
                cardKind.type = [obj[@"type"] integerValue];
                
                cardKind.cost = [obj[@"cost"] integerValue];
                
                cardKind.isUsed = [obj[@"selected"] boolValue];
                
                if (cardKind.isUsed) {
                    
                    cardKind.costString = [NSString stringWithInteger:cardKind.cost];
                    
                }
                
                cardKind.cardKindName = obj[@"name"];
                
                [self.cardKinds addObject:cardKind];
                
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

-(void)editCardKindsResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else{
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CardKind *cardKind in self.cardKinds) {
        
        if (cardKind.isUsed) {
            
            [array addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cardKind.cost]}];
            
        }
        
    }
    
    [para setParameter:array forKey:@"card_costs"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:CardKindAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)changeCheckinUsed:(BOOL)used result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:[NSNumber numberWithBool:used] forKey:@"checkin"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:SwitchAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]== 200) {
            
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
    
    CheckinSettingInfo *info = [[CheckinSettingInfo alloc]init];
    
    NSMutableArray *cardKinds = [NSMutableArray array];
    
    for (CardKind *cardKind in self.cardKinds) {
        
        [cardKinds addObject:[cardKind copy]];
        
    }
    
    info.cardKinds = cardKinds;
    
    info.autoChest = self.autoChest;
    
    info.autoReturn = self.autoReturn;
    
    info.openCheckin = self.openCheckin;
    
    info.checkinId = self.checkinId;
    
    info.checkoutId = self.checkoutId;

    return info;
    
}

@end
