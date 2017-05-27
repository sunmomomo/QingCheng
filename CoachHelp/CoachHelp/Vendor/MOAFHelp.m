//
//  MOAFHelp.m
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/5/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#define NetTimeOutInterval 20.0f

#define GETTOKEN @"/api/csrftoken/"

#import "MOAFHelp.h"

@implementation MOAFHelp

+(MOAFHelp *)AFGetNoTokenHost:(NSString *)hostString bindPath:(NSString *)bindPath param:(NSDictionary *)dic success:(void (^)(AFHTTPSessionManager *, NSDictionary *))success failure:(void (^)(AFHTTPSessionManager *, NSString *))failure
{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = @"";
    
    if ([secretAgent rangeOfString:@"FitnessTrainerAssistant"].length) {
        
        newUagent = secretAgent;
        
    }else
    {
        
        newUagent = [NSString stringWithFormat:@"%@ FitnessTrainerAssistant/%@ iOS OEM:%@ QingchengApp/%@",secretAgent,VERSION,PushDistribute,APPNAME];
        
    }
    
    NSString* url = [NSString stringWithFormat:@"%@%@",hostString,bindPath.length?bindPath:@""];
    
    MOAFHelp *AFH = [[MOAFHelp alloc] init];
    AFH.callBackSuccess = success;
    AFH.callBackFailure = failure;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.HTTPAdditionalHeaders = @{@"User-Agent":newUagent};
    
    AFHTTPSessionManager *operation = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    if (([[dic allKeys]containsObject:@"brand_id"] && [dic[@"brand_id"]integerValue]==0)||([[dic allKeys]containsObject:@"shop_id"] && [dic[@"shop_id"]integerValue]==0)||([[dic allKeys]containsObject:@"id"] && [dic[@"id"]integerValue]==0)||([[dic allKeys]containsObject:@"model"] && [dic[@"model"]length]==0)) {
        
        AFH.callBackFailure(operation,@"场馆信息获取失败");
        
        AFH.callBackSuccess = nil;
        
        AFH.callBackFailure = nil;
        
        return AFH;
        
    }
    
    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    operation.requestSerializer.timeoutInterval = NetTimeOutInterval;
    [operation.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [operation.requestSerializer setValue:newUagent forHTTPHeaderField:@"User-Agent"];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [operation GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (!responseObject) {
            
            AFH.callBackFailure(operation,@"服务器连接失败");
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
        }else{
            
            AFH.callBackSuccess(operation,responseObject);
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        AFH.callBackFailure(operation,@"服务器连接失败");
        
        AFH.callBackSuccess = nil;
        AFH.callBackFailure = nil;
        
        
    }];
    
    return AFH;
}

+(MOAFHelp *)AFGetHost:(NSString *)hostString bindPath:(NSString *)bindPath param:(NSDictionary *)dic success:(void (^)(AFHTTPSessionManager *, NSDictionary *))success failure:(void (^)(AFHTTPSessionManager *, NSString *))failure
{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = @"";
    
    if ([secretAgent rangeOfString:@"FitnessTrainerAssistant"].length) {
        
        newUagent = secretAgent;
        
    }else
    {
        
        newUagent = [NSString stringWithFormat:@"%@ FitnessTrainerAssistant/%@ iOS OEM:%@ QingchengApp/%@",secretAgent,VERSION,PushDistribute,APPNAME];
        
    }
    
    NSString* url = [NSString stringWithFormat:@"%@%@",hostString,bindPath.length?bindPath:@""];
    
    MOAFHelp *AFH = [[MOAFHelp alloc] init];
    AFH.callBackSuccess = success;
    AFH.callBackFailure = failure;
    
    NSError *error = nil;
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    if (!token || !sessionId) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",ROOT,GETTOKEN];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] returningResponse:nil error:&error];
        
        if (!data) {
            
            AFH.callBackFailure(nil,@"服务器连接失败");
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
            return AFH;
        }else
        {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (!dict) {
                
                AFH.callBackFailure(nil,@"服务器连接失败");
                AFH.callBackSuccess = nil;
                AFH.callBackFailure = nil;
                
                return AFH;
            }else
            {
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"data"]valueForKey:@"token"] forKey:@"token"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
        }
        
    }
    
    token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *cookies = [NSString stringWithFormat:@"csrftoken=%@",token];
    
    sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    cookies = [NSString stringWithFormat:@"%@;sessionid=%@",cookies,sessionId];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.HTTPAdditionalHeaders = @{@"User-Agent":newUagent,@"X-CSRFToken":token,@"Cookie":cookies};
    
    AFHTTPSessionManager *operation = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    if (([[dic allKeys]containsObject:@"brand_id"] && [dic[@"brand_id"]integerValue]==0)||([[dic allKeys]containsObject:@"shop_id"] && [dic[@"shop_id"]integerValue]==0)||([[dic allKeys]containsObject:@"id"] && [dic[@"id"]integerValue]==0)||([[dic allKeys]containsObject:@"model"] && [dic[@"model"]length]==0)) {
        
        AFH.callBackFailure(operation,@"场馆信息获取失败");
        
        AFH.callBackSuccess = nil;
        
        AFH.callBackFailure = nil;
        
        return AFH;
        
    }
    
    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    operation.requestSerializer.timeoutInterval = NetTimeOutInterval;
    [operation.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [operation.requestSerializer setValue:newUagent forHTTPHeaderField:@"User-Agent"];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [operation GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (!responseObject) {
            
            AFH.callBackFailure(operation,@"服务器连接失败");
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
        }else{
            
            AFH.callBackSuccess(operation,responseObject);
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        AFH.callBackFailure(operation,@"服务器连接失败");
        
        AFH.callBackSuccess = nil;
        AFH.callBackFailure = nil;
        
    }];
    
    return AFH;
}


