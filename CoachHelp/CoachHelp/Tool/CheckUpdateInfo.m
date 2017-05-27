//
//  CheckUpdateInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckUpdateInfo.h"

#define AppId @"1053738509"

#if  AppDebug
#define FirAppId @"5823f66e959d691d33002db6"
#else
#define FirAppId @"566e5ffbe75e2d2b2f000009"
#endif

#if AppDebug
#define FirApitoken @"194a7a7976904a110a45f5a34a614323"
#else
#define FirApitoken @"c610b1449bfb226772e9615c607245f8"
#endif

@implementation CheckUpdateInfo

+(void)checkUpdateResult:(void (^)(BOOL, BOOL,BOOL, NSURL *))result
{
    
    CheckUpdateInfo *info = [[CheckUpdateInfo alloc]init];
    
    info.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (!AppDebug) {
        
        [para setParameter:AppId forKey:@ "id"];
        
        [MOAFHelp AFGetHost:@"http://itunes.apple.com/lookup" bindPath:nil param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            NSArray *olVersionArray = [[responseDic[@"results"]firstObject][@"version"] componentsSeparatedByString:@"."];
            
            NSArray *naVersionArray = [VERSION componentsSeparatedByString:@"."];
            
            BOOL shouldUpdate = NO;
            
            BOOL mustUpdate = NO;
            
            if ([[olVersionArray firstObject]integerValue]>[[naVersionArray firstObject]integerValue]) {
                
                shouldUpdate = YES;
                
                mustUpdate = YES;
                
            }else if([[olVersionArray firstObject]integerValue]==[[naVersionArray firstObject]integerValue] && [olVersionArray[1]integerValue]>[naVersionArray[1]integerValue])
            {
                
                shouldUpdate = YES;
                
                mustUpdate = YES;
                
            }else if([[olVersionArray firstObject]integerValue]==[[naVersionArray firstObject]integerValue] && [olVersionArray[1]integerValue]==[naVersionArray[1]integerValue] && [[olVersionArray lastObject]integerValue]>[[naVersionArray lastObject]integerValue])
            {
                
                shouldUpdate = YES;
                
            }else
            {
                
                if (!AppIsAppStore) {
                    
                    if([[olVersionArray firstObject]integerValue]==[[naVersionArray firstObject]integerValue] && [olVersionArray[1]integerValue]==[naVersionArray[1]integerValue] && [[olVersionArray lastObject]integerValue]==[[naVersionArray lastObject]integerValue]){
                        
                        shouldUpdate = YES;
                        
                    }else{
                        
                        shouldUpdate = NO;
                        
                    }
                    
                }else{
                    
                    shouldUpdate = NO;
                    
                }
                
            }
            
            NSURL *url;
            
            if ([responseDic[@"results"]firstObject][@"trackViewUrl"]) {
                
                url = [NSURL URLWithString:[responseDic[@"results"]firstObject][@"trackViewUrl"]];
                
            }
            
            info.callBack(YES,shouldUpdate,mustUpdate,url);
            
            info.callBack = nil;
            
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            info.callBack(NO,NO,NO,nil);
            
            info.callBack = nil;
            
        }];
        
    }else{
        
        [para setParameter:FirApitoken forKey:@"api_token"];
        
        [MOAFHelp AFGetHost:@"http://api.fir.im/apps/latest/" bindPath:FirAppId param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            NSArray *olVersionArray = [responseDic[@"versionShort"] componentsSeparatedByString:@"."];
            
            NSArray *naVersionArray = [VERSION componentsSeparatedByString:@"."];
            
            NSInteger build = [responseDic[@"build"] integerValue];
            
            NSInteger localBuild = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] integerValue];
            
            BOOL shouldUpdate = NO;
            
            if ([[olVersionArray firstObject]integerValue]>[[naVersionArray firstObject]integerValue]) {
                
                shouldUpdate = YES;
                
            }else if([[olVersionArray firstObject]integerValue]==[[naVersionArray firstObject]integerValue] && [olVersionArray[1]integerValue]>[naVersionArray[1]integerValue])
            {
                
                shouldUpdate = YES;
                
            }else if([[olVersionArray firstObject]integerValue]==[[naVersionArray firstObject]integerValue] && [olVersionArray[1]integerValue]==[naVersionArray[1]integerValue] && [[olVersionArray lastObject]integerValue]>[[naVersionArray lastObject]integerValue])
            {
                
                shouldUpdate = YES;
                
            }else
            {
                
                if([[olVersionArray firstObject]integerValue]==[[naVersionArray firstObject]integerValue] && [olVersionArray[1]integerValue]==[naVersionArray[1]integerValue] && [[olVersionArray lastObject]integerValue]==[[naVersionArray lastObject]integerValue]){
                    
                    shouldUpdate = build>localBuild;
                    
                }else{
                    
                    shouldUpdate = NO;
                    
                }
                
            }
            
            info.callBack(YES,shouldUpdate,NO,[NSURL URLWithString:responseDic[@"update_url"]]);
            
            info.callBack = nil;
            
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            info.callBack(NO,NO,NO,nil);
            
            info.callBack = nil;
            
        }];
        
    }
    
}

@end
