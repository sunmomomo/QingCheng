//
//  Gym.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Gym.h"

#import "DistrictInfo.h"

#import "UIColor+Hex.h"

#import "YFDateService.h"

#import "YYModel.h"

#import "NSString+replaceUnicode.h"

@implementation Gym

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.districtCode = [DistrictInfo sharedDistrictInfo].defaultDistrictCode;
        
        self.city = [DistrictInfo sharedDistrictInfo].defaultDistrictName;
        
        self.brand = [[Brand alloc]init];
        
        self.rate = [[CourseRate alloc]init];
        
        self.permissions = [[Permissions alloc]init];
    }
    return self;
}

-(id)copy
{
    
    Gym *gym = [[Gym alloc]init];
    
    gym.brand = self.brand;
    
    gym.name = self.name;
    
    gym.gymId = self.gymId;
    
    gym.shopId = self.shopId;
    
    gym.city = self.city;
    
    gym.color = self.color;
    
    gym.address = self.address;
    
    gym.summary = self.summary;
    
    gym.districtCode = self.districtCode;
    
    gym.type = self.type;
    
    gym.contact = self.contact;
    
    gym.ishot = self.ishot;
    
    gym.imgUrl = self.imgUrl;
    
    gym.systemEnd = self.systemEnd;
    
    gym.image = self.image;
    
    gym.url = self.url;
    
    gym.privateUrl = self.privateUrl;
    
    gym.groupUrl = self.groupUrl;
    
    gym.isCertificate = self.isCertificate;
    
    gym.courseCount = self.courseCount;
    
    gym.userCount = self.userCount;
    
    gym.remainDays = self.remainDays;
    
    gym.previewURL = self.previewURL;
    
    gym.hintURL = self.hintURL;
    
    gym.renewPrice = self.renewPrice;
    
    gym.isRecharged = self.isRecharged;
    
    gym.isFirstShop = self.isFirstShop;
    
    gym.havePower = self.havePower;
    
    gym.superuser = self.superuser;
    
    gym.receiveNotification = self.receiveNotification;
    
    gym.notificationConfigId = self.notificationConfigId;
    
    gym.position = self.position;
    
    gym.rate = self.rate;
    
    gym.permissions = self.permissions;
    
    gym.wechatImg = self.wechatImg;
    
    gym.wechatName = self.wechatName;
    
    gym.wechatSuccess = self.wechatSuccess;
    
    gym.havePrivilege = self.havePrivilege;
    
    gym.admin = self.admin;
    
    gym.haveTried = self.haveTried;
    
    gym.pro = self.pro;

    gym.checkinScreenURL = self.checkinScreenURL;
    
    gym.gym_IdForCompet = self.gym_IdForCompet;
    
    
    gym.gd_district = [[YFDistrictModel alloc] init];
    
    [gym.gd_district yy_modelSetWithJSON:[self.gd_district yy_modelToJSONObject]];
    
    
    return gym;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.brand forKey:@"brand"];
    
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeObject:self.city forKey:@"city"];
    
    [aCoder encodeObject:self.address forKey:@"address"];
    
    [aCoder encodeObject:self.contact forKey:@"contact"];
    
    [aCoder encodeObject:self.summary forKey:@"summary"];
    
    [aCoder encodeObject:self.districtCode forKey:@"districtCode"];
    
    [aCoder encodeObject:self.imgUrl forKey:@"imgUrl"];
    
    [aCoder encodeObject:self.image forKey:@"image"];
    
    [aCoder encodeInteger:self.shopId forKey:@"shopId"];
    
    [aCoder encodeObject:self.type forKey:@"type"];
    
    [aCoder encodeInteger:self.gymId forKey:@"gymId"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        self.brand = [aDecoder decodeObjectOfClass:[Brand class] forKey:@"brand"];
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.city = [aDecoder decodeObjectForKey:@"city"];
        
        self.address = [aDecoder decodeObjectForKey:@"address"];
        
        self.contact = [aDecoder decodeObjectForKey:@"contact"];
        
        self.summary = [aDecoder decodeObjectForKey:@"summary"];
        
        self.districtCode = [aDecoder decodeObjectForKey:@"districtCode"];
        
        self.imgUrl = [aDecoder decodeObjectOfClass:[NSURL class] forKey:@"imgUrl"];
        
        self.image = [aDecoder decodeObjectOfClass:[UIImage class] forKey:@"image"];
        
        self.shopId = [aDecoder decodeIntegerForKey:@"shopId"];
        
        self.type = [aDecoder decodeObjectForKey:@"type"];
        
        self.gymId = [aDecoder decodeIntegerForKey:@"gymId"];
        
    }
    
    return self;
    
}

