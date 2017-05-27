//
//  QualitiesInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "QualitiesInfo.h"

#define API @"/api/coaches/%ld/certificates/"

@implementation QualitiesInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.pages = 1;
        
        self.qualities = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(void)updataData
{
    
    NSString *api = [NSString stringWithFormat:API,CoachId];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:self.pages forKey:@"page"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"certificates"]];
            
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
        
        Quality *quality = [[Quality alloc]init];
        
        quality.title = obj[@"name"];
        
        Organization *organization = [[Organization alloc]init];
        
        organization.name = obj[@"organization"][@"name"];
        
        organization.ognId = [obj[@"organization"][@"id"]integerValue];
        
        organization.contact = obj[@"organization"][@"contact"];
        
        organization.imgUrl = [NSURL URLWithString:obj[@"organization"][@"photo"]];
        
        quality.organization = organization;
        
        quality.qualityId = [obj[@"id"] integerValue];
        
        if ([obj[@"date_of_issue"] length]>=10) {
            
            quality.issueTime = [obj[@"date_of_issue"] substringToIndex:10];
            
        }
        
        if ([obj[@"start"] length]>=10) {
            
            quality.startTime = [obj[@"start"] substringToIndex:10];
            
        }
        
        if ([obj[@"end"] length]>=10) {
            
            quality.endTime = [obj[@"end"] substringToIndex:10];
            
        }
        
        quality.grade = obj[@"grade"];
        
        quality.photo = [NSURL URLWithString:obj[@"photo"]];
        
        quality.type = [obj[@"type"] integerValue];
        
        quality.certificateName = obj[@"certificate_name"];
        
        quality.isVerified = [obj[@"is_authenticated"] boolValue];
        
        quality.isHidden = [obj[@"is_hidden"] boolValue];
        
        quality.willExpired = [obj[@"will_expired"] boolValue];
        
        if (self.noHide) {
            
            if (!quality.isHidden) {
                
                [self.qualities addObject:quality];
                
            }
            
        }else
        {
            
            [self.qualities addObject:quality];
            
        }
        
        
    }];
    
    if (self.request) {
        
        self.request(YES);
        
    }
    
}

@end
