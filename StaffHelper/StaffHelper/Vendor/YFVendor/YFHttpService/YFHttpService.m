//
//  YFHttpService.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFHttpService.h"

#import "YFAppConfig.h"
#import "AFNetworking.h"
#import "UIView+YFLoadAniView.h"
#import "NSString+replaceUnicode.h"
#import "YFAppService.h"
#import "YFRespoStatusModel.h"
#import "YFRespoDataLoginModel.h"

#import "NSObject+HttpCancelHandleYF.h"


@interface YFHttpService()

@property(nonatomic,strong)AFURLSessionManager *urlSessionManager;
@property(nonatomic,strong)AFHTTPSessionManager *httpSessionManager;

@property(nonatomic,weak)NSURLSessionDataTask *task;

@property(nonatomic, copy)NSString *secretAgent;

@end

@implementation YFHttpService


+ (instancetype)sharedInstance {
    static YFHttpService *sharedInstance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        sharedInstance.urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        // 同时进行 两个 上传 任务
        sharedInstance.urlSessionManager.operationQueue.maxConcurrentOperationCount = 2;
        
        sharedInstance.httpSessionManager = [AFHTTPSessionManager manager];
        // 同时进行 3 个网络请求
        sharedInstance.httpSessionManager.operationQueue.maxConcurrentOperationCount = 2;
        
    });
    return sharedInstance;
}

+(instancetype)instance
{
    YFHttpService *service = [[self alloc] init];
    
    service.requestSerializerType =  0;
    service.responseSerializerType =  0;
    
    return service;
}

- (NSString *)secretAgent
{
    if (_secretAgent == nil)
    {
        UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        
        _secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    }
    return _secretAgent;
}


-(void)GETNoTocken:(NSString *)URLString parameters:(NSDictionary *)parameters serviceRelyModel:(NSObject *__weak)relyModel responceModelClass:(Class)responceModelClass responseData:(Class)responseDataClass modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable))success failure:(void (^)(NSError * _Nonnull))failure
{
    [relyModel yf_addHttpService:self];
    
    if (requestView) {
        [requestView showLoadingAniViewYF];
    }
    AFHTTPSessionManager *manager = [self managerFY];
    
    DebugLogYF(@"GET:%@ param:%@" ,URLString,[parameters.description replaceUnicode]);
    
    DebugLogYF(@"请求头数据----:%@" ,[manager.requestSerializer.HTTPRequestHeaders.description replaceUnicode]);
    
    self.task = [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //        DebugLogYF(@"进度----%lld",downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        //        DebugLogYF(@"进度%f",(double)downloadProgress.completedUnitCount /(double) downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG
        DebugLogYF(@"GET:%@ param:%@" ,URLString,[parameters.description replaceUnicode]);
        
        //        DebugLogYF(@"成功请求头数据----:%@,URLString: %@" ,[task.currentRequest.allHTTPHeaderFields.description replaceUnicode],URLString);
//        DebugLogYF(@"成功请求到数据 dic----:%@" ,dic.description);
        DebugLogYF(@"成功请求到数据 dic----:%@" ,[((NSDictionary *)responseObject).description replaceUnicode]);
//        DebugLogYF(@"成功请求到数据response----:%@" ,task.response );
        
#endif
        //            NSString *str = [[NSString alloc] initWithData:task.error.description encoding:NSUTF8StringEncoding];
        YFRespoStatusModel *responceModel = [[responceModelClass alloc] initWithDictionary:responseObject responseData:responseDataClass model:modelClass];
        
        success(responceModel);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        DebugLogYF(@"%@",error);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
            //            [GTFYAppservice showAlertMessage:[self errorStringFromError:error]];
        }
    }];
}

