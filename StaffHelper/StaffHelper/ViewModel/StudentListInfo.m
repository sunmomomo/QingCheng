//
//  StudentListInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "StudentListInfo.h"

#import "UIColor+Hex.h"

#import "AppDelegate.h"

#define API @"/api/staffs/%ld/users/"

#define CardAPI @"/api/staffs/%ld/method/users/"

#define SellerAPI @"/api/v2/staffs/%ld/sellers/users/"

#define CoachAPI @"/api/v2/staffs/%ld/coaches/users/"

#define SellerAddAPI @"/api/v2/staffs/%ld/sellers/users/all/"

#define CoachAddAPI @"/api/v2/staffs/%ld/coaches/users/all/"

#import "YFListCache.h"
#import "YFDateService.h"

#import "YFAppService.h"
#import "YFAppConfig.h"

@interface StudentListInfo ()
{
    NSMutableArray *_array;
    BOOL _isNeedNoSellerArray;
}

@property(nonatomic,strong)NSMutableArray *allStus;

@end

@implementation StudentListInfo

+(instancetype)shareInfo
{
    
    static StudentListInfo *info;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[self alloc] init];
    });
    
    return info;
    
}

-(void)reloadAllDataWithGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure
{
    
    self.showArray = [NSMutableArray array];
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    [self requestDataWithGym:gym];
    
}

-(void)readContent
{
    
//    NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    
//    NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"studentList.txt"];
//    
//    NSData *data = [NSData dataWithContentsOfFile:newFielPath];
    
    NSDictionary *dic = [YFListCache cacheOnDocumentDicForKey:YFCacheKey];
    
    
    NSMutableArray *array = [YFListCache  cacheOnDocumentStudentArrayFromDic:dic];

    
    if (!array.count) {
        
        [self requestDataWithGym:nil];
        
    }else
    {
        [self createDataWithArray:array];
        
    }
    
}

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.allStus = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(void)requestCardStudentWithGym:(Gym *)gym andIsEdit:(BOOL)isEdit success:(void (^)())success Failure:(void (^)())failure
{
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.showArray = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
    if (isEdit) {
        
        [para setParameter:@"put" forKey:@"method"];
        
    }else{
        
        [para setParameter:@"post" forKey:@"method"];
        
    }
    
    [para setParameter:@"manage_costs" forKey:@"key"];
    
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CardAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"users"]];
            
        }else
        {
            
            if (self.request) {
                self.request(YES);
            }
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess();
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.request) {
            self.request(NO);
        }
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}

-(void)requestChestStudentWithGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure
{
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.showArray = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
    [para setParameter:@"post" forKey:@"method"];
    
    [para setParameter:@"locker_setting" forKey:@"key"];
    
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CardAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"users"]];
            
        }else
        {
            
            if (self.request) {
                self.request(YES);
            }
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess();
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.request) {
            self.request(NO);
        }
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}

-(void)requestWithSeller:(Seller *)seller andGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure
{
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.showArray = [NSMutableArray array];
    
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
    
    if (seller.sellerId) {
        [para setInteger:seller.sellerId forKey:@"seller_id"];
    }
    if (self.fiterOtherModel)
    {
        [self.fiterOtherModel paramWithDictionary:para.data];
    }
    


    DebugLogParamYF(@"%@",para.data);
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:SellerAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"users"]];
            
        }else
        {
            
            if (self.request) {
                self.request(YES);
            }
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess();
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.request) {
            self.request(NO);
        }
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}


-(void)requestWithCoach:(Coach *)coach andGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure
{
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.showArray = [NSMutableArray array];
    
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
    
    if (coach.coachId) {
        [para setInteger:coach.coachId forKey:@"coach_id"];
    }
    if (self.fiterOtherModel)
    {
        [self.fiterOtherModel paramWithDictionary:para.data];
    }
    
    
    
    DebugLogYF(@"%@",para.data);
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CoachAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"users"]];
            
        }else
        {
            
            if (self.request) {
                self.request(YES);
            }
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess();
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.request) {
            self.request(NO);
        }
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}

-(void)requestAddDataWithSeller:(Seller *)seller andGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure
{
    _isNeedNoSellerArray = YES;
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.showArray = [NSMutableArray array];
    
    
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
    if (self.fiterOtherModel)
    {
        [self.fiterOtherModel paramWithDictionary:para.data];
    }

    DebugLogParamYF(@"%@",para.data);

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:SellerAddAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"users"]];
            
        }else
        {
            
            if (self.request) {
                self.request(YES);
            }
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess();
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.request) {
            self.request(NO);
        }
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}

