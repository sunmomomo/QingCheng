//
//  AppDelegate.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Course.h"

#import "Brand.h"

#import "Student.h"

#import "Message.h"

#define MOAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define BRANDID [NSNumber numberWithInteger:((AppDelegate*)[UIApplication sharedApplication].delegate).brand.brandId]

#define AppGym ((AppDelegate*)[UIApplication sharedApplication].delegate).gym

#define AppOneGym ((AppDelegate*)[UIApplication sharedApplication].delegate).oneGym

#define AppMessage ((AppDelegate*)[UIApplication sharedApplication].delegate).message

#define LaunchURL ((AppDelegate*)[UIApplication sharedApplication].delegate).url

#define AppBrand ((AppDelegate*)[UIApplication sharedApplication].delegate).brand

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)Brand *brand;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)Message *message;

@property(nonatomic,strong)NSURL *url;

@property(nonatomic,assign)BOOL oneGym;

@property(nonatomic,assign)BOOL gymBlock;

@property(nonatomic,copy)void(^pay)(BOOL success);

-(UIViewController *)getCurrentVC;

- (void)saveContext;
-(void)saveCourse;
- (NSURL *)applicationDocumentsDirectory;


@end