-(void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters serviceRelyModel:(NSObject *__weak)relyModel responceModelClass:(Class)responceModelClass responseData:(Class)responseDataClass modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable))success failure:(void (^)(NSError * _Nonnull))failure
{
    [relyModel yf_addHttpService:self];
    
    if (requestView) {
        [requestView showLoadingAniViewYF];
    }
    AFHTTPSessionManager *manager = [self managerFY];
    
    DebugLogParamYF(@"GET:%@ param:%@" ,URLString,[parameters.description replaceUnicode]);
    
    DebugLogParamYF(@"请求头数据----:%@" ,[manager.requestSerializer.HTTPRequestHeaders.description replaceUnicode]);
    
    self.task = [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //        DebugLogYF(@"进度----%lld",downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        //        DebugLogYF(@"进度%f",(double)downloadProgress.completedUnitCount /(double) downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG

//        DebugLogYF(@"GET:%@ param:%@" ,URLString,[parameters.description replaceUnicode]);
        
        //        DebugLogYF(@"成功请求头数据----:%@,URLString: %@" ,[task.currentRequest.allHTTPHeaderFields.description replaceUnicode],URLString);
        DebugLogYF(@"成功请求到数据 dic----:%@" ,((NSDictionary *)responseObject).description);
//        DebugLogYF(@"成功请求到数据 dic----:%@" ,[dic.description replaceUnicode]);
//        DebugLogYF(@"成功请求到数据response----:%@" ,task.response );
        
#endif
        //            NSString *str = [[NSString alloc] initWithData:task.error.description encoding:NSUTF8StringEncoding];
        YFRespoStatusModel *responceModel = [[responceModelClass alloc] initWithDictionary:responseObject responseData:responseDataClass model:modelClass];
        responceModel.httpService  = self;
        success(responceModel);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        DebugLogYF(@"%@",error);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
            //            [GTFYAppservice showAlertMessage:[self errorStringFromError:error]];
        }
    }];
}

-(void)POST:(NSString *)URLString parameters:(id)parameters serviceRelyModel:(NSObject *__weak)relyModel responceModelClass:(Class)responceModelClass responseData:(Class)responseDataClass modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable))success failure:(void (^)(NSError * _Nonnull))failure
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
     if (!token) {
         [[YFHttpService instance] GETNoTocken:[NSString stringWithFormat:@"%@%@",ROOT,@"/api/csrftoken/"] parameters:nil serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataLoginModel class] modelClass:nil showLoadingOnView:nil success:^(YFRespoStatusModel * _Nullable baseModel) {
             YFRespoStatusModel *statusModel = (YFRespoStatusModel *)baseModel;
             YFRespoDataLoginModel *loginModel = (YFRespoDataLoginModel *)statusModel.dataModel;
             DebugLogYF(@"tocken:%@",loginModel.token);
             if (loginModel.token)
             {
                 [[NSUserDefaults standardUserDefaults]setObject:loginModel.token forKey:@"token"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [self POST:URLString parameters:parameters serviceRelyModel:relyModel responceModelClass:responceModelClass responseData:responseDataClass modelClass:modelClass showLoadingOnView:requestView success:success failure:failure];
             }else
             {
                 NSError *err = [NSError errorWithDomain:@"TockenErrorYF"
                                                    code:-1999
                                                userInfo:@{@"message":@"Tocken 为空"}];
                 failure(err);
             }
            
             
         } failure:^(NSError * _Nonnull error) {
             failure(error);
         }];
     }
    
    
    [relyModel yf_addHttpService:self];

    DebugLogParamYF(@"POST:%@ param:%@" ,URLString,[((NSObject*)parameters).description replaceUnicode]);
    DebugLogParamYF(@"POST:%@ param:%@" ,URLString,((NSObject*)parameters).description);
    
    if (requestView) {
        [requestView showLoadingAniViewYF];
    }
    AFHTTPSessionManager *manager = [self managerFY];
    
    self.task = [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG
//        NSDictionary *dic = (NSDictionary *)responseObject;
        //
//        DebugLogYF(@"成功请求头数据----:%@,URLString: %@" ,[task.currentRequest.allHTTPHeaderFields.description replaceUnicode],URLString);
        DebugLogParamYF(@"成功请求到数据11111 dic----:%@" ,((NSDictionary *)responseObject).description);
#endif
        YFRespoStatusModel *responceModel = [[responceModelClass alloc] initWithDictionary:responseObject responseData:responseDataClass model:modelClass];
        success(responceModel);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        DebugLogParamYF(@"%@",error);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
            //            [GTFYAppservice showAlertMessage:[self errorStringFromError:error]];
            
        }
    }];
}

