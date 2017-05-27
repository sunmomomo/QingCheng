//
//  DiscoverInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/12/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "DiscoverInfo.h"

#define API @"/api/qingcheng/activities/notify/"

@implementation DiscoverInfo

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    [MOAFHelp AFGetHost:ROOT bindPath:API param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.haveNew = [responseDic[@"data"][@"count"] integerValue];
            
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
