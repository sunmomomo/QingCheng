//
//  AppDelegate.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Guide.h"

#import "Message.h"

#define MOAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define AppGym ((AppDelegate*)[UIApplication sharedApplication].delegate).gym

#define AppMessage ((AppDelegate*)[UIApplication sharedApplication].delegate).message

#define LaunchURL ((AppDelegate*)[UIApplication sharedApplication].delegate).url

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)Guide *guide;

@property(nonatomic,strong)Gym *gym;

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)Message *message;

@property(nonatomic,strong)NSURL *url;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(UIViewController *)getCurrentVC;

-(void)saveGuide;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

