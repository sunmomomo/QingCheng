//
//  District.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "DistrictInfo.h"

#import "YFDistrictModel.h"

#define API @"/api/districts/"

@implementation District

@end

@implementation City

@end

@implementation Province

@end

@implementation DistrictInfo

+(NSString *)nameForDistrictCode:(NSString*)districtCode
{
    
    NSString *name = nil;
    
    DistrictInfo *districtInfo = [DistrictInfo sharedDistrictInfo];
    
    for (Province *province in districtInfo.provinces) {
     
        for (City *city in province.cities) {
            
            for (District *district in city.districts) {
                
                if ([district.districtCode isEqualToString:districtCode]) {
                    
                    if ([city.name isEqualToString:district.name]) {
                        
                        name = [province.name stringByAppendingString:city.name];
                        
                    }else{
                        
                        name = [[province.name stringByAppendingString:city.name] stringByAppendingString:district.name];
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    if ([name hasPrefix:@"北京"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    if ([name hasPrefix:@"重庆"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    if ([name hasPrefix:@"天津"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    if ([name hasPrefix:@"上海"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    return name;
    
}

+(void)setDisTrictMoel:(YFDistrictModel *)disTriModel disCode:(NSString *)districtCode
{
    DistrictInfo *districtInfo = [DistrictInfo sharedDistrictInfo];
    
    for (Province *province in districtInfo.provinces) {
        
        for (City *city in province.cities) {
            
            for (District *district in city.districts) {
                
                if ([district.districtCode isEqualToString:districtCode]) {
                    
                    disTriModel.name = district.name;
                    disTriModel.code = district.districtCode;
                    
                    disTriModel.city.name = [self checkCityName:city.name];
                    disTriModel.city.code = city.cityCode;
                    
                    disTriModel.province.name = province.name;
                    disTriModel.province.code = province.provinceCode;
                }
                
            }
            
        }
        
    }

}

+(NSString *)cityForDistrictCode:(NSString *)districtCode
{
    
    NSString *name = nil;
    
    DistrictInfo *districtInfo = [DistrictInfo sharedDistrictInfo];
    
    for (Province *province in districtInfo.provinces) {
        
        for (City *city in province.cities) {
            
            for (District *district in city.districts) {
                
                if ([district.districtCode isEqualToString:districtCode]) {
                    
                    name = [province.name stringByAppendingString:city.name];
                    
                }
                
            }
            
        }
        
    }
    
    
    return [self checkCityName:name];
    
}


+(NSString *)checkCityName:(NSString *)name
{

    if ([name hasPrefix:@"北京"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    if ([name hasPrefix:@"重庆"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    if ([name hasPrefix:@"天津"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    if ([name hasPrefix:@"上海"]) {
        
        name = [name substringFromIndex:3];
        
    }
    
    return name;
    
}



+(NSString *)formatCityName:(NSString *)city
{
    
    NSString *name = nil;
    
    DistrictInfo *districtInfo = [DistrictInfo sharedDistrictInfo];
    
    for (Province *province in districtInfo.provinces) {
        
        for (City *tempCity in province.cities) {
            
            if ([tempCity.name rangeOfString:city].length) {
                
                name = tempCity.name;
                
            }
            
        }
        
    }
    
    return name;
    
}

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.provinces = [NSMutableArray array];
        
        [self readContent];
        
    }
    
    return self;
    
}

+(instancetype)sharedDistrictInfo
{
    
    static DistrictInfo *info;
    
    if (!info.provinces.count) {
        
        info = [[self alloc]init];
        
    }
    
    return info;
    
}

-(void)readContent
{
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"高德城市码"ofType:@"json"];
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSArray *array = dict[@"data"][@"provinces"];
    
    [self createDataWithArray:array];
    
}

-(void)createDataWithArray:(NSArray *)array
{
    
    self.defaultDistrictName = @"北京市朝阳区";
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * stop) {
        
        Province *province = [[Province alloc]init];
        
        province.provinceCode = obj[@"code"];
        
        province.name = obj[@"name"];
        
        NSArray *cities = obj[@"cities"];
        
        province.cities = [NSMutableArray array];
        
        [cities enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * stop) {
            
            City *city = [[City alloc]init];
            
            city.cityCode = obj[@"code"];
            
            if ([obj[@"name"] hasSuffix:@"市辖区"]) {
                
                city.name = [obj[@"name"] substringToIndex:[obj[@"name"] length]-3];
                
            }else{
                
                city.name = obj[@"name"];
                
            }
            
            NSArray *districts = obj[@"districts"];
            
            city.districts = [NSMutableArray array];
            
            if ([districts count]) {
                
                [districts enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * stop) {
                    
                    District *district = [[District alloc]init];
                    
                    district.districtCode = obj[@"code"];
                    
                    district.name = obj[@"name"];
                    
                    [city.districts addObject:district];
                    
                    if ([province.name isEqualToString:@"北京市"] && [city.name isEqualToString:@"北京市"] && [district.name isEqualToString:@"朝阳区"]) {
                        
                        self.defaultDistrictCode = district.districtCode;
                        
                    }
                    
                }];
                
            }else{
                
                District *district = [[District alloc]init];
                
                district.districtCode = city.cityCode;
                
                district.name = city.name;
                
                [city.districts addObject:district];
                
            }
            
            [province.cities addObject:city];
            
        }];
        
        [self.provinces addObject:province];
        
    }];
    
}

@end
