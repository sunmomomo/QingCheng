//
//  YFRespoStatusModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFRespoStatusModel.h"
#import "YFAppConfig.h"
#import "YFAppService.h"
#import "LoginController.h"
@implementation YFRespoStatusModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic responseData:(Class)responseDataClass model:(Class)modelClass
{
    self = [super initWithDictionary:jsonDic responseData:responseDataClass model:modelClass];
    
    if (self) {
        self.error_code = [self.error_code guardStringYF];
        self.allDataDic = jsonDic;
        [self showErrorAlertView];
    }
    return self;
}

- (void)showErrorAlertView
{
    if (self.isSuccess == NO)
    {
        DebugLogParamYF(@"--******---%@",self.allDataDic);
        // session失效，重新登录
//        if (self.error_code.integerValue == SESSIONERROR)
//        {
//            [YFAppService showAlertMessage:@"登录失效，请重新登录" onlySureBlock:^{
//                
//                [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"staffId"];
//                
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                
//                AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//                
//                appDelegate.window.rootViewController = [[LoginController alloc]init];
//
//                
//            }];
//        }else
        if (self.msg.length)
        {
            if (self.msg.length < 500)
            {
            [YFAppService showAlertMessage:self.msg];
            }
            
        }
    }
}


- (BOOL)isSuccess
{
    if ([_status integerValueYF] == 200)
    {
        return YES;
    }
    return NO;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"data"])
    {
        self.dataModel = [[self.responseDataClass alloc] initWithDictionary:value modelClass:self.modelClass];;
    }else
    {
        [super setValue:value forKey:key];
    }
}


@end
