//
//  AppDelegate.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "AppDelegate.h"

#import "LaunchController.h"

#import "RootController.h"

#import "BPush.h"

#import "UMMobClick/MobClick.h"

#import "EventManager.h"

#import "KeyboardManager.h"

#import "WXAPIManager.h"

#import "CheckUpdateInfo.h"

#import "DistrictInfo.h"

#import "WebViewController.h"

#import "QingChengHandler.h"

#import <AudioToolbox/AudioToolbox.h>

#import <AMapFoundationKit/AMapFoundationKit.h>

#import "SensorsAnalyticsSDK.h"

#import <TLSSDK/TLSHelper.h>

#import <QALSDK/QalSDKProxy.h>

#import <ImSDK/ImSDK.h>

#define SA_SERVER_URL @"http://qingchengfit.cloud.sensorsdata.cn:8006/sa?token=2f79f21494c6f970"

#define SA_CONFIGURE_URL @"http://qingchengfit.cloud.sensorsdata.cn:8006/config?project=default"

#if AppDebug
#define SA_DEBUG_MODE SensorsAnalyticsDebugOnly
#else
#define SA_DEBUG_MODE SensorsAnalyticsDebugOff
#endif

@interface AppDelegate ()

{
    
    BOOL _mustUpdate;
    
    NSURL *_updateURL;
        
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[TIMManager sharedInstance] disableCrashReport];
    
    [[TIMManager sharedInstance] initSdk:TencentIMID];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSData *guideData = [[NSUserDefaults standardUserDefaults]objectForKey:@"guide"];
    
    if (guideData) {
        
        self.guide = [NSKeyedUnarchiver unarchiveObjectWithData:guideData];
        
    }
    
    if (LocalServer) {
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"localServer"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }else{
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"localServer"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    [AMapServices sharedServices].apiKey = GDKEY;
    
    UMConfigInstance.appKey = UMKey;
    
    UMConfigInstance.channelId = PushDistribute;
    
    [MobClick setAppVersion:VERSION];
    
    [MobClick startWithConfigure:UMConfigInstance];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"收起";
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    
    [WXApi registerApp:WXKEY];
    
    [SensorsAnalyticsSDK sharedInstanceWithServerURL:SA_SERVER_URL
                                     andConfigureURL:SA_CONFIGURE_URL
                                        andDebugMode:SA_DEBUG_MODE];
    
    [[SensorsAnalyticsSDK sharedInstance] enableAutoTrack:SensorsAnalyticsEventTypeAppStart |
     SensorsAnalyticsEventTypeAppEnd |
     SensorsAnalyticsEventTypeAppViewScreen |
     SensorsAnalyticsEventTypeAppClick];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (UserId) {
        
        [dict setValue:[NSString stringWithFormat:@"%ld",UserId] forKey:@"qc_user_id"];
        
    }
    
    if (UserPhone) {
        
        [dict setValue:UserPhone forKey:@"qc_user_phone"];
        
    }
    
    [dict setValue:@"Trainer" forKey:@"qc_app_name"];
    
    [[SensorsAnalyticsSDK sharedInstance] registerSuperProperties:dict];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                                  if (granted) {
                                      [application registerForRemoteNotifications];
                                  }
                              }];
#endif
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }else {
        
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        
    }
    
#ifndef DEBUG
    [BPush registerChannel:launchOptions apiKey:BPUSHKEY pushMode:BPushModeProduction withFirstAction:nil withSecondAction:nil withCategory:nil useBehaviorTextInput:NO isDebug:AppDebug];
#else
    
    [BPush registerChannel:launchOptions apiKey:BPUSHKEY pushMode:BPushModeDevelopment withFirstAction:nil withSecondAction:nil withCategory:nil useBehaviorTextInput:NO isDebug:NO];
#endif
    
    [BPush disableLbs];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    LaunchController *launchVC = [[LaunchController alloc]init];
    
    self.window.rootViewController = launchVC;
    
    [self.window makeKeyAndVisible];
    
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo) {
        
        [BPush handleNotification:userInfo];
        
    }
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self checkUpdate];
    
    if (CoachId) {
        
        [self checkEvent];
        
        NSString *pushVerision = [[NSUserDefaults standardUserDefaults]valueForKey:@"pushVersion"];
        
        if (![pushVerision isEqualToString:VERSION]) {
            
            [Login updatePush];
            
        }
        
    }
    
    return YES;
    
}

