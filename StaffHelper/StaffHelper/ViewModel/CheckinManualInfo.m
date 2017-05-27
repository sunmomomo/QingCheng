//
//  CheckinManualInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinManualInfo.h"

#import "UIColor+Hex.h"

#define CardAPI @"/api/v2/staffs/%ld/checkin/cards/"

#define CourseAPI @"/api/v2/staffs/%ld/users/orders/"

@implementation CheckinManualInfo

-(void)requsetCardsWithStudent:(Student *)stu result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:stu.stuId forKey:@"user_id"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CardAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] ==200) {
            
            self.cards = [NSMutableArray array];
            
            [responseDic[@"data"][@"cards"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Card *card = [[Card alloc]init];
                
                card.remain = [obj[@"balance"] floatValue];
                
                card.cardKind.cardKindId = [obj[@"card_tpl_id"] integerValue];
                
                card.checkValid = [obj[@"check_valid"] boolValue];
                
                card.cardNumber = obj[@"card_no"];
                
                card.color = [UIColor colorWithHexString:obj[@"color"]];
                
                card.end = [obj[@"end"] length]?[obj[@"end"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "]:@"";
                
                card.cardId = [obj[@"id"] integerValue];
                
                card.cardKind.cardKindName = obj[@"name"];
                
                card.cardName = obj[@"name"];
                
                card.start = [obj[@"start"] length]?[obj[@"start"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "]:@"";
                
                card.cardKind.type = [obj[@"type"] integerValue];
                
                card.validTo = [obj[@"valid_to"] length]?[obj[@"valid_to"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "]:@"";
                
                card.validFrom = [obj[@"valid_from"] length]?[obj[@"valid_from"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "]:@"";
                
                card.checkValid = [obj[@"check_valid"] boolValue];
                
                [self.cards addObject:card];
                
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

-(void)requestCoursesWithStudent:(Student *)stu result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:stu.stuId forKey:@"user_id"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CourseAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] ==200) {
            
            self.courses = [NSMutableArray array];
            
            for (NSDictionary *dict in responseDic[@"data"][@"schedules"]) {
                
                CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
                
                batch.course.name = dict[@"name"];
                
                if (dict[@"time"]) {
                    
                    batch.start = [dict[@"time"] substringWithRange:NSMakeRange(11, 5)];
                    
                }
                
                batch.coach.name = dict[@"teacher"][@"username"];
                
                batch.coach.coachId = [dict[@"teacher"][@"id"] integerValue];
                
                Yard *yard = [[Yard alloc]init];
                
                yard.name = dict[@"space"][@"name"];
                
                yard.yardId = [dict[@"space"][@"id"] integerValue];
                
                batch.yards = @[yard];
                
                [self.courses addObject:batch];
                
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

@end