-(void)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters serviceRelyModel:(NSObject *__weak)relyModel responceModelClass:(Class)responceModelClass responseData:(Class)responseDataClass modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable))success failure:(void (^)(NSError * _Nonnull))failure
{
    
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    if (!token) {
        [[YFHttpService instance] GETNoTocken:[NSString stringWithFormat:@"%@%@",ROOT,@"/api/csrftoken/"] parameters:nil serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataLoginModel class] modelClass:nil showLoadingOnView:nil success:^(YFRespoStatusModel * _Nullable baseModel) {
            YFRespoStatusModel *statusModel = (YFRespoStatusModel *)baseModel;
            YFRespoDataLoginModel *loginModel = (YFRespoDataLoginModel *)statusModel.dataModel;
            DebugLogYF(@"tocken:%@",loginModel.token);
            if (loginModel.token)
            {
                [[NSUserDefaults standardUserDefaults]setObject:loginModel.token forKey:@"token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self PUT:URLString parameters:parameters serviceRelyModel:relyModel responceModelClass:responceModelClass responseData:responseDataClass modelClass:modelClass showLoadingOnView:requestView success:success failure:failure];
            }else
            {
                NSError *err = [NSError errorWithDomain:@"TockenErrorYF"
                                                   code:-1999
                                               userInfo:@{@"message":@"Tocken 为空"}];
                failure(err);
            }
            
            
        } failure:^(NSError * _Nonnull error) {
            failure(error);
        }];
    }

    
    [relyModel yf_addHttpService:self];

    DebugLogParamYF(@"PUT:%@ param:%@" ,URLString,[parameters.description replaceUnicode]);
    DebugLogParamYF(@"PUT:%@ param:%@" ,URLString,parameters);
    
    if (requestView) {
        [requestView showLoadingAniViewYF];
    }
    AFHTTPSessionManager *manager = [self managerFY];
    
    self.task = [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG
//        NSDictionary *dic = (NSDictionary *)responseObject;
        
//        DebugLogYF(@"成功请求头数据----:%@,URLString: %@" ,[task.currentRequest.allHTTPHeaderFields.description replaceUnicode],URLString);
        DebugLogParamYF(@"成功请求到数据----:%@" ,[((NSDictionary *)responseObject).description replaceUnicode]);
#endif
        
        YFRespoStatusModel *responceModel = [[responceModelClass alloc] initWithDictionary:responseObject responseData:responseDataClass model:modelClass];
        success(responceModel);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        DebugLogParamYF(@"error:%@",error);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
        }
    }];
    
}


-(void)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters serviceRelyModel:(NSObject *__weak)relyModel responceModelClass:(Class)responceModelClass responseData:(Class)responseDataClass modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable))success failure:(void (^)(NSError * _Nonnull))failure
{
    [relyModel yf_addHttpService:self];

    DebugLogParamYF(@"DELETE:%@ param:%@" ,URLString,[parameters.description replaceUnicode]);
    
    if (requestView) {
        [requestView showLoadingAniViewYF];
    }
    
    AFHTTPSessionManager *manager = [self managerFY];
    
    self.task = [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#if DEBUG
//    NSDictionary *dic = (NSDictionary *)responseObject;
        
//    DebugLogYF(@"成功请求头数据----:%@,URLString: %@" ,[task.currentRequest.allHTTPHeaderFields.description replaceUnicode],URLString);
    DebugLogParamYF(@"成功请求到数据----:%@" ,[((NSDictionary *)responseObject).description replaceUnicode]);
#endif
        YFRespoStatusModel *responceModel = [[responceModelClass alloc] initWithDictionary:responseObject responseData:responseDataClass model:modelClass];
        success(responceModel);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        DebugLogParamYF(@"%@",error);
        if (requestView) {
            [requestView stopLoadingAniViewYF];
            //            [GTFYAppservice showAlertMessage:[self errorStringFromError:error]];
        }
        
    }];
}



