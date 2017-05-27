//
//  StaffListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StaffListInfo.h"

#define API @"/api/staffs/%ld/managers/"

#define CreateAPI @"/api/staffs/%ld/users/"

#define ChangeAPI @"/api/staffs/%ld/users/%ld/"

#define DeleteAPI @"/api/staffs/%ld/managers/%ld/"

#define AdminAPI @"/api/staffs/%ld/superuser/"

@interface StaffListInfo ()

{
    
    Gym *_gym;
    
    NSInteger _currentPage;
    
    NSInteger _totalPages;
    
    NSString *_searchStr;
    
}

@end

@implementation StaffListInfo

-(void)requestWithGym:(Gym *)gym andSearchStr:(NSString *)searchStr
{
    
    _gym = gym;
    
    _searchStr = searchStr;
    
    [self update];
    
}

-(void)update
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (_gym.gymId && _gym.type.length){
        
        [para setParameter:_gym.type forKey:@"model"];
        
        [para setInteger:_gym.gymId forKey:@"id"];
        
    }else if(_gym.shopId && _gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:_gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:_gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    if (_searchStr.length) {
        
        [para setParameter:_searchStr forKey:@"q"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"ships"];
            
            NSMutableArray *staffs = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Staff *staff = [[Staff alloc]init];
                
                staff.staffId = [obj[@"user"][@"id"] integerValue];
                
                staff.name = obj[@"user"][@"username"];
                
                staff.phone = obj[@"user"][@"phone"];
                
                staff.admin = [obj[@"is_superuser"] boolValue];
                
                if (obj[@"user"][@"area_code"]) {
                    
                    staff.country = [[CountryPhoneInfo sharedInfo]getCountryWithCode:obj[@"user"][@"area_code"]];
                    
                }
                
                staff.iconUrl = [NSURL URLWithString:obj[@"user"][@"avatar"]];
                
                staff.position.name = obj[@"position"][@"name"];
                
                staff.position.positionId = [obj[@"position"][@"id"] integerValue];
                
                staff.shipId = [obj[@"id"] integerValue];
                
                staff.sex = [obj[@"user"][@"gender"] integerValue]?SexTypeWoman:SexTypeMan;
                
                [staffs addObject:staff];
                
            }];
            
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"staffId" ascending:YES];
            
            NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
            
            staffs = [[staffs sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
            
            self.staffs = [staffs copy];
            
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

-(void)createStaff:(Staff *)staff withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:staff.name forKey:@"username"];
    
    [para setParameter:staff.phone forKey:@"phone"];
    
    [para setParameter:staff.country.countryNo forKey:@"area_code"];
    
    [para setParameter:staff.iconUrl.absoluteString forKey:@"avatar"];
    
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

    [para setParameter:[NSNumber numberWithInteger:staff.position.positionId] forKey:@"position_id"];
    
    [para setParameter:staff.sex == SexTypeMan?@"0":@"1" forKey:@"gender"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CreateAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)editStaff:(Staff *)staff withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:staff.name forKey:@"username"];
    
    [para setParameter:staff.phone forKey:@"phone"];
    
    [para setParameter:staff.country.countryNo forKey:@"area_code"];
    
    [para setParameter:staff.iconUrl.absoluteString forKey:@"avatar"];
    
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

    [para setParameter:staff.sex == SexTypeMan?@"0":@"1" forKey:@"gender"];
    
    [para setParameter:[NSNumber numberWithInteger:staff.position.positionId] forKey:@"position_id"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)staff.staffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)deleteStaff:(Staff *)staff withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:DeleteAPI,StaffId,(long)staff.shipId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)changeAdmin:(Staff *)staff andCode:(NSString *)code result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:staff.name forKey:@"username"];
    
    [para setParameter:staff.phone forKey:@"phone"];
    
    [para setParameter:staff.country.countryNo forKey:@"area_code"];
    
    [para setParameter:code forKey:@"code"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:AdminAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

@end
