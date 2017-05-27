//
//  District.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface District : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *districtCode;

@end

@interface City : NSObject

@property(nonatomic,strong)NSMutableArray *districts;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *cityCode;

@end

@interface Province : NSObject

@property(nonatomic,strong)NSMutableArray *cities;

@property(nonatomic,copy)NSString *provinceCode;

@property(nonatomic,copy)NSString *name;

@end

@interface DistrictInfo : NSObject

@property(nonatomic,strong)NSMutableArray *provinces;

@property(nonatomic,copy)NSString *defaultDistrictName;

@property(nonatomic,copy)NSString *defaultDistrictCode;

+(NSString*)formatCityName:(NSString*)city;

+(NSString *)nameForDistrictCode:(NSString*)districtCode;

+(NSString *)cityForDistrictCode:(NSString*)districtCode;

+(instancetype)sharedDistrictInfo;

@end