-(AFHTTPSessionManager *)managerFY
{
    AFHTTPSessionManager *manager = [[[self class] sharedInstance] httpSessionManager];
    
    if (self.requestSerializerType == 0)
    {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else if (self.requestSerializerType == 1)
    {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    if (self.responseSerializerType == 0)
    {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
    }else
    {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    
    NSString* secretAgent = [[[self class] sharedInstance] secretAgent];
    
    NSString *newUagent = @"";
    
    if ([secretAgent rangeOfString:@"FitnessTrainerAssistant"].length) {
        
        newUagent = secretAgent;
        
    }else
    {
        newUagent = [NSString stringWithFormat:@"%@ FitnessTrainerAssistant/%@ iOS OEM:%@ QingchengApp/%@",secretAgent,VERSION,PushDistribute,APPNAME];
    }

    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    
    NSString *cookies = [NSString stringWithFormat:@"csrftoken=%@",token];
    cookies = [NSString stringWithFormat:@"%@;sessionid=%@",cookies,sessionId];
    

    [manager.requestSerializer setValue:newUagent forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"X-CSRFToken"];
    [manager.requestSerializer setValue:cookies forHTTPHeaderField:@"Cookie"];

    
//    manager.session.configuration.HTTPAdditionalHeaders = @{@"User-Agent":newUagent,@"X-CSRFToken":token,@"Cookie":cookies};
//    DebugLogYF(@"head Param: %@",@(manager.session.configuration.HTTPAdditionalHeaders.count));
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //   manager = [AFHTTPSessionManager manager];
    
    //    manager.operationQueue.maxConcurrentOperationCount = 3;
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    
   
    return manager;
}



// 上传图片
-(void)sendImageAndVideosFY:(NSArray *)imageAndVideoArray completionBlock:(void (^)(BOOL))completionBlock
{
//    __block NSInteger count = 0;
//    for (int i = 0; i < imageAndVideoArray.count;i ++) {
//        GTFYUploadFileModel * fileModel = imageAndVideoArray[i];
//        [self uploadFileData:fileModel.fileData fileName:fileModel.fileName parameters:[fileModel parameters] URLString:[fileModel uploadUrlString] mimeType:fileModel.mimeType completionHandler:^(id responseObject, NSError *error) {
//            count ++;
//            if (!error) {
//                
//                fileModel.fileModel = [[GTFYFileModel alloc] initWithDictionary:responseObject];
//                if (fileModel.fileModel.filePath.length > 0)
//                {
//                    fileModel.fileStateType = GTFYFileStateTypeUpLoadSuccess;
//                }else
//                {
//                    fileModel.fileStateType = GTFYFileStateTypeUpLoadFailure;
//                }
//                DebugLogYF(@"YYYYYYYYYYYYYYYYY%@",responseObject);
//            }else{
//                fileModel.fileStateType = GTFYFileStateTypeUpLoadFailure;
//                DebugLogYF(@"NNNNNNNNNNNNNNNNNN%@",responseObject);
//            }
//            //                model.gtfile  =gtfile;
//            
//            if (imageAndVideoArray.count == count)
//            {
//                DLog(@"sendImageAndVideos");
//                completionBlock(imageAndVideoArray.count == count);
//            }
//            else
//            {
//                completionBlock(imageAndVideoArray.count == count);
//            }
//        }];
//    }
}
-(void)uploadFileData:(NSData *)fileData fileName:(NSString *)fileName parameters:(id)parameters URLString:(NSString *)URLString mimeType:(NSString *)mimeType completionHandler:(void (^)(id responseObject, NSError *error))completionHandler
{
    
    DebugLogYF(@"URLString:%@,parameters:%@",URLString,parameters);
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:mimeType];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[[self class] sharedInstance] urlSessionManager];
    
    //    manager.responseSerializer.acceptableContentTypes = nil;
    
    //    AFURLResponseSerialization.h 这个类里添加 @"text/html"
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    
    NSURLSessionUploadTask *uploadTask;
    
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                      if (completionHandler)
                      {
                          completionHandler(responseObject,error);
                      }
                  }];
    
    [uploadTask resume];
}

-(void)yf_cancel
{
    DebugLogYF(@"取消请求");
    [self.task cancel];
}


+(void)getUseNameComplete:(void (^)())complete
{
    if ([YFHttpService sharedInstance].info.staff.name.length)
    {
        if (complete) {
            complete();
        }
    }
    StaffUserInfo *info = [[StaffUserInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        if (success) {
            
            [YFHttpService sharedInstance].info = info;
            if (complete) {
                complete();
            }
        }else
        {
//            [YFAppService showAlertMessage:error];
        }
    }];
}

@end