-(void)requestAddDataWithCoach:(Coach *)coach andGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure
{
    _isNeedNoSellerArray = YES;
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.showArray = [NSMutableArray array];
    
    
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
    if (self.fiterOtherModel)
    {
        [self.fiterOtherModel paramWithDictionary:para.data];
    }
    
    DebugLogYF(@"%@",para.data);
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:CoachAddAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"users"]];
            
        }else
        {
            
            if (self.request) {
                self.request(YES);
            }
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess();
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.request) {
            self.request(NO);
        }
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}

-(void)requestAllDataWithGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure
{
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.showArray = [NSMutableArray array];
    
    NSInteger brandId = [[NSUserDefaults standardUserDefaults]integerForKey:@"stu_brand_id"];
    
    if (brandId != [BRANDID integerValue]|| (gym.gymId && (gym.gymId != self.gym.gymId || ![gym.type isEqualToString:self.gym.type]))||(gym.shopId && gym.shopId != self.gym.shopId)||(self.gym && !gym)||(!self.gym && gym) || self.isCannotReadContent == YES) {
        
        [self.allStus removeAllObjects];
        
        [self.students removeAllObjects];
        
        [_array removeAllObjects];
        
        NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
        
        NSString*filePath = [documentsPath stringByAppendingPathComponent:@"studentList.txt"];
        
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        
        [YFListCache removeCacheOnDocumentStudentArrayFromKey:YFCacheKey];
        
        [self requestDataWithGym:gym];
        
    }else
    {
        
        [self readContent];
        
    }
    
}

-(void)requestDataWithGym:(Gym *)gym
{
    
    if (!StaffId) {
        if (self.request) {
            self.request(NO);
        }
        
        if (self.callBackFailure) {
            
            self.callBackFailure(YES);
            
            self.callBackFailure = nil;
            
        }
        
    }else
    {
        
        self.gym = gym;
        
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

        if (self.fiterOtherModel)
        {
            [self.fiterOtherModel paramWithDictionary:para.data];
        }
        
        DebugLogParamYF(@"%@",para.data);

        [[NSUserDefaults standardUserDefaults]setInteger:[BRANDID integerValue] forKey:@"stu_brand_id"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        DebugLogParamYF(@"----:%@",para.data);

        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                [self createDataWithArray:responseDic[@"data"][@"users"]];
                
                [YFListCache setObjectOfDic:responseDic key:YFCacheKey];

                
                NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
                
                NSString*filePath = [documentsPath stringByAppendingPathComponent:@"studentList.txt"];
                    
                NSError*error =nil;
                    
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDic[@"data"][@"users"] options:NSJSONWritingPrettyPrinted error:&error];
                    
                NSString *content = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    
                content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];

                [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                
            }else
            {
                
                if (self.request) {
                    self.request(YES);
                }
                
                if (self.callBackSuccess) {
                    
                    self.callBackSuccess();
                    
                    self.callBackFailure = nil;
                    
                    self.callBackSuccess = nil;
                    
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.request) {
                self.request(NO);
            }
            
            if (self.callBackFailure) {
                
                self.callBackFailure();
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }];
        
    }
    
}

-(void)createDataWithArray:(NSArray *)array
{
    
    self.allStus = [NSMutableArray array];
    
    self.headArray = [NSMutableArray array];
    
    if (_isNeedNoSellerArray) {
        self.showNoSellerArray = [NSMutableArray array];
        
        self.showNoSellerTimeArray = [NSMutableArray array];
    }else
    {
        self.showNoSellerArray = nil;
        
        self.showNoSellerTimeArray = nil;
    }
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Student *stu = [[Student alloc]init];
        
        stu.name = obj[@"username"];
        
        stu.sex = [obj[@"gender"] integerValue]?SexTypeWoman:SexTypeMan;
        
        stu.stuId = [obj[@"id"] integerValue];
        
        stu.avatar = [NSURL URLWithString:obj[@"avatar"]];
        
        stu.photo = [NSURL URLWithString:obj[@"checkin_avatar"]];
        
        stu.phone = obj[@"phone"];
        
        stu.remarks = obj[@"remarks"];
        
        stu.createDate = obj[@"joined_at"];
        
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
            
            [obj[@"coaches"] enumerateObjectsUsingBlock:^(id  _Nonnull sellerObj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Coach *coach = [[Coach alloc]init];
                
                coach.name = sellerObj[@"username"];
                
                coach.coachId = [sellerObj[@"id"] integerValue];
                
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
        
        if ([obj[@"head"] length]==1) {
            
            int asciicode = [obj[@"head"] characterAtIndex:0];
            
            if ((asciicode>=65 && asciicode <=90) || (asciicode>=97 && asciicode<=122)) {
                
                stu.head = [obj[@"head"] uppercaseString];
                
            }else
            {
                
                stu.head = @"#";
                
            }
            
        }else
        {
            
            stu.head = @"#";
            
        }
        
        if (![self.headArray containsObject:stu.head]) {
            
            [self.headArray addObject:stu.head];
            
        }
        
        [self.allStus addObject:stu];
        
    }];
    
    [self getShowArrayWithSearchStr];
    
    if (self.fiterOtherModel)
    {
        weakTypesYF
        [YFAppService asypath:^{
            [weakS setTimeArraySorted];
        } mainAction:^{
            if (weakS.request) {
                weakS.request(YES);
            }
            if (weakS.callBackSuccess) {
                
                weakS.callBackSuccess();
                
                weakS.callBackFailure = nil;
                
                weakS.callBackSuccess = nil;
                
            }

        }];
        
    }else
    {
        if (self.request) {
            self.request(YES);
        }
        if (self.callBackSuccess) {
            
            self.callBackSuccess();
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }

    }
    
    
    
    
}

