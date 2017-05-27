//
//  CardInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CardInfo.h"

#define API @"/api/v2/coaches/%ld/reports/sale/cardtpls/"

@implementation CardInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        NSString *api = [NSString stringWithFormat:API,CoachId];
        
        Parameters *para = [[Parameters alloc]init];
        
        if (AppGym.type.length &&AppGym.gymId) {
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
            
            [para setParameter:AppGym.type forKey:@"model"];
            
        }else if(AppGym.shopId && AppGym.brand.brandId){
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
            
            [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
            
        }
        
        [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                [self createDataWithArray:responseDic[@"data"][@"systems"]];
                
            }else
            {
                
                if (self.request) {
                    self.request(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.request) {
                self.request(NO);
            }
            
        }];
         
    }
    
    return self;
    
}

-(void)createDataWithArray:(NSArray *)array
{
    
    self.cards = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        NSArray *cardArray = dict[@"card_tpls"];
        
        [cardArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Card *card = [[Card alloc]init];
            
            card.cardName = obj[@"name"];
            
            card.cardId = [obj[@"id"] integerValue];
            
            card.cardKind.type = [obj[@"type"] integerValue];
            
            [self.cards addObject:card];
            
        }];
        
    }
    
    
    if (self.request) {
        self.request(YES);
    }
    
}

@end
