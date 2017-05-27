//
//  CardKindListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindListInfo.h"

#import "UIColor+Hex.h"

#define GymAPI @"/api/v2/coaches/%ld/cardtpls/"

#define PermissionAPI @"/api/coaches/%ld/method/cardtpls/"

@interface CardKindListInfo ()

{
    
    NSInteger _page;
    
    NSInteger _totalPage;
    
}

@end

@implementation CardKindListInfo

-(void)requestCardCreateCardKindsWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [para setParameter:@"post" forKey:@"method"];
    
    [para setParameter:@"cardsetting" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"]];
            
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

-(void)requestCourseWayCardKindsWithCourseType:(CourseType)courseType andIsEdit:(BOOL)isEdit andGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [para setParameter:isEdit?@"put":@"post" forKey:@"method"];
    
    if (courseType == CourseTypeGroup) {
        
        [para setParameter:@"teamarrange_calendar" forKey:@"key"];
        
    }else{
        
        [para setParameter:@"priarrange_calendar" forKey:@"key"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"]];
            
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


-(void)requestReportCardKindsWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"get" forKey:@"method"];
    
    [para setParameter:@"sales_report" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"]];
            
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

-(void)requestCheckinReportCardKindsWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"get" forKey:@"method"];
    
    [para setParameter:@"checkin_report" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"]];
            
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

-(void)requestResult:(void (^)(BOOL, NSString *))result
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

    [para setParameter:@"1" forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:GymAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"]];
            
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cardKinds = [NSMutableArray array];
        
        self.gyms = [NSMutableArray array];
        
        _page = 0;
        
        _totalPage = 1;
        
    }
    return self;
}


-(void)createDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CardKind *kind = [[CardKind alloc]init];
        
        kind.color = [UIColor colorWithHexString:obj[@"color"]];
        
        kind.type = [obj[@"type"] integerValue];
        
        kind.preTimes = [obj[@"pre_times"] integerValue];
        
        kind.monthTimes = [obj[@"month_times"] integerValue];
        
        kind.cardKindId = [obj[@"id"] integerValue];
        
        kind.isLimit = [obj[@"is_limit"] boolValue];
        
        kind.dayTimes = [obj[@"day_times"] integerValue];
        
        kind.summary = obj[@"description"];
        
        kind.weekTimes = [obj[@"week_times"] integerValue];
        
        kind.cardKindName = obj[@"name"];
        
        kind.maxCardCount = [obj[@"buy_limit"] integerValue];
        
        if (kind.isLimit) {
            
            kind.astrict = kind.preTimes?(kind.dayTimes||kind.weekTimes||kind.monthTimes)?[NSString stringWithFormat:@"可提前预约%ld节课，每%@共计可上%ld节课",(long)kind.preTimes,kind.dayTimes?@"天":kind.weekTimes?@"周":@"月",(long)(kind.dayTimes?kind.dayTimes:kind.weekTimes?kind.weekTimes:kind.monthTimes)]:[NSString stringWithFormat:@"可提前预约%ld节课",(long)kind.preTimes]:(kind.dayTimes||kind.weekTimes||kind.monthTimes)?[NSString stringWithFormat:@"每%@共计可上%ld节课",kind.dayTimes?@"天":kind.weekTimes?@"周":@"月",(long)(kind.dayTimes?kind.dayTimes:kind.weekTimes?kind.weekTimes:kind.monthTimes)]:@"";
            
            if (kind.maxCardCount) {
                
                if (kind.astrict.length) {
                    
                    kind.astrict = [NSString stringWithFormat:@"%@，每个会员限购%ld张",kind.astrict,(long)kind.maxCardCount];
                    
                }else{
                    
                    kind.astrict = [NSString stringWithFormat:@"每个会员限购%ld张",(long)kind.maxCardCount];
                    
                }
                
            }
            
        }else
        {
            
            kind.astrict = nil;
            
        }
        
        NSArray *specs = obj[@"options"];
        
        [specs enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Spec *spec = [[Spec alloc]init];
            
            spec.summary = obj[@"description"];
            
            spec.specId = [obj[@"id"] integerValue];
            
            spec.price = [obj[@"price"] stringValue];
            
            spec.charge = [obj[@"charge"] stringValue];
            
            spec.canRecharge = [obj[@"can_charge"] boolValue];
            
            spec.canCreate = [obj[@"can_create"] boolValue];
            
            spec.checkValid = [obj[@"limit_days"] boolValue];
            
            CardKind *cardKind = [[CardKind alloc]init];
            
            cardKind.cardKindId = [obj[@"card_tpl"][@"id"] integerValue];
            
            cardKind.type = [obj[@"card_tpl"][@"type"] integerValue];
            
            cardKind.cardKindName = obj[@"card_tpl"][@"name"];
            
            spec.cardKind = cardKind;
            
            [kind.specs addObject:spec];
            
        }];
        
        NSArray *shopDict = obj[@"shops"];
        
        [shopDict enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Gym *gym = [[Gym alloc]init];
            
            gym.shopId = [object[@"id"] integerValue];
            
            gym.name = object[@"name"];
            
            [kind.gyms addObject:gym];
            
        }];
        
        [self.cardKinds addObject:kind];
        
    }];
    
}

-(NSArray*)getShowArrayWithGym:(Gym *)gym
{
    
    if (!gym) {
        
        return self.cardKinds;
        
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CardKind *kind in self.cardKinds) {
        
        [kind.gyms enumerateObjectsUsingBlock:^(Gym *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.gymId == gym.gymId && obj.type ==gym.type) {
                
                [array addObject:kind];
                
                *stop = YES;
                
            }else if (obj.shopId == gym.shopId && gym.brand.brandId == obj.brand.brandId){
                
                [array addObject:kind];
                
                *stop = YES;
                
            }
            
        }];
        
    }
    
    return array;
    
}

-(NSArray *)getShowArrayWithType:(CardKindType)type
{
    
    if (!type) {
        return self.cardKinds;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CardKind *kind in self.cardKinds) {
        
        if (kind.type == type) {
            
            [array addObject:kind];
            
        }
        
    }
    
    return array;
    
}

-(NSArray *)getShowArrayWithSingle:(BOOL)single andType:(CardKindType)type
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CardKind *kind in self.cardKinds) {
        
        if (single && kind.gyms.count == 1) {
            
            if (!type) {
                
                [array addObject:kind];
                
            }
            
            if (type && kind.type == type) {
                
                [array addObject:kind];
                
            }
            
        }else if(!single && kind.gyms.count>1){
            
            if (!type) {
                
                [array addObject:kind];
                
            }
            
            if (type && kind.type == type) {
                
                [array addObject:kind];
                
            }
            
        }
        
    }
    
    return array;
    
}

@end
