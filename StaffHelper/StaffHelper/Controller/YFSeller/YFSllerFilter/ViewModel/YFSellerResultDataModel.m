//
//  YFSellerResultDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSellerResultDataModel.h"
#import "YFHttpService.h"
#import "YFAppConfig.h"

#define CoachAPI @"/api/v2/staffs/%ld/coaches/users/"
#define CoachAddAPI @"/api/v2/staffs/%ld/coaches/users/all/"

#import "YFRequestHeader.h"


@implementation YFSellerResultDataModel
{
    YFHttpService *_requestService;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoading = NO;
        self.isSuccess = NO;
    }
    return self;
}

-(void)getResponseDatashowLoadingOn:(UIView *)superView Seller:(Seller *)seller andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    self.isLoading = YES;
    self.isSuccess = NO;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
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
    // 搜索全部会员，不加该字段， q 暂时没发现别的作用
    if (self.searchStr.length && self.isChooseStudent == NO) {
        
        [para setParameter:self.searchStr forKey:@"q"];
        
    }
    
    if (seller.sellerId) {
        [para setInteger:seller.sellerId forKey:@"seller_id"];
    }
    
    NSString *urlString;
    if (self.isChooseStudent)
    {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kStaffsUsersRequestYF,StaffId]];
    }
    else
    {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kVTwoSellersUsersRequestYF,StaffId]];
    }
    
    
    weakTypesYF
    if (_requestService)
    {
        [_requestService yf_cancel];
    }
    
    _requestService = [YFHttpService instance];
    
    [_requestService GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        weakS.isLoading = NO;
        weakS.isSuccess = YES;
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            [weakS createDataWithArray:reModel.allDataDic[@"data"][@"users"]];
            
            if (successBlock) {
                successBlock();
            }
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        weakS.isLoading = NO;
        weakS.isSuccess = NO;
        
        if (error.code == - 999)
        {
            DebugLogYF(@"取消了上次的搜索");
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
        
        
        DebugLogYF(@"errorCode:%@",@(error.code));
    }];
    
    
}

-(void)getAddSellerResponseDatashowLoadingOn:(UIView *)superView Seller:(Seller *)seller andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    self.isLoading = YES;
    self.isSuccess = NO;
    
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
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
    
    if (self.searchStr.length) {
        
        [para setParameter:self.searchStr forKey:@"q"];
        
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kVTwoSellersUsersAllRequestYF,StaffId]];
    
    weakTypesYF
    if (_requestService)
    {
        [_requestService yf_cancel];
    }
    
    _requestService = [YFHttpService instance];
    
    [_requestService GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        weakS.isLoading = NO;
        weakS.isSuccess = YES;
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            [weakS createDataWithArray:reModel.allDataDic[@"data"][@"users"]];
            
            if (successBlock) {
                successBlock();
            }
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(NSError * _Nonnull error) {
        weakS.isLoading = NO;
        weakS.isSuccess = NO;
        
        if (error.code == - 999)
        {
            DebugLogYF(@"取消了上次的搜索");
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
        
        
        DebugLogYF(@"errorCode:%@",@(error.code));
    }];
    
    
}


-(void)getResponseDatashowLoadingOn:(UIView *)superView Coach:(Coach *)coach andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    self.isLoading = YES;
    self.isSuccess = NO;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
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
    // 搜索全部会员，不加该字段， q 暂时没发现别的作用
    if (self.searchStr.length && self.isChooseStudent == NO) {
        
        [para setParameter:self.searchStr forKey:@"q"];
        
    }
    
    if (coach.coachId) {
        [para setInteger:coach.coachId forKey:@"coach_id"];
    }
    
    NSString *urlString;
    if (self.isChooseStudent)
    {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kStaffsUsersRequestYF,StaffId]];
    }
    else
    {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:CoachAPI,StaffId]];
    }
    
    
    weakTypesYF
    if (_requestService)
    {
        [_requestService yf_cancel];
    }
    
    _requestService = [YFHttpService instance];
    
    [_requestService GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        weakS.isLoading = NO;
        weakS.isSuccess = YES;
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            [weakS createDataWithArray:reModel.allDataDic[@"data"][@"users"]];
            
            if (successBlock) {
                successBlock();
            }
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        weakS.isLoading = NO;
        weakS.isSuccess = NO;
        
        if (error.code == - 999)
        {
            DebugLogYF(@"取消了上次的搜索");
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
        
        
        DebugLogYF(@"errorCode:%@",@(error.code));
    }];
    
    
}

