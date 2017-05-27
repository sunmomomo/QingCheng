//
//  MOGotoAppStore.m
//  MOApp
//
//  Created by 馍馍帝👿 on 15/4/2.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//


#import "MOGotoAppStore.h"
#import <StoreKit/StoreKit.h>

@interface MOGotoAppStore()<SKStoreProductViewControllerDelegate>

@end

@implementation MOGotoAppStore
+ (MOGotoAppStore *)initObject {
    static MOGotoAppStore *appRater = nil;
    
    if (appRater == nil)
        appRater = [[MOGotoAppStore alloc] init];
    
    return appRater;
}

+(void)openAppStore:(NSString *)AppId
{
    if (NSStringFromClass([SKStoreProductViewController class]) != nil) {
        SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc]init];
        storeProductVC.delegate = self.initObject ;
        NSDictionary *dict = [NSDictionary dictionaryWithObject:AppId forKey:SKStoreProductParameterITunesItemIdentifier];
        [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        }];
        [[self getRootViewController] presentViewController:storeProductVC animated:YES completion:nil];
    }
}

+(id)getRootViewController
{
    return [[[UIApplication sharedApplication] delegate] window].rootViewController;
}

-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [[[self class]getRootViewController]dismissViewControllerAnimated:YES completion:nil];
}

@end