-(void)dealArray
{
    
    self.showArray = [NSMutableArray array];
    
    if (_isNeedNoSellerArray) {
        self.showNoSellerArray = [NSMutableArray array];
    }
    
    [self.headArray sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]]];
    
    if ([self.headArray containsObject:@"#"]) {
        
        [self.headArray removeObjectAtIndex:0];
        
        [self.headArray addObject:@"#"];
    }
    
    [self.headArray enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *array =[NSMutableArray array];
        
        NSMutableArray *nosellerArray ;
        if (_isNeedNoSellerArray) {
           nosellerArray = [NSMutableArray array];
        }
        
        for (Student *stu in _array) {
            
            if ([stu.head isEqualToString:obj]) {
                
                [array addObject:stu];
                
                if (_isNeedNoSellerArray) {
                    if (!stu.sellers.count) {
                        [nosellerArray addObject:stu];
                    }
                }
            }
            
        }
        
        if (array.count) {
            
            [self.showArray addObject:@{@"head":obj,@"data":array}];

        }
        if (_isNeedNoSellerArray && nosellerArray.count)
        {
            [self.showNoSellerArray addObject:@{@"head":obj,@"data":nosellerArray}];
        }
        
        
    }];
    
}





-(void)setSearchStr:(NSString *)searchStr
{
    
    _searchStr = searchStr;
    
    [self getShowArrayWithSearchStr];
    
}

-(void)getShowArrayWithSearchStr
{
    
    _array = [NSMutableArray array];
    
    if (self.searchStr.length==0) {
        
        _array = self.allStus;
        
    }else if(self.searchStr.length != 0)
    {
        
        for (Student *stu in self.allStus) {
            
            if ([[stu.name lowercaseString] rangeOfString:[self.searchStr lowercaseString]].length||[stu.phone rangeOfString:self.searchStr].length) {
                
                [_array addObject:stu];
                
            }
            
        }
        
    }
    
    self.students = _array;
    
    [self dealArray];
    
}

- (void)setTimeArraySorted
{
    NSDateFormatter *df = [YFDateService dateformatter];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    
    NSComparator cmptr = ^(Student *obj1,Student* obj2){
        
        NSString *timeStr1 = [obj1.createDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        NSString *timeStr2 = [obj2.createDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
//        timeStr1 = [timeStr1 stringByReplacingOccurrencesOfString:@"Z" withString:@""];
//        timeStr2 = [timeStr2 stringByReplacingOccurrencesOfString:@"Z" withString:@""];
        NSTimeInterval timeinter1 =  [[df dateFromString:timeStr1] timeIntervalSince1970];
        
        NSTimeInterval timeinter2 =  [[df dateFromString:timeStr2] timeIntervalSince1970];
        
        if (timeinter1 > timeinter2)
        {
            return NSOrderedAscending;
        }else
        {
            return NSOrderedDescending;
        }
    };
    
    self.showTimeArray = [NSMutableArray array];
    
    NSMutableArray *timeSubArray = [self.allStus mutableCopy];

    [self.showTimeArray addObject:@{@"head":@"",@"data":timeSubArray}];
    
    self.studentCount = timeSubArray.count;
    
    [timeSubArray sortUsingComparator:cmptr];
    
    
    if (_isNeedNoSellerArray) {
        self.showNoSellerTimeArray = [NSMutableArray array];
        
        NSMutableArray *timeNoSellerSubArray = [NSMutableArray array];
        
        for (Student *stu in timeSubArray) {
            if (!stu.sellers.count)
            {
                [timeNoSellerSubArray addObject:stu];
            }
        }
        [self.showNoSellerTimeArray addObject:@{@"head":@"",@"data":timeNoSellerSubArray}];
        self.studentNoSellerCount = timeNoSellerSubArray.count;
    }
    
   
//        for (Student *model in timeSubArray)
//        {
//            NSLog(@"-------:%@",model.createDate);
//        }
}



@end