-(void)getAddCoachResponseDatashowLoadingOn:(UIView *)superView Coach:(Coach *)coach andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    self.isLoading = YES;
    self.isSuccess = NO;
    
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
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
    
    if (self.searchStr.length) {
        
        [para setParameter:self.searchStr forKey:@"q"];
        
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:CoachAddAPI,StaffId]];
    
    weakTypesYF
    if (_requestService)
    {
        [_requestService yf_cancel];
    }
    
    _requestService = [YFHttpService instance];
    
    [_requestService GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        weakS.isLoading = NO;
        weakS.isSuccess = YES;
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            [weakS createDataWithArray:reModel.allDataDic[@"data"][@"users"]];
            
            if (successBlock) {
                successBlock();
            }
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(NSError * _Nonnull error) {
        weakS.isLoading = NO;
        weakS.isSuccess = NO;
        
        if (error.code == - 999)
        {
            DebugLogYF(@"取消了上次的搜索");
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
        
        
        DebugLogYF(@"errorCode:%@",@(error.code));
    }];
    
    
}



-(void)createDataWithArray:(NSArray *)array
{
    
    self.dataArray = [NSMutableArray array];
    
    weakTypesYF
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Student *stu = [[Student alloc]init];
        
        stu.name = obj[@"username"];
        
        stu.sex = [obj[@"gender"] integerValue]?SexTypeWoman:SexTypeMan;
        
        stu.stuId = [obj[@"id"] integerValue];
        
        stu.avatar = [NSURL URLWithString:obj[@"avatar"]];
        
        stu.photo = [NSURL URLWithString:obj[@"checkin_avatar"]];
        
        stu.phone = obj[@"phone"];
        
        stu.remarks = obj[@"remarks"];
        
        if (obj[@"area_code"]) {
            
            stu.country = [[CountryPhoneInfo sharedInfo]getCountryWithCode:obj[@"area_code"]];
            
        }
        
        stu.type = [obj[@"status"] integerValue];
        
        if (obj[@"sellers"]) {
            
            NSMutableArray *sellers = [NSMutableArray array];
            
            [obj[@"sellers"] enumerateObjectsUsingBlock:^(id  _Nonnull sellerObj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Seller *seller = [[Seller alloc]init];
                
                seller.name = sellerObj[@"username"];
                
                seller.sellerId = [sellerObj[@"id"] integerValue];
                
                [sellers addObject:seller];
            }];
            stu.sellers = sellers;
        }
        
        if (obj[@"coaches"]) {
            
            NSMutableArray *coaches = [NSMutableArray array];
            
            [obj[@"coaches"] enumerateObjectsUsingBlock:^(id  _Nonnull coachObj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Coach *coach = [[Coach alloc]init];
                
                coach.name = coachObj[@"username"];
                
                coach.coachId = [coachObj[@"id"] integerValue];
                
                [coaches addObject:coach];
            }];
            stu.coaches = coaches;
        }
        
        NSMutableArray *shops = [NSMutableArray array];
        
        [obj[@"shops"] enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Gym *gym = [[Gym alloc]init];
            
            gym.shopId = [object[@"id"] integerValue];
            
            gym.name = object[@"name"];
            
            gym.brand.brandId = [BRANDID integerValue];
            
            [shops addObject:gym];
        }];
        stu.gyms = shops;
        //        if ([obj[@"head"] length]==1) {
        //            int asciicode = [obj[@"head"] characterAtIndex:0];
        //
        //            if ((asciicode>=65 && asciicode <=90) || (asciicode>=97 && asciicode<=122)) {
        //
        //                stu.head = [obj[@"head"] uppercaseString];
        //            }else
        //            {
        //                stu.head = @"#";
        //            }
        //        }else
        //        {
        //            stu.head = @"#";
        //        }
        [weakS.dataArray addObject:stu];
    }];
}


@end
