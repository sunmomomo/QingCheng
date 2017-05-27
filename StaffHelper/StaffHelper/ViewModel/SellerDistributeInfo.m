//
//  SellerDistributeInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerDistributeInfo.h"

#import "NSObject+YFExtension.h"

#define ListAPI @"/api/v2/staffs/%ld/sellers/preview/"

#define DeleteAPI @"/api/v2/staffs/%ld/sellers/users/"

#define BatchDeleteAPI @"/api/v2/staffs/%ld/sellers/users/remove/"

#define AddAPI @"/api/v2/staffs/%ld/sellers/users/"

#define ChangeAPI @"/api/v2/staffs/%ld/sellers/users/"

@implementation SellerDistributeInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.sellers = [NSMutableArray array];
        
    }
    return self;
}

-(void)requestWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:ListAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        __block Seller *noneSeller ;
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [responseDic[@"data"][@"sellers"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Seller *seller = [[Seller alloc]init];
                
                seller.userCount = [obj[@"count"] integerValue];
                
                seller.sellerId = [obj[@"seller"][@"id"] integerValue];
                
                seller.name = obj[@"seller"][@"username"];
                
                seller.avatar = [obj[@"seller"][@"avatar"] guardStringYF];
                
                seller.sexType = [obj[@"seller"][@"gender"] integerValue];

                
                if (!seller.sellerId) {
                    
                    seller.type = SellerTypeNone;
                    noneSeller = seller;
                }else{
                    
                    seller.type = SellerTypeNormal;
                    [self.sellers addObject:seller];

                }
                
                NSMutableArray *users = [NSMutableArray array];
                
                for (NSString *name in obj[@"users"]) {
                    
                    Student *user = [[Student alloc]init];
                    
                    user.name = name;
                    
                    [users addObject:user];
                    
                }
                
                seller.users = users;
                
                
            }];
            
            if (noneSeller) {
                [self.sellers insertObject:noneSeller atIndex:0];
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

-(void)deleteUser:(Student *)user withSeller:(Seller*)seller withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [para setInteger:user.stuId forKey:@"user_id"];
    
    [para setInteger:seller.sellerId forKey:@"seller_id"];
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:DeleteAPI,StaffId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)deleteUsers:(NSArray *)users withSeller:(Seller*)seller withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [para setInteger:seller.sellerId forKey:@"seller_id"];
    
    NSString *userIdStr = @"";
    
    for(NSInteger i = 0;i<users.count;i++){
        
        Student *user = users[i];
        
        userIdStr = [userIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)user.stuId]];
        
        if (i<users.count-1) {
            
            userIdStr = [userIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIdStr forKey:@"user_ids"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:BatchDeleteAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic)  {
        
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

-(void)changeUsers:(NSArray *)users withOriginalSeller:(Seller *)originalSeller withSellers:(NSArray *)sellers withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    NSString *userIdStr = @"";
    
    for(NSInteger i = 0;i<users.count;i++){
        
        Student *user = users[i];
        
        userIdStr = [userIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)user.stuId]];
        
        if (i<users.count-1) {
            
            userIdStr = [userIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIdStr forKey:@"user_ids"];
    
    NSString *sellerIdStr = @"";
    
    for(NSInteger i = 0;i<sellers.count;i++){
        
        Seller *seller = sellers[i];
        
        sellerIdStr = [sellerIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)seller.sellerId]];
        
        if (i<sellers.count-1) {
            
            sellerIdStr = [sellerIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:sellerIdStr forKey:@"seller_ids"];
    
    if (originalSeller.sellerId) {
        
        [para setInteger:originalSeller.sellerId forKey:@"seller_id"];
        
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic)  {
        
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

-(void)addUsers:(NSArray *)users withSeller:(Seller *)seller withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    NSString *userIdStr = @"";
    
    for(NSInteger i = 0;i<users.count;i++){
        
        Student *user = users[i];
        
        userIdStr = [userIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)user.stuId]];
        
        if (i<users.count-1) {
            
            userIdStr = [userIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIdStr forKey:@"user_ids"];
    
    [para setInteger:seller.sellerId forKey:@"seller_id"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:AddAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic)  {
        
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

-(void)dealloc
{
    
}

@end
