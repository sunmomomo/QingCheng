//
//  CheckinHistoryInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinHistoryInfo.h"

#define API @"/api/v2/staffs/%ld/checkin/latest/"

@implementation CheckinHistoryInfo

-(void)requestResult:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"-modify_at" forKey:@"order_by"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]== 200) {
            
            self.checkins = [NSMutableArray array];
            
            [responseDic[@"data"][@"check_in"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Checkin *checkin = [[Checkin alloc]init];
                
                checkin.checkinId = [obj[@"id"] integerValue];
                
                checkin.card.cardKind.cardKindName = obj[@"card"][@"name"];
                
                checkin.card.cardKind.cardKindId = [obj[@"card"][@"id"] integerValue];
                
                checkin.card.remain = [obj[@"card"][@"balance"] floatValue];
                
                checkin.card.cardKind.type = [obj[@"card"][@"card_tpl_type"] integerValue];
                
                checkin.card.cardKind.cost = [obj[@"cost"] integerValue];
                
                if ([obj[@"card"][@"start"] length]) {
                    
                    checkin.card.start = [obj[@"card"][@"start"] substringToIndex:10];
                    
                }
                
                if ([obj[@"card"][@"start"] length]) {
                    
                    checkin.card.end = [obj[@"card"][@"end"] substringToIndex:10];
                    
                }
                
                checkin.student.phone = obj[@"user_phone"];
                
                checkin.student.sex = [obj[@"user_gender"] integerValue];
                
                checkin.student.name = obj[@"user_name"];
                
                checkin.student.stuId = [obj[@"user_id"] integerValue];
                
                checkin.student.avatar = [NSURL URLWithString:obj[@"user_avatar"]];
                
                checkin.student.photo = [NSURL URLWithString:obj[@"checkin_avatar"]];
                
                checkin.canceled = [obj[@"status"] integerValue] == 1;
                
                if ([obj[@"created_at"]length]) {
                    
                    checkin.createTime = [[obj[@"created_at"] substringToIndex:[obj[@"created_at"]length]-3] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                    
                }
                
                if ([obj[@"created_by_name"]length]) {
                    
                    checkin.checkinStaff = [[Staff alloc]init];
                    
                    checkin.checkinStaff.name = obj[@"created_by_name"];
                    
                }
                
                if ([obj[@"checkout_at"] length]) {
                    
                    checkin.checkoutTime = [[obj[@"checkout_at"] substringToIndex:[obj[@"checkout_at"]length]-3] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                    
                }
                
                if ([obj[@"checkout_by"][@"username"] length]) {
                    
                    checkin.checkoutStaff = [[Staff alloc]init];
                    
                    checkin.checkoutStaff.name = obj[@"checkout_by"][@"username"];
                    
                }
                
                NSMutableArray *courses = [NSMutableArray array];
                
                for (NSDictionary *dict in obj[@"schedules"]) {
                    
                    CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
                    
                    batch.course.name = dict[@"name"];
                    
                    if (dict[@"time"]) {
                        
                        batch.start = [dict[@"time"] substringWithRange:NSMakeRange(11, 5)];
                        
                    }
                    
                    batch.coach.name = dict[@"teacher"][@"name"];
                    
                    batch.coach.coachId = [dict[@"teacher"][@"id"] integerValue];
                    
                    Yard *yard = [[Yard alloc]init];
                    
                    yard.name = dict[@"space"][@"name"];
                    
                    yard.yardId = [dict[@"space"][@"id"] integerValue];
                    
                    batch.yards = @[yard];
                    
                    [courses addObject:batch];
                    
                }
                
                checkin.courseBatches = [courses copy];
                
                if ([obj[@"locker"][@"id"] integerValue]) {
                    
                    checkin.chest = [[Chest alloc]init];
                    
                    checkin.chest.chestId = [obj[@"locker"][@"id"] integerValue];
                    
                    checkin.chest.name = obj[@"locker"][@"name"];
                    
                    checkin.chest.area.areaName = obj[@"locker"][@"region_name"];
                    
                }
                
                [self.checkins addObject:checkin];
                
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

@end
