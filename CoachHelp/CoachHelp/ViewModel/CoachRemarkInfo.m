//
//  CoachRemarkInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CoachRemarkInfo.h"

#define API @"/api/coaches/%ld/evaluate/"

@implementation CoachRemarkInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.tags = [NSArray array];
        
        NSString *api = [NSString stringWithFormat:API,CoachId];
        
        [MOAFHelp AFGetHost:ROOT bindPath:api param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                self.tags = responseDic[@"data"][@"impression"];

                if (self.request) {
                    self.request(YES);
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
        
        
        
    }
    
    return self;
    
}

@end