-(BOOL)isEqualToGym:(Gym *)gym
{
    
    if (gym.gymId == self.gymId && [gym.type isEqualToString:self.type]) {
        
        return YES;
        
    }else if (gym.shopId == self.shopId){
        
        return YES;
        
    }else
    {
        
        return NO;
        
    }
    
}

-(Gym*)containInArray:(NSArray *)array
{
    
    Gym *gym = nil;
    
    for (Gym* tempGym in array) {
        
        if ([tempGym isEqualToGym:self]) {
            
            gym = tempGym;
            
            break;
        }
    }
    return gym;
}


- (void)resultJson:(NSDictionary *)obj
{
    
    self.imgUrl = [NSURL URLWithString:obj[@"photo"]];
    
    self.brand.name = obj[@"brand_name"];
    
    self.brand.brandId = [obj[@"brand_id"] integerValue];
    
    self.contact = obj[@"phone"];
    
    self.gymId = [obj[@"id"] integerValue];
    
    self.shopId = [obj[@"shop_id"] integerValue];
    
    self.name = obj[@"name"];
    
    self.systemEnd = obj[@"system_end"];
    
    self.type = obj[@"model"];
    
    self.color = [UIColor colorWithHexString:obj[@"color"]];
    
    self.position = obj[@"position"];
    
    self.haveTried = ![obj[@"can_trial"]boolValue];
    
    self.address = obj[@"address"];

    self.summary = obj[@"summary"];
    
    NSDictionary *districtDic = obj[@"gd_district"];
    
    if ([districtDic isKindOfClass:[NSDictionary class]] && districtDic.count)
    {
        NSLog(@"districtDic:%@",[districtDic.description replaceUnicode]);

        self.gd_district = [[YFDistrictModel alloc] init];
        
        [self.gd_district yy_modelSetWithJSON:districtDic];
        
        self.districtCode = self.gd_district.code;
        
        self.gd_district.city.name = [DistrictInfo checkCityName:self.gd_district.city.name];
        
    }else
    {
        self.gd_district = nil;
    }
    
    NSDateFormatter *dateFormatter = [YFDateService dateformatter];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSInteger remainDays = [[dateFormatter dateFromString:self.systemEnd] timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]]/86400;
    
    dateFormatter = nil;
    
    self.pro = remainDays>=0;
    
    if (self.gd_district.city.name.length)
    {
        self.city = self.gd_district.city.name;
        
    }else
    {
    if(obj[@"gd_district"][@"code"]){
        
            self.city = [DistrictInfo cityForDistrictCode:obj[@"gd_district"][@"code"]];
    }else{
        
        self.city = nil;
    }
   }
    
    self.gym_IdForCompet = [obj[@"gym_id"] integerValue];
}


-(void)copyGymWhenMOdifySUccessGym:(Gym *)gym
{
    if (self.gd_district.code.integerValue != gym.districtCode.integerValue)
    {
        [DistrictInfo setDisTrictMoel:self.gd_district disCode:gym.districtCode];
    }

    self.imgUrl = gym.imgUrl;
    
    self.name = gym.name;
    
    self.contact = gym.contact;
    
    self.summary = gym.summary;
    
    self.address = gym.address;
    
    self.districtCode = gym.districtCode;
    
    self.city = gym.city;

}

@end
