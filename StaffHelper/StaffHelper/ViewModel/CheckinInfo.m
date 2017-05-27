//
//  CheckinInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinInfo.h"

#define ListAPI @"/api/v2/staffs/%ld/checkin/tasklist/"

#define CheckinAPI @"/api/v2/staffs/%ld/checkin/"

#define CheckinCheckinAPI @"/api/v2/staffs/%ld/doublecheckin/"

#define QRCodeAPI @"/api/v2/staffs/%ld/checkin/urls/"

#define IgnoreAPI @"/api/v2/staffs/%ld/checkin/ignore/"

@implementation CheckinInfo

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.checkins = [NSMutableArray array];
        
        self.checkouts = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(void)requestQRCodeResult:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"-id" forKey:@"order_by"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:QRCodeAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.checkinQRCode = responseDic[@"data"][@"checkin_url"];
            
            self.checkoutQRCode = responseDic[@"data"][@"checkout_url"];
            
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

-(void)requestCheckinDataWithCheckin:(Checkin *)checkin result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"2" forKey:@"status"];
    
    if (checkin) {
        
        [para setInteger:checkin.checkinId+1 forKey:@"id__gte"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:ListAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.checkinNew = [responseDic[@"data"][@"check_in"] count]?YES:NO;
            
            NSMutableArray *checkins = [NSMutableArray array];
            
            [responseDic[@"data"][@"check_in"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Checkin *checkin = [[Checkin alloc]init];
                
                checkin.card.cardKind.cardKindName = obj[@"card"][@"name"];
                
                checkin.card.cardKind.cardKindId = [obj[@"card"][@"id"] integerValue];
                
                checkin.card.remain = [obj[@"card"][@"balance"] floatValue];
                
                checkin.card.start = obj[@"card"][@"start"];
                
                checkin.card.end = obj[@"card"][@"end"];
                
                checkin.card.cardKind.type = [obj[@"card"][@"card_tpl_type"] integerValue];
                
                checkin.card.cardKind.cost = [obj[@"cost"] integerValue];
                
                checkin.student.phone = obj[@"user_phone"];
                
                checkin.student.sex = [obj[@"user_gender"] integerValue];
                
                checkin.student.name = obj[@"user_name"];
                
                checkin.student.stuId = [obj[@"user_id"] integerValue];
                
                checkin.student.avatar = [NSURL URLWithString:obj[@"user_avatar"]];
                
                checkin.student.photo = [NSURL URLWithString:obj[@"checkin_avatar"]];
                
                checkin.checkinId = [obj[@"id"] integerValue];
                
                if ([obj[@"created_at"]length]) {
                    
                    checkin.createTime = [[obj[@"created_at"] substringToIndex:[obj[@"created_at"]length]-3] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                    
                }
                
                NSMutableArray *courses = [NSMutableArray array];
                
                for (NSDictionary *dict in obj[@"schedules"]) {
                    
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
                    
                    [courses addObject:batch];
                    
                }
                
                checkin.courseBatches = [courses copy];
                
                courses = nil;
                
                [checkins addObject:checkin];
                
            }];
            
            if (!self.lastCheckin && self.checkins.count) {
                
                Checkin *checkin = [self.checkins firstObject];
                
                self.lastCheckin = checkin;
                
            }
            
            self.checkins = [checkins copy];
            
            checkins = nil;
            
            if (self) {
                
                if (self.callBack) {
                    
                    self.callBack(YES,nil);
                    
                    self.callBack = nil;
                    
                }
                
            }
            
        }else{
            
            if (self) {
                
                if (self.callBack) {
                    
                    self.callBack(NO,responseDic[@"msg"]);
                    
                    self.callBack = nil;
                    
                }
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self) {
            
            if (self.callBack) {
                
                self.callBack(NO,error);
                
                self.callBack = nil;
                
            }
            
        }
        
    }];
    
}


-(void)requestCheckoutDataWithCheckout:(Checkout *)checkout result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"3" forKey:@"status"];
    
    if (checkout.modifyAt.length) {
        
        [para setParameter:checkout.modifyAt forKey:@"modify_at__gt"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:ListAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.checkoutNew = [responseDic[@"data"][@"check_in"] count]?YES:NO;
            
            NSMutableArray *checkouts = [NSMutableArray array];
            
            [responseDic[@"data"][@"check_in"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Checkout *checkout = [[Checkout alloc]init];
                
                checkout.checkoutId = [obj[@"id"] integerValue];
                
                checkout.card.cardKind.cardKindName = obj[@"card"][@"name"];
                
                checkout.card.cardKind.cardKindId = [obj[@"card"][@"id"] integerValue];
                
                checkout.card.remain = [obj[@"card"][@"balance"] floatValue];
                
                checkout.card.cardKind.type = [obj[@"card"][@"card_tpl_type"] integerValue];
                
                checkout.card.cardKind.cost = [obj[@"cost"] integerValue];
                
                checkout.student.phone = obj[@"user_phone"];
                
                checkout.student.sex = [obj[@"user_gender"] integerValue];
                
                checkout.student.name = obj[@"user_name"];
                
                checkout.student.stuId = [obj[@"user_id"] integerValue];
                
                checkout.student.avatar = [NSURL URLWithString:obj[@"user_avatar"]];
                
                checkout.student.photo = [NSURL URLWithString:obj[@"checkin_avatar"]];
                
                checkout.modifyAt = obj[@"modify_at"];
                
                if ([obj[@"created_at"]length]) {
                    
                    checkout.createdTime = [[obj[@"created_at"] substringToIndex:[obj[@"created_at"]length]-3] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                    
                }
                
                if ([obj[@"locker"][@"id"] integerValue]) {
                    
                    checkout.chest = [[Chest alloc]init];
                    
                    checkout.chest.name = obj[@"locker"][@"name"];
                    
                    checkout.chest.chestId = [obj[@"locker"][@"id"] integerValue];
                    
                    checkout.chest.area.areaName = obj[@"locker"][@"region_name"];
                    
                }
                
                if (!self.lastCheckout) {
                    
                    self.lastCheckout = checkout;
                    
                }
                
                [checkouts addObject:checkout];
                
            }];
            
            self.checkouts = [checkouts copy];
            
            checkouts = nil;
            
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

-(void)checkinWithCheckin:(Checkin *)checkin result:(void (^)(BOOL, NSString *))result
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
    
    if (checkin.chest.chestId) {
        
        [para setInteger:checkin.chest.chestId forKey:@"locker_id"];
        
    }
    
    if (checkin.checkinId) {
        
        [para setInteger:checkin.checkinId forKey:@"checkin_id"];
        
        [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:CheckinCheckinAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
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
        
    }else{
        
        [para setInteger:checkin.card.cardId forKey:@"card_id"];
        
        [para setInteger:checkin.student.stuId forKey:@"user_id"];
        
        [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CheckinAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
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
    
}

-(void)cancelCheckin:(Checkin *)checkin result:(void (^)(BOOL, NSString *))result
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

    [para setInteger:checkin.checkinId forKey:@"checkin_id"];
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:CheckinAPI,StaffId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)requsetCheckDetailData:(Checkin *)checkin result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:checkin.checkinId forKey:@"checkin_id"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CheckinAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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


-(void)ignoreWithCheckin:(Checkin *)checkin result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:checkin.checkinId forKey:@"checkin_id"];
    
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
