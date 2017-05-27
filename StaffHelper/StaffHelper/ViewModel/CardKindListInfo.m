//
//  CardKindListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindListInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/v2/staffs/%ld/cardtpls/all/"

#define PermissionAPI @"/api/staffs/%ld/method/cardtpls/"

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
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:@"post" forKey:@"method"];
    
    [para setParameter:@"cardsetting" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:isEdit?@"put":@"post" forKey:@"method"];
    
    if (courseType == CourseTypeGroup) {
        
        [para setParameter:@"teamarrange_calendar" forKey:@"key"];
        
    }else{
        
        [para setParameter:@"priarrange_calendar" forKey:@"key"];
        
    }
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:@"get" forKey:@"method"];
    
    [para setParameter:@"sales_report" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:@"get" forKey:@"method"];
    
    [para setParameter:@"checkin_report" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)requestWithGym:(Gym *)gym
{
    
    Parameters *para = [[Parameters alloc]init];
    
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
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"]];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}


-(void)requestCardWithGymYF:(Gym *)gym
{
    
    Parameters *para = [[Parameters alloc]init];
    
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
//    http://cloudtest.qingchengfit.cn/api/staffs/3288/method/cardtpls/?show_all=1&method=get&id=10039&key=cardsetting&model=staff_gym
    [para setParameter:@"get" forKey:@"method"];
    
    [para setParameter:@"cardsetting" forKey:@"key"];

//    http://cloud.qingchengfit.cn/api/staffs/24889/method/cardtpls/?show_all=1&method=get&id=30611&key=cardsetting&model=staff_gym
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"] isSorted:NO];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
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


-(void)requestYFForBrand
{
    
    if (_totalPage && _page>=_totalPage) {
        
        if (self.requestFinish) {
            
            self.requestFinish(YES);
            
        }
        
        return;
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    [para setParameter:@"get" forKey:@"method"];
    
    [para setParameter:@"cardsetting" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"] isSorted:NO];
            
            _page = [responseDic[@"data"][@"current_page"] integerValue];
            
            _totalPage = [responseDic[@"data"][@"pages"] integerValue];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}


-(void)request
{
    
    if (_totalPage && _page>=_totalPage) {
        
        if (self.requestFinish) {
            
            self.requestFinish(YES);
            
        }
        
        return;
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
        
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_tpls"]];
            
            _page = [responseDic[@"data"][@"current_page"] integerValue];
            
            _totalPage = [responseDic[@"data"][@"pages"] integerValue];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
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
    
    [self createDataWithArray:array isSorted:YES];
    
}


-(void)createDataWithArray:(NSArray *)array isSorted:(BOOL)isFiter
{
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CardKind *kind = [[CardKind alloc]init];
        
        kind.cardKindId = [obj[@"id"] integerValue];
        
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
        
        kind.state = [obj[@"is_enable"]boolValue]?CardKindStateNormal:CardKindStateStop;
        
        kind.canCancel = YES;
        
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
            
            spec.onlyStaffCanSee = [obj[@"for_staff"]boolValue];
            
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
            
            gym.brand.brandId = [BRANDID integerValue];
            
            [kind.gyms addObject:gym];
            
        }];
        
        [self.cardKinds addObject:kind];
        
    }];
    
    if (isFiter)
    {
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"_cardKindId" ascending:NO];
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
        
        self.cardKinds = [[self.cardKinds sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    }
    
}

-(NSArray *)getShowArrayWithType:(CardKindType)type andState:(CardKindState)state andGym:(Gym *)gym
{
    
    if (!type) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (CardKind *kind in self.cardKinds) {
            
            if (kind.state == state) {
                
                if (gym) {
                    
                    BOOL contains = NO;
                    
                    for (Gym *tempGym in kind.gyms) {
                        
                        if ([tempGym isEqualToGym:gym]) {
                            
                            contains = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (contains) {
                        
                        [array addObject:kind];
                        
                    }
                    
                }else{
                    
                    [array addObject:kind];
                    
                }
                
            }
            
        }
        
        return [array copy];
        
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CardKind *kind in self.cardKinds) {
        
        if (kind.type == type && kind.state == state) {
            
            if (gym) {
                
                BOOL contains = NO;
                
                for (Gym *tempGym in kind.gyms) {
                    
                    if ([tempGym isEqualToGym:gym]) {
                        
                        contains = YES;
                        
                        break;
                        
                    }
                    
                }
                
                if (contains) {
                    
                    [array addObject:kind];
                    
                }
                
            }else{
                
                [array addObject:kind];
                
            }
            
        }
        
    }
    
    return array;
    
}

-(NSArray *)getShowArrayWithSingle:(BOOL)single andType:(CardKindType)type andState:(CardKindState)state andGym:(Gym *)gym
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CardKind *kind in self.cardKinds) {
        
        if (single && kind.gyms.count == 1) {
            
            if (kind.state == state) {
                
                if (!type) {
                    
                    if (gym) {
                        
                        BOOL contains = NO;
                        
                        for (Gym *tempGym in kind.gyms) {
                            
                            if ([tempGym isEqualToGym:gym]) {
                                
                                contains = YES;
                                
                                break;
                                
                            }
                            
                        }
                        
                        if (contains) {
                            
                            [array addObject:kind];
                            
                        }
                        
                    }else{
                        
                        [array addObject:kind];
                        
                    }
                    
                }
                
                if (type && kind.type == type) {
                    
                    if (gym) {
                        
                        BOOL contains = NO;
                        
                        for (Gym *tempGym in kind.gyms) {
                            
                            if ([tempGym isEqualToGym:gym]) {
                                
                                contains = YES;
                                
                                break;
                                
                            }
                            
                        }
                        
                        if (contains) {
                            
                            [array addObject:kind];
                            
                        }
                        
                    }else{
                        
                        [array addObject:kind];
                        
                    }
                    
                }
                
            }
            
        }else if(!single && kind.gyms.count>1){
            
            if (kind.state == state) {
                
                if (!type) {
                    
                    if (gym) {
                        
                        BOOL contains = NO;
                        
                        for (Gym *tempGym in kind.gyms) {
                            
                            if ([tempGym isEqualToGym:gym]) {
                                
                                contains = YES;
                                
                                break;
                                
                            }
                            
                        }
                        
                        if (contains) {
                            
                            [array addObject:kind];
                            
                        }
                        
                    }else{
                        
                        [array addObject:kind];
                        
                    }
                    
                }
                
                if (type && kind.type == type) {
                    
                    if (gym) {
                        
                        BOOL contains = NO;
                        
                        for (Gym *tempGym in kind.gyms) {
                            
                            if ([tempGym isEqualToGym:gym]) {
                                
                                contains = YES;
                                
                                break;
                                
                            }
                            
                        }
                        
                        if (contains) {
                            
                            [array addObject:kind];
                            
                        }
                        
                    }else{
                        
                        [array addObject:kind];
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    return array;
    
}

@end
