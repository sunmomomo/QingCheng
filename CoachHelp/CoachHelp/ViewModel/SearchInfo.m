//
//  SearchInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "SearchInfo.h"

#define GYMAPI @"/api/gym/"

#define OGNAPI @"/api/organizations/"

@interface SearchInfo ()

{
    
    NSInteger _dataNum;
    
}

@end

@implementation SearchInfo

-(instancetype)initGymInfoWithStr:(NSString *)str
{
    
    if (self = [super init]) {
        
        self.gymArr = [NSMutableArray array];
        
        self.hotGymArr = [NSMutableArray array];
        
        self.searchStr = [[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        _dataNum = 0;
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_hot"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:GYMAPI param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                NSArray *array = responseDic[@"data"][@"gym"];
                
                [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Gym *gym = [[Gym alloc]init];
                    
                    gym.gymId = [obj[@"id"] integerValue];
                    
                    gym.name = obj[@"name"];
                    
//                    gym.districtId = [obj[@"district"][@"id"] integerValue];
                    
                    gym.city = obj[@"district"][@"city"][@"name"];
                    
                    gym.ishot = [obj[@"is_hot"]boolValue];
                    
                    gym.contact = obj[@"contact"];
                    
                    gym.brandName = obj[@"brand_name"];
                    
                    gym.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                    
                    gym.isCertificate = [obj[@"is_authenticated"]boolValue];
                    
                    if (gym.ishot) {
                        
                        [self.hotGymArr addObject:gym];
                        
                    }
                    
                }];
                
                if (self.searchStr.length<3) {
                    
                    if (self.request) {
                        self.request(YES);
                    }
                    
                }else
                {
                    
                    _dataNum ++;
                    
                    [self dataFinish];
                    
                }
                
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
        
        if (self.searchStr.length>=3) {
            
            Parameters *para = [[Parameters alloc]init];
        
            [para setParameter:self.searchStr forKey:@"q"];
            
            [MOAFHelp AFGetHost:ROOT bindPath:GYMAPI param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                if ([responseDic[@"status"]integerValue]==200) {
                    
                    NSArray *array = responseDic[@"data"][@"gym"];
                    
                    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Gym *gym = [[Gym alloc]init];
                        
                        gym.gymId = [obj[@"id"] integerValue];
                        
                        gym.name = obj[@"name"];
                        
                        gym.brandName = obj[@"brand_name"];
                        
//                        gym.districtId = [obj[@"district"][@"id"] integerValue];
                        
                        gym.ishot = [obj[@"is_hot"]boolValue];
                        
                        gym.contact = obj[@"contact"];
                        
                        gym.city = obj[@"district"][@"city"][@"name"];
                                                
                        gym.brandName = obj[@"brand_name"];
                        
                        gym.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                        
                        gym.isCertificate = [obj[@"is_authenticated"]boolValue];
                        
                        [self.gymArr addObject:gym];
                        
                    }];
                        
                    _dataNum ++;
                        
                    [self dataFinish];
                    
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
        
        
    }
    
    return self;
    
}

-(void)dataFinish
{
    
    if (_dataNum == 2) {
        
        if (self.request) {
            self.request(YES);
        }
        
    }
    
}


-(instancetype)initOgnInfoWithStr:(NSString *)str
{
    
    if (self = [super init]) {
        
        self.organizationsArr = [NSMutableArray array];
        
        self.hotOrganizationsArr = [NSMutableArray array];
        
        self.searchStr = [[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        _dataNum = 0;
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_hot"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:OGNAPI param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                NSArray *array = responseDic[@"data"][@"organizations"];
                
                [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * stop) {
                    
                    Organization *ogn = [[Organization alloc]init];
                    
                    ogn.name = obj[@"name"];
                    
                    ogn.contact = obj[@"contact"];
                    
                    ogn.ognId = [obj[@"id"]integerValue];
                    
                    ogn.isCertificate = [obj[@"is_authenticated"]boolValue];
                    
                    ogn.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                    
                    ogn.ishot = [obj[@"is_hot"] boolValue];
                    
                    if (ogn.ishot) {
                        
                        [self.hotOrganizationsArr addObject:ogn];
                        
                    }
                    
                }];
                
                if (self.searchStr.length<3) {
                    
                    if (self.request) {
                        self.request(YES);
                    }
                    
                }else
                {
                    
                    _dataNum ++;
                    
                    [self dataFinish];
                    
                }
                
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
        
        if (self.searchStr.length>=3) {
            
            Parameters *para = [[Parameters alloc]init];
        
            [para setParameter:self.searchStr forKey:@"q"];
            
            [MOAFHelp AFGetHost:ROOT bindPath:OGNAPI param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                if ([responseDic[@"status"]integerValue] == 200) {
                    
                    NSArray *array = responseDic[@"data"][@"organizations"];
                    
                    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * stop) {
                        
                        Organization *ogn = [[Organization alloc]init];
                        
                        ogn.name = obj[@"name"];
                        
                        ogn.contact = obj[@"contact"];
                        
                        ogn.ognId = [obj[@"id"] integerValue];
                        
                        ogn.ishot = [obj[@"is_hot"] boolValue];
                        
                        [self.organizationsArr addObject:ogn];
                        
                    }];
                    
                    _dataNum ++;
                    
                    [self dataFinish];
                    
                }else
                {
                    if (self.request) {
                        self.request(NO);
                    }
                    
                }
                
            } failure:^(AFHTTPSessionManager *operation, NSString *error) {
                
            }];
            
        }
       
        
    }
    
    return self;
    
}

@end
