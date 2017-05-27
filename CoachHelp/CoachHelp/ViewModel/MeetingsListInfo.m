//
//  MeetingsListInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MeetingsListInfo.h"

#define API @"/api/meetings/"

@implementation MeetingsListInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.meetings = [NSMutableArray array];
        
        
    }
    
    return self;
    
}

-(void)requestData
{
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:PushDistribute forKey:@"oem"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:API param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"meetings"]];
            
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
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Meeting *meeting = [[Meeting alloc]init];
        
        meeting.title = obj[@"name"];
        
        if ([obj[@"open_start"] length]>=10 && [obj[@"open_end"] length]>=10) {
            
            meeting.time = [NSString stringWithFormat:@"%@至%@",[obj[@"open_start"]  substringToIndex:10],[obj[@"open_end"]  substringToIndex:10]];
            
        }
        
        meeting.city = obj[@"city"];
        
        meeting.address = obj[@"address"];
        
        meeting.link = [NSURL URLWithString:[obj[@"link"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
        
        meeting.image = [NSURL URLWithString:obj[@"image"]];
        
        [self.meetings addObject:meeting];
        
    }];
    
    if (self.request) {
        
        self.request(YES);
        
    }
    
}

@end