-(void)checkEvent
{
    
    [[EventManager sharedManager]getEvent];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (_mustUpdate) {
        
        if (alertView.tag == 999) {
            
            [[UIApplication sharedApplication]openURL:_updateURL];
            
        }
        
    }else{
        
        if (alertView.tag == 999) {
            
            if (buttonIndex == 1) {
                
                [[UIApplication sharedApplication]openURL:_updateURL];
                
            }
            
        }
        
    }
    
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    [BPush registerDeviceToken:deviceToken];
    
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
            // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        if (result) {
            
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                        
                }
            }];
            
            NSString *pushVerision = [[NSUserDefaults standardUserDefaults]valueForKey:@"pushVersion"];
            
            if (![pushVerision isEqualToString:VERSION]) {
                
                [Login updatePush];
                
            }
            
        }
        
    }];
    
    [[NSUserDefaults standardUserDefaults]setValue:deviceToken forKey:@"deviceToken"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    [BPush handleNotification:userInfo];
    
    if (application.applicationState == UIApplicationStateInactive) {
        
        if ([[userInfo allKeys]containsObject:@"id"]) {
            
            [BPush handleNotification:userInfo];
            
            Message *message = [[Message alloc]init];
            
            message.url = [NSURL URLWithString:userInfo[@"url"]];
            
            message.place = userInfo[@"sender"];
            
            message.title = userInfo[@"title"];
            
            message.time = userInfo[@"create_at"];
            
            message.imgUrl = [NSURL URLWithString:userInfo[@"photo"]];
            
            message.msgId = [userInfo[@"id"]integerValue];
            
            message.content = userInfo[@"description"];
            
            self.message = message;
            
            [self dealMessage:message];
            
        }else{
            
            [[RootController sharedSliderController]setSelectIndex:3];
            
        }
        
    }else if (application.applicationState == UIApplicationStateActive){
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
    }
    
}

-(void)dealMessage:(Message*)msg
{
    
    if (CoachId <= 0)
    {
        return;
    }
    // app杀死状态，点击推送进来，等 RootController 加载完之后，自行处理
    if ([RootController sharedSliderController].viewControllers.count <= 0)
    {
        return;
    }
    
    if (msg.url.absoluteString.length){
        
        UIViewController *vc = [QingChengHandler handlerOpenURL:msg.url];
        
        if (vc) {
            
            if ([[self getCurrentVC] isKindOfClass:[UINavigationController class]]) {
                
                [((UINavigationController*)[self getCurrentVC]) pushViewController:vc animated:YES];
                
                AppMessage = nil;
                
            }
            
        }else{
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            svc.url = msg.url;
            
            if ([[self getCurrentVC] isKindOfClass:[UINavigationController class]]) {
                
                [((UINavigationController*)[self getCurrentVC]) pushViewController:svc animated:YES];
                
                AppMessage = nil;
                
            }
            
        }
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    
    if (application.applicationState == UIApplicationStateInactive) {
        
        if ([[userInfo allKeys]containsObject:@"id"]) {
            
            [BPush handleNotification:userInfo];
            
            Message *message = [[Message alloc]init];
            
            message.url = [NSURL URLWithString:userInfo[@"url"]];
            
            message.place = userInfo[@"sender"];
            
            message.title = userInfo[@"title"];
            
            message.time = userInfo[@"create_at"];
            
            message.imgUrl = [NSURL URLWithString:userInfo[@"photo"]];
            
            message.msgId = [userInfo[@"id"]integerValue];
            
            message.content = userInfo[@"description"];
            
            self.message = message;
            
            [self dealMessage:message];
            
        }else{
            
            [[RootController sharedSliderController]setSelectIndex:3];
            
        }
        
    }else if (application.applicationState == UIApplicationStateActive){
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
    }
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if (userInfo) {
        
        if ([[userInfo allKeys]containsObject:@"id"]) {
            
            [BPush handleNotification:userInfo];
            
            Message *message = [[Message alloc]init];
            
            message.url = [NSURL URLWithString:userInfo[@"url"]];
            
            message.place = userInfo[@"sender"];
            
            message.title = userInfo[@"title"];
            
            message.time = userInfo[@"create_at"];
            
            message.imgUrl = [NSURL URLWithString:userInfo[@"photo"]];
            
            message.msgId = [userInfo[@"id"]integerValue];
            
            message.content = userInfo[@"description"];
            
            self.message = message;
            
            [self dealMessage:message];
            
        }else{
            
            [[RootController sharedSliderController]selectTheIndex:3];
            
        }
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    
    
}

-(void)checkUpdate
{
    
    [CheckUpdateInfo checkUpdateResult:^(BOOL success, BOOL shouldUpdate,BOOL mustUpdate, NSURL *updateURL) {
        
        if (success && shouldUpdate) {
            
            _mustUpdate = mustUpdate;
            
            if (AppIsAppStore) {
                
                _updateURL = [NSURL URLWithString:@"itms-apps://itunes.apple.com/"];
                
                if (_mustUpdate) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"检测到新版本，需更新App才能使用" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"去AppStore下载",nil];
                    
                    alert.tag = 999;
                    
                    [alert show];
                    
                }else{
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"检测到新版本，需更新App才能使用" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去AppStore下载",nil];
                    
                    alert.tag = 999;
                    
                    [alert show];
                    
                }
                
            }else{
                
                if (AppDebug) {
                    
                    _updateURL = updateURL;
                    
                    if (mustUpdate) {
                        
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"新的测试版本" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"下载",nil];
                        
                        alert.tag = 999;
                        
                        [alert show];
                        
                    }else{
                        
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"新的测试版本" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"下载",nil];
                        
                        alert.tag = 999;
                        
                        [alert show];
                        
                    }
                    
                }else{
                    
                    _updateURL = updateURL;
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"新的测试版本" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"下载",nil];
                    
                    alert.tag = 999;
                    
                    [alert show];
                    
                }
                
            }
            
        }
        
    }];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    __block UIBackgroundTaskIdentifier bgTaskID;
    bgTaskID = [application beginBackgroundTaskWithExpirationHandler:^ {
        
        //不管有没有完成，结束background_task任务
        [application endBackgroundTask: bgTaskID];
        bgTaskID = UIBackgroundTaskInvalid;
    }];
    
    TIMBackgroundParam  *param = [[TIMBackgroundParam alloc] init];
    
    [[TIMManager sharedInstance] doBackground:param succ:^() {
        
    } fail:^(int code, NSString * err) {
        
    }];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [self checkUpdate];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    if (CoachId) {
        
        [self checkEvent];
        
    }
    
    [[RootController sharedSliderController]setHaveNew:YES atIndex:2];
    
    [[TIMManager sharedInstance] doForeground];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    [self saveGuide];
    
    [self saveContext];
    
}