+(MOAFHelp *)AFPostHost:(NSString *)hostString bindPath:(NSString *)bindPath postParam:(NSDictionary *)dic success:(void (^)(AFHTTPSessionManager *, NSDictionary *))success failure:(void (^)(AFHTTPSessionManager *, NSString *))failure
{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = @"";
    
    if ([secretAgent rangeOfString:@"FitnessTrainerAssistant"].length) {
        
        newUagent = secretAgent;
        
    }else
    {
        
        newUagent = [NSString stringWithFormat:@"%@ FitnessTrainerAssistant/%@ iOS OEM:%@ QingchengApp/%@",secretAgent,VERSION,PushDistribute,APPNAME];
        
    }
    
    NSString* url = [NSString stringWithFormat:@"%@%@",hostString,bindPath.length?bindPath:@""];
    
    MOAFHelp *AFH = [[MOAFHelp alloc] init];
    
    AFH.callBackSuccess = success;
    AFH.callBackFailure = failure;
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    NSError *error = nil;
    
    if (!token || !sessionId) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",ROOT,GETTOKEN];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] returningResponse:nil error:&error];
        
        if (!data) {
            
            AFH.callBackFailure(nil,@"服务器连接失败");
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
            return AFH;
        }else
        {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (!dict) {
                
                AFH.callBackFailure(nil,@"服务器连接失败");
                
                AFH.callBackSuccess = nil;
                AFH.callBackFailure = nil;
                
                return AFH;
            }else
            {
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"data"]valueForKey:@"token"] forKey:@"token"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
        }
        
    }
    
    token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *cookies = [NSString stringWithFormat:@"csrftoken=%@",token];
    
    sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    cookies = [NSString stringWithFormat:@"%@;sessionid=%@",cookies,sessionId];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.HTTPAdditionalHeaders = @{@"User-Agent":newUagent,@"X-CSRFToken":token,@"Cookie":cookies};
    
    AFHTTPSessionManager *operation = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    if (([[dic allKeys]containsObject:@"brand_id"] && [dic[@"brand_id"]integerValue]==0)||([[dic allKeys]containsObject:@"shop_id"] && [dic[@"shop_id"]integerValue]==0)||([[dic allKeys]containsObject:@"id"] && [dic[@"id"]integerValue]==0)||([[dic allKeys]containsObject:@"model"] && [dic[@"model"]length]==0)) {
        
        AFH.callBackFailure(operation,@"场馆信息获取失败");
        
        AFH.callBackSuccess = nil;
        
        AFH.callBackFailure = nil;
        
        return AFH;
        
    }
    
    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    operation.requestSerializer.timeoutInterval = NetTimeOutInterval;
    [operation.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [operation.requestSerializer setValue:newUagent forHTTPHeaderField:@"User-Agent"];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [operation POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (!responseObject) {
            
            AFH.callBackFailure(operation,@"服务器连接失败");
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
        }else{
            
            AFH.callBackSuccess(operation,responseObject);
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        AFH.callBackFailure(operation,@"服务器连接失败");
        
        AFH.callBackSuccess = nil;
        AFH.callBackFailure = nil;
        
    }];
    
    return AFH;
    
}

