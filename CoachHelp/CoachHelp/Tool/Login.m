//
//  Login.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "Login.h"

#import "BPush.h"

//登录API
#define kPwdLogin @"/api/v1/coaches/login/"

#define kPushApi @"/api/coaches/%ld/push/update/"

@implementation Login

+(instancetype)loginWithPhone:(NSString *)phone andCountryNo:(NSString*)countryNo andPassword:(NSString *)password success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString *errorDesc))failure
{
    
    Login *login = [[Login alloc]init];
    
    login.callBackSuccess = success;
    
    login.callBackFailure = failure;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:phone forKey:@"phone"];
    
    [para setParameter:password forKey:@"password"];
    
    [para setParameter:countryNo forKey:@"area_code"];
    
    [login continuePost:para];
    
    return login;
    
}

+(instancetype)loginWithPhone:(NSString *)phone andCountryNo:(NSString*)countryNo andCode:(NSString *)code success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString *errorDesc))failure
{
    
    Login *login = [[Login alloc]init];
    
    login.callBackSuccess = success;
    
    login.callBackFailure = failure;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:phone forKey:@"phone"];
    
    [para setParameter:code forKey:@"code"];
    
    [para setParameter:countryNo forKey:@"area_code"];
    
    [login continuePost:para];
    
    return login;
    
}

-(void)continuePost:(Parameters*)para
{
    
    [MOAFHelp AFPostHost:ROOT bindPath:kPwdLogin postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (!responseDic[@"data"][@"coach"]) {
                
                self.callBackFailure(@"尚未注册");
                
                self.callBackSuccess = nil;
                
                self.callBackFailure = nil;
                
            }else if (![responseDic[@"data"][@"coach"][@"id"] integerValue]) {
                
                self.callBackFailure(@"尚未注册");
                
                self.callBackSuccess = nil;
                
                self.callBackFailure = nil;
                
            }else{
                
                [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"coach"][@"id"] integerValue] forKey:@"coachId"];
                
                [[NSUserDefaults standardUserDefaults]setValue:responseDic[@"data"][@"user"][@"username"] forKey:@"coachName"];
                
                if ([responseDic[@"data"][@"user"][@"avatar"] length]) {
                    
                    [[NSUserDefaults standardUserDefaults]setValue:responseDic[@"data"][@"user"][@"avatar"] forKey:@"coachIcon"];
                    
                }
                
                [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"user"][@"id"] integerValue] forKey:@"userId"];
                
                [[NSUserDefaults standardUserDefaults]setValue:para.data[@"phone"] forKey:@"phone"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                if ([responseDic[@"data"][@"session_id"] length]) {
                    
                    [[NSUserDefaults standardUserDefaults] setValue:responseDic[@"data"][@"session_id"] forKey:@"sessionId"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }
                
                [Login updatePush];
                
                self.callBackSuccess(responseDic);
                
                self.callBackSuccess = nil;
                
                self.callBackFailure = nil;
                
            }
            
        }else
        {
            
            self.callBackFailure(responseDic[@"msg"]);
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBackFailure(error);
        
        self.callBackFailure = nil;
        
        self.callBackSuccess = nil;
        
    }];
    
}

+(instancetype)updatePush
{
    
    Login *login = [[Login alloc]init];
    
    NSInteger coachId = CoachId;
    
    if (!coachId) {
        
        return login;
        
    }else
    {
        
        [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
            // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
            if (result) {
                [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                    if (result) {
                        
                        Parameters *para = [[Parameters alloc]init];
                        
                        [para setParameter:[BPush getChannelId] forKey:@"push_channel_id"];
                        
                        [para setParameter:[BPush getUserId] forKey:@"push_id"];
                        
                        [para setParameter:@"ios" forKey:@"device_type"];
                        
                        [para setParameter:PushDistribute forKey:@"distribute"];
                        
                        [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kPushApi,CoachId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                            
                            if ([responseDic[@"data"][@"successful"] boolValue]) {
                                
                                [[NSUserDefaults standardUserDefaults]setValue:VERSION forKey:@"pushVersion"];
                                
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                            }else{
                                
                                
                            }
                            
                        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
                            
                            
                        }];
                        
                    }
                }];
                
            }
            
        }];
        
        return login;
        
    }
    
}


@end
