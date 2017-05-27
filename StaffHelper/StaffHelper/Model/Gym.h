//
//  Gym.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Brand.h"

#import "CourseRate.h"

#import "Permissions.h"

#import "YFDistrictModel.h"

@interface Gym : NSObject<NSCoding>

@property(nonatomic,strong)Brand *brand;

@property(nonatomic,copy)NSString *name;

/**
 * id
 */
@property(nonatomic,assign)NSInteger gymId;
/**
 * gym_Id for 赛事
 */
@property(nonatomic,assign)NSInteger gym_IdForCompet;

@property(nonatomic,assign)NSInteger shopId;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,strong)UIColor *color;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *contact;

@property(nonatomic,assign)BOOL ishot;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSString *systemEnd;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,copy)NSURL *privateUrl;

@property(nonatomic,copy)NSURL *groupUrl;

@property(nonatomic,assign)BOOL isCertificate;

@property(nonatomic,assign)NSInteger courseCount;

@property(nonatomic,assign)NSInteger userCount;

@property(nonatomic,assign)NSInteger remainDays;

@property(nonatomic,copy)NSURL *previewURL;

@property(nonatomic,copy)NSURL *hintURL;

@property(nonatomic,assign)NSInteger renewPrice;

@property(nonatomic,assign)BOOL isRecharged;

@property(nonatomic,assign)BOOL isFirstShop;

@property(nonatomic,assign)BOOL havePower;

@property(nonatomic,strong)Staff *superuser;

@property(nonatomic,assign)BOOL receiveNotification;

@property(nonatomic,assign)NSInteger notificationConfigId;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,strong)CourseRate *rate;

@property(nonatomic,strong)Permissions *permissions;

@property(nonatomic,assign)BOOL pro;

@property(nonatomic,strong)Staff *admin;

@property(nonatomic,assign)BOOL havePrivilege;

@property(nonatomic,copy)NSURL *wechatImg;

@property(nonatomic,copy)NSString *wechatName;

@property(nonatomic,assign)BOOL wechatSuccess;

@property(nonatomic,assign)BOOL haveTried;

@property(nonatomic,copy)NSURL *checkinScreenURL;

// 是否有地点信息，没有(nil)则需要完善信息, 修改时 这个信息并没有修改
@property(nonatomic,strong)YFDistrictModel *gd_district;

- (void)copyGymWhenMOdifySUccessGym:(Gym *)gym;

-(BOOL)isEqualToGym:(Gym*)gym;

-(Gym*)containInArray:(NSArray*)array;

// 解析 Json
- (void)resultJson:(NSDictionary *)obj;
@end
