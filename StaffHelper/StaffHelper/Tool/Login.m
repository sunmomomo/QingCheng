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
#define kPwdLogin @"/api/staffs/login/"

#define kPushApi @"/api/staffs/%ld/push/update/"

#define kRegister @"/api/staffs/register/"

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
            
            if (!responseDic[@"data"][@"staff"]) {
                
                if (self.callBackFailure) {
                    
                    self.callBackFailure(@"尚未注册");
                    
                    self.callBackSuccess = nil;
                    
                    self.callBackFailure = nil;
                    
                }
                
            }else{
                
                if (![responseDic[@"data"][@"staff"][@"id"] integerValue]) {
                    
                    if (self.callBackFailure) {
                        
                        self.callBackFailure(@"尚未注册");
                        
                        self.callBackSuccess = nil;
                        
                        self.callBackFailure = nil;
                        
                    }
                    
                }else{
                    
                    [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"staff"][@"id"] integerValue] forKey:@"staffId"];
                    
                    [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"user"][@"id"] integerValue] forKey:@"userId"];
                    
                    [[NSUserDefaults standardUserDefaults]setValue:para.data[@"phone"] forKey:@"userPhone"];
                    
                    [[NSUserDefaults standardUserDefaults]setValue:para.data[@"phone"] forKey:@"phone"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    if ([responseDic[@"data"][@"session_id"] length]) {
                        
                        [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"staff"][@"id"] integerValue] forKey:@"staffId"];
                        
                        [[NSUserDefaults standardUserDefaults] setValue:responseDic[@"data"][@"session_id"] forKey:@"sessionId"];
                        
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        if (para.data[@"phone"]) {
                            
                            [NBSAppAgent setCustomerData:para.data[@"phone"] forKey:@"phone"];
                            
                        }
                        
                        [NBSAppAgent setCustomerData:[NSString stringWithFormat:@"%ld",StaffId] forKey:@"staff_id"];
                        
                        [Login updatePush];
                        
                    }
                    
                    if (self.callBackSuccess) {
                        
                        self.callBackSuccess(responseDic);
                        
                        self.callBackSuccess = nil;
                        
                        self.callBackFailure = nil;
                        
                    }
                    
                }
                
            }
            
        }else
        {
            
            if (self.callBackFailure) {
                
                self.callBackFailure(responseDic[@"msg"]);
                
                self.callBackFailure = nil;
                
                self.callBackSuccess = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBackFailure) {
            
            self.callBackFailure(error);
            
            self.callBackFailure = nil;
            
            self.callBackSuccess = nil;
            
        }
        
    }];
    
}

+(instancetype)updatePush
{
    
    Login *login = [[Login alloc]init];
    
    if (!StaffId) {
        
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
                        
                        [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kPushApi,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                            
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

+(instancetype)registerWithPara:(NSDictionary *)para success:(void (^)(NSDictionary *))success faliure:(void (^)(NSString *))failure
{
    
    Login *login = [[Login alloc]init];
    
    login.callBackSuccess = success;
    
    login.callBackFailure = failure;
    
    [MOAFHelp AFPostHost:ROOT bindPath:kRegister postParam:para success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"staff"][@"id"]integerValue] forKey:@"staffId"];
            
            [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"user"][@"id"] integerValue] forKey:@"userId"];
            
            [[NSUserDefaults standardUserDefaults]setValue:para[@"phone"] forKey:@"phone"];
            
            [[NSUserDefaults standardUserDefaults]setValue:para[@"phone"] forKey:@"userPhone"];
            
            [[NSUserDefaults standardUserDefaults] setValue:responseDic[@"data"][@"session_id"] forKey:@"sessionId"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if (para[@"phone"]) {
                
                [NBSAppAgent setCustomerData:para[@"phone"] forKey:@"phone"];
                
            }
            
            [NBSAppAgent setCustomerData:[NSString stringWithFormat:@"%ld",StaffId] forKey:@"staff_id"];
            
            login.callBackSuccess(responseDic);
            
            login.callBackSuccess = nil;
            
            login.callBackFailure = nil;
            
        }else
        {
            
            login.callBackFailure(responseDic[@"msg"]);
            
            login.callBackFailure = nil;
            
            login.callBackSuccess = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        login.callBackFailure(error);
        
        login.callBackFailure = nil;
        
        login.callBackSuccess = nil;
        
    }];
    
    return login;
    
}

@end