+(MOAFHelp *)AFPutHost:(NSString *)hostString bindPath:(NSString *)bindPath putParam:(NSDictionary *)dic  success:(void (^)(AFHTTPSessionManager *, NSDictionary *))success failure:(void (^)(AFHTTPSessionManager *, NSString *))failure
{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = @"";
    
    if ([secretAgent rangeOfString:@"FitnessTrainerAssistant"].length) {
        
        newUagent = secretAgent;
        
    }else
    {
        
        newUagent = [NSString stringWithFormat:@"%@ FitnessTrainerAssistant/%@ iOS OEM:%@ QingchengApp/%@",secretAgent,VERSION,PushDistribute,APPNAME];
        
    }
    
    NSString* url = [NSString stringWithFormat:@"%@%@",hostString,bindPath.length?bindPath:@""];
    
    MOAFHelp *AFH = [[MOAFHelp alloc] init];
    
    AFH.callBackSuccess = success;
    AFH.callBackFailure = failure;
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    NSError *error = nil;
    
    if (!token || !sessionId) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",ROOT,GETTOKEN];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] returningResponse:nil error:&error];
        
        if (!data) {
            
            AFH.callBackFailure(nil,@"服务器连接失败");
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
            return AFH;
        }else
        {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (!dict) {
                
                AFH.callBackFailure(nil,@"服务器连接失败");
                AFH.callBackSuccess = nil;
                AFH.callBackFailure = nil;
                
                return AFH;
            }else
            {
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"data"]valueForKey:@"token"] forKey:@"token"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
        }
        
    }
    
    token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *cookies = [NSString stringWithFormat:@"csrftoken=%@",token];
    
    sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    cookies = [NSString stringWithFormat:@"%@;sessionid=%@",cookies,sessionId];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.HTTPAdditionalHeaders = @{@"User-Agent":newUagent,@"X-CSRFToken":token,@"Cookie":cookies};
    
    AFHTTPSessionManager *operation = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    if (([[dic allKeys]containsObject:@"brand_id"] && [dic[@"brand_id"]integerValue]==0)||([[dic allKeys]containsObject:@"shop_id"] && [dic[@"shop_id"]integerValue]==0)||([[dic allKeys]containsObject:@"id"] && [dic[@"id"]integerValue]==0)||([[dic allKeys]containsObject:@"model"] && [dic[@"model"]length]==0)) {
        
        AFH.callBackFailure(operation,@"场馆信息获取失败");
        
        AFH.callBackSuccess = nil;
        
        AFH.callBackFailure = nil;
        
        return AFH;
        
    }
    
    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    operation.requestSerializer.timeoutInterval = NetTimeOutInterval;
    [operation.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [operation.requestSerializer setValue:newUagent forHTTPHeaderField:@"User-Agent"];
    
    [operation PUT:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (!responseObject) {
            
            AFH.callBackFailure(operation,@"服务器连接失败");
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
        }else{
            
            AFH.callBackSuccess(operation,responseObject);
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        
        AFH.callBackFailure(operation,@"服务器连接失败");
        
        AFH.callBackSuccess = nil;
        AFH.callBackFailure = nil;
        
    }];
    
    return AFH;
    
}

+(MOAFHelp *)AFDeleteHost:(NSString *)hostString bindPath:(NSString *)bindPath deleteParam:(NSDictionary *)dic  success:(void (^)(AFHTTPSessionManager *, NSDictionary *))success failure:(void (^)(AFHTTPSessionManager *, NSString *))failure
{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = @"";
    
    if ([secretAgent rangeOfString:@"FitnessTrainerAssistant"].length) {
        
        newUagent = secretAgent;
        
    }else
    {
        
        newUagent = [NSString stringWithFormat:@"%@ FitnessTrainerAssistant/%@ iOS OEM:%@ QingchengApp/%@",secretAgent,VERSION,PushDistribute,APPNAME];
        
    }
    NSString* url = [NSString stringWithFormat:@"%@%@",hostString,bindPath.length?bindPath:@""];
    
    MOAFHelp *AFH = [[MOAFHelp alloc] init];
    
    AFH.callBackSuccess = success;
    AFH.callBackFailure = failure;
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    NSError *error = nil;
    
    if (!token || !sessionId) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",ROOT,GETTOKEN];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] returningResponse:nil error:&error];
        
        if (!data) {
            
            AFH.callBackFailure(nil,@"服务器连接失败");
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
            return AFH;
        }else
        {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (!dict) {
                
                AFH.callBackFailure(nil,@"服务器连接失败");
                AFH.callBackSuccess = nil;
                AFH.callBackFailure = nil;
                
                return AFH;
            }else
            {
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"data"]valueForKey:@"token"] forKey:@"token"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
        }
        
    }
    
    token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *cookies = [NSString stringWithFormat:@"csrftoken=%@",token];
    
    sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    cookies = [NSString stringWithFormat:@"%@;sessionid=%@",cookies,sessionId];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.HTTPAdditionalHeaders = @{@"User-Agent":newUagent,@"X-CSRFToken":token,@"Cookie":cookies};
    
    AFHTTPSessionManager *operation = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    if (([[dic allKeys]containsObject:@"brand_id"] && [dic[@"brand_id"]integerValue]==0)||([[dic allKeys]containsObject:@"shop_id"] && [dic[@"shop_id"]integerValue]==0)||([[dic allKeys]containsObject:@"id"] && [dic[@"id"]integerValue]==0)||([[dic allKeys]containsObject:@"model"] && [dic[@"model"]length]==0)) {
        
        AFH.callBackFailure(operation,@"场馆信息获取失败");
        
        AFH.callBackSuccess = nil;
        AFH.callBackFailure = nil;
        
        return AFH;
        
    }
    
    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    operation.requestSerializer.timeoutInterval = NetTimeOutInterval;
    [operation.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [operation.requestSerializer setValue:newUagent forHTTPHeaderField:@"User-Agent"];
    
    [operation DELETE:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (!responseObject) {
            
            AFH.callBackFailure(operation,@"服务器连接失败");
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
            
        }else{
            
            AFH.callBackSuccess(operation,responseObject);
            
            AFH.callBackSuccess = nil;
            AFH.callBackFailure = nil;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        AFH.callBackFailure(operation,@"服务器连接失败");
        
        AFH.callBackSuccess = nil;
        AFH.callBackFailure = nil;
        
    }];
    
    return AFH;
    
}


@end