-(void)saveGuide
{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.guide];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"guide"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "cn.qingchengfit.CoachHelp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoachHelp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoachHelp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    
    if ([url.scheme isEqualToString:@"qccoach"]) {
        
        MOViewController *vc = [QingChengHandler handlerOpenURL:url];
        
        if ([[self getCurrentVC] isKindOfClass:[UINavigationController class]] && vc) {
            
            if ([vc isKindOfClass:[WebViewController class]]) {
                
                ((WebViewController*)vc).url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[url.path substringFromIndex:1]]];
                
            }
            
            [((UINavigationController*)[self getCurrentVC]) pushViewController:vc animated:YES];
            
        }else{
            
            self.url = url;
            
        }
                
        return YES;
        
    }else if ([url.scheme isEqualToString:WXKEY]){
        
        return [WXApi handleOpenURL:url delegate:[WXAPIManager sharedManager]];
        
    }else{
        
        return YES;
        
    }
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    if ([url.scheme isEqualToString:@"qccoach"]) {
        
        MOViewController *vc = [QingChengHandler handlerOpenURL:url];
        
        if ([[self getCurrentVC] isKindOfClass:[UINavigationController class]] && vc) {
            
            if ([vc isKindOfClass:[WebViewController class]]) {
                
                ((WebViewController*)vc).url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[url.path substringFromIndex:1]]];
                
            }
            
            [((UINavigationController*)[self getCurrentVC]) pushViewController:vc animated:YES];
            
        }else{
            
            self.url = url;
            
        }
        
        return YES;
        
    }else if ([url.scheme isEqualToString:WXKEY]){
        
        return [WXApi handleOpenURL:url delegate:[WXAPIManager sharedManager]];
        
    }else{
        
        return YES;
        
    }
    
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        
        NSURL *url = userActivity.webpageURL;
        
        if ([[self getCurrentVC] isKindOfClass:[UINavigationController class]]) {
            
            MOViewController *vc = [QingChengHandler handlerOpenURL:url];
            
            if (vc) {
                
                [((UINavigationController*)[self getCurrentVC]) pushViewController:vc animated:YES];
                
            }else{
                
                if ([url.host isEqualToString:@"openurl"]) {
                    
                    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[url.path substringFromIndex:1]]];
                    
                }
                
                self.url = url;
                
            }
            
        }else{
            
            if ([url.host isEqualToString:@"openurl"]) {
                
                url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[url.path substringFromIndex:1]]];
                
            }
            
            self.url = url;
            
        }
        
    }
    
    return YES;
    
}

@end
