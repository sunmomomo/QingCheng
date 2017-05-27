//
//  CardPayInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardPayInfo.h"

#define API @"/api/staffs/%ld/cards/%ld/charge/"

@implementation CardPayInfo

-(void)payCard:(Card *)card withAccount:(NSInteger)account andPrice:(NSInteger)price andSellerId:(NSInteger)sellerId andShopId:(NSInteger)shopId andRemark:(NSString *)remark result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if(shopId){
        
        [para setParameter:[NSNumber numberWithInteger:shopId] forKey:@"shop_id"];
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:[NSNumber numberWithInteger:-price] forKey:@"price"];
    
    if (card.cardKind.type == CardKindTypeTime) {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        df.dateFormat = @"yyyy-MM-dd";
        
        NSString *end = [df stringFromDate:[NSDate dateWithTimeInterval:-account*86400 sinceDate:[df dateFromString:card.end]]];
        
        [para setParameter:card.start forKey:@"start"];
        
        [para setParameter:end forKey:@"end"];
        
    }else if (card.cardKind.type == CardKindTypePrepaid){
        
        [para setParameter:[NSNumber numberWithInteger:-account] forKey:@"account"];
        
    }else
    {
        
        [para setParameter:[NSNumber numberWithInteger:-account] forKey:@"times"];
        
    }
    
    if (card.cardKind.type != CardKindTypeTime) {
        
        [para setParameter:[NSNumber numberWithBool:card.checkValid] forKey:@"check_valid"];
        
        if (card.checkValid) {
            
            [para setParameter:card.validFrom  forKey:@"valid_from"];
            
            [para setParameter:card.validTo forKey:@"valid_to"];
            
        }
        
    }
    
    [para setParameter:@"1" forKey:@"charge_type"];
    
    [para setParameter:@"14" forKey:@"type"];
    
    if (sellerId) {
        
        [para setInteger:sellerId forKey:@"seller_id"];
        
    }
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)card.cardId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
