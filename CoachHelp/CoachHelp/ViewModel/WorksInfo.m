//
//  WorksInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WorksInfo.h"

#define API @"/api/coaches/%ld/experiences/"

@implementation WorksInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        _pages = 1;
        
        self.works = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(void)updataData
{
    
    NSString *api = [NSString stringWithFormat:API,CoachId];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:_pages forKey:@"page"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"experiences"]];
            
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

-(void)createDataWithArray:(NSArray *)array
{
    
    if (array.count) {
    
        self.pages++;
        
    }
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Work *work = [[Work alloc]init];
        
        work.isVerified = [obj[@"is_authenticated"] boolValue];
        
        work.title = obj[@"gym"][@"name"];
        
        if ([obj[@"start"] length]>=10)
            work.startTime = [obj[@"start"] substringToIndex:10];
        
        if ([obj[@"end"]length]>=10)
            work.endTime = [obj[@"end"] substringToIndex:10];
        
        work.summary = obj[@"description"];
        
        work.workId = [obj[@"id"] integerValue];
        
        work.isHide = [obj[@"is_hidden"]boolValue];
        
        work.job = obj[@"position"];
        
        work.group_course = [obj[@"group_course"] integerValue];;
        
        work.group_user = [obj[@"group_user"] integerValue];
        
        work.private_course = [obj[@"private_course"] integerValue];
        
        work.private_user = [obj[@"private_user"] integerValue];
        
        work.showPrivate = ![obj[@"private_is_hidden"]boolValue];
        
        work.showGroup = ![obj[@"group_is_hidden"]boolValue];
        
        work.showSale = ![obj[@"sale_is_hidden"]boolValue];
        
        work.sale = [obj[@"sale"] integerValue];
        
        Gym *gym = [[Gym alloc]init];
        
        gym.name = obj[@"gym"][@"name"];
        
        gym.gymId = [obj[@"gym"][@"id"] integerValue];
        
        gym.city = obj[@"gym"][@"district"][@"city"][@"name"];
        
        gym.isCertificate = [obj[@"gym"][@"is_authenticated"]boolValue];
        
        gym.imgUrl = [NSURL URLWithString:obj[@"gym"][@"photo"]];
        
        gym.contact = obj[@"gym"][@"contact"];
        
        gym.brandName = obj[@"gym"][@"brand_name"];
        
        gym.ishot = [obj[@"gym"][@"is_hot"]boolValue];
        
        work.gym = gym;
        
        work.descriptions = obj[@"description"];
        
        NSString *str = [NSString stringWithFormat:@"团课%ld节，服务%ld人次；私教%ld节，服务%ld人次；销售额达%ld元；",(long)work.group_course,(long)work.group_user,(long)work.private_course,(long)work.private_user,(long)work.sale];
        
        if ([str rangeOfString:@"团课0节，服务0人次；"].length) {
            
            str = [str stringByReplacingOccurrencesOfString:@"团课0节，服务0人次；" withString:@""];
            
        }
        
        if ([str rangeOfString:@"私教0节，服务0人次；"].length) {
            
            str = [str stringByReplacingOccurrencesOfString:@"私教0节，服务0人次；" withString:@""];
            
        }
        
        if ([str rangeOfString:@"销售额达0元；"].length) {
            
            str = [str stringByReplacingOccurrencesOfString:@"销售额达0元；" withString:@""];
            
        }
        
        if (!work.group_course && !work.private_course &&!work.sale && !work.group_user && !work.private_user) {
            
            str = @"无";
            
        }
        
        work.performance = str;
        
        if (self.noHide) {
            
            if (!work.isHide) {
            
                [self.works addObject:work];
                
            }
            
        }else
        {
            
            [self.works addObject:work];
            
        }
        
    }];
    
    if (self.request) {
        
        self.request(YES);
        
    }
    
}

@end
