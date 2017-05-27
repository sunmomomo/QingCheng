//
//  MeasureDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MeasureDetailInfo.h"

#define kNewAPI @"/api/staffs/%ld/measures/tpl/"

#define kGetAPI @"/api/staffs/%ld/measures/%ld/"

#define kCreateAPI @"/api/staffs/%ld/measures/"

#define kChangeAPI @"/api/staffs/%ld/measures/%ld/"

@implementation MeasureDetailInfo

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.basicTypes = [NSMutableArray array];
        
        self.otherTypes = [NSMutableArray array];
        
        self.photos = [NSMutableArray array];
        
        self.measure = [[Measure alloc]init];
        
        MeasureType *height = [[MeasureType alloc]init];
        
        height.typeKey = @"height";
        
        height.typeName = @"身高";
        
        height.unit = @"cm";
        
        height.value = @"";
        
        [self.basicTypes addObject:height];
        
        MeasureType *weight = [[MeasureType alloc]init];
        
        weight.typeKey = @"weight";
        
        weight.typeName = @"体重";
        
        weight.unit = @"kg";
        
        weight.value = @"";
        
        [self.basicTypes addObject:weight];
        
        MeasureType *bmi = [[MeasureType alloc]init];
        
        bmi.typeKey = @"bmi";
        
        bmi.typeName = @"BMI";
        
        bmi.unit = @"kg/m^2";
        
        bmi.value = @"";
        
        [self.basicTypes addObject:bmi];
        
        MeasureType *body_fat_rate = [[MeasureType alloc]init];
        
        body_fat_rate.typeKey = @"body_fat_rate";
        
        body_fat_rate.typeName = @"体脂";
        
        body_fat_rate.unit = @"%";
        
        body_fat_rate.value = @"";
        
        [self.basicTypes addObject:body_fat_rate];
        
        MeasureType *circumference_of_left_upper = [[MeasureType alloc]init];
        
        circumference_of_left_upper.typeKey = @"circumference_of_left_upper";
        
        circumference_of_left_upper.typeName = @"上臂围（左）";
        
        circumference_of_left_upper.unit = @"cm";
        
        circumference_of_left_upper.value = @"";
        
        [self.basicTypes addObject:circumference_of_left_upper];
        
        MeasureType *circumference_of_right_upper = [[MeasureType alloc]init];
        
        circumference_of_right_upper.typeKey = @"circumference_of_right_upper";
        
        circumference_of_right_upper.typeName = @"上臂围（右）";
        
        circumference_of_right_upper.unit = @"cm";
        
        circumference_of_right_upper.value = @"";
        
        [self.basicTypes addObject:circumference_of_right_upper];
        
        MeasureType *circumference_of_chest = [[MeasureType alloc]init];
        
        circumference_of_chest.typeKey = @"circumference_of_chest";
        
        circumference_of_chest.typeName = @"胸围";
        
        circumference_of_chest.unit = @"cm";
        
        circumference_of_chest.value = @"";
        
        [self.basicTypes addObject:circumference_of_chest];
        
        MeasureType *waistline = [[MeasureType alloc]init];
        
        waistline.typeKey = @"waistline";
        
        waistline.typeName = @"腰围";
        
        waistline.unit = @"cm";
        
        waistline.value = @"";
        
        [self.basicTypes addObject:waistline];
        
        MeasureType *hipline = [[MeasureType alloc]init];
        
        hipline.typeKey = @"hipline";
        
        hipline.typeName = @"臀围";
        
        hipline.unit = @"cm";
        
        hipline.value = @"";
        
        [self.basicTypes addObject:hipline];
        
        MeasureType *circumference_of_left_thigh = [[MeasureType alloc]init];
        
        circumference_of_left_thigh.typeKey = @"circumference_of_left_thigh";
        
        circumference_of_left_thigh.typeName = @"大腿围（左）";
        
        circumference_of_left_thigh.unit = @"cm";
        
        circumference_of_left_thigh.value = @"";
        
        [self.basicTypes addObject:circumference_of_left_thigh];
        
        MeasureType *circumference_of_right_thigh = [[MeasureType alloc]init];
        
        circumference_of_right_thigh.typeKey = @"circumference_of_right_thigh";
        
        circumference_of_right_thigh.typeName = @"大腿围（右）";
        
        circumference_of_right_thigh.unit = @"cm";
        
        circumference_of_right_thigh.value = @"";
        
        [self.basicTypes addObject:circumference_of_right_thigh];
        
        MeasureType *circumference_of_left_calf = [[MeasureType alloc]init];
        
        circumference_of_left_calf.typeKey = @"circumference_of_left_calf";
        
        circumference_of_left_calf.typeName = @"小腿围（左）";
        
        circumference_of_left_calf.unit = @"cm";
        
        circumference_of_left_calf.value = @"";
        
        [self.basicTypes addObject:circumference_of_left_calf];
        
        MeasureType *circumference_of_right_calf = [[MeasureType alloc]init];
        
        circumference_of_right_calf.typeKey = @"circumference_of_right_calf";
        
        circumference_of_right_calf.typeName = @"小腿围（右）";
        
        circumference_of_right_calf.unit = @"cm";
        
        circumference_of_right_calf.value = @"";
        
        [self.basicTypes addObject:circumference_of_right_calf];
        
    }
    
    return self;
    
}

-(void)getAddInfoWithStudent:(Student *)stu andGym:(Gym *)gym
{
    
    self.measure.student = stu;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    self.date = [df stringFromDate:[NSDate date]];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kNewAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createAddDataWithDict:responseDic[@"data"][@"template"]];
            
        }else
        {
            
            if (self.request) {
                self.request(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
                
        if (self.request) {
            self.request(NO);
        }
        
    }];
    
}

-(void)createAddDataWithDict:(NSDictionary *)dict
{
    
    NSDictionary *basicDict = dict[@"base"];
                              
    MeasureType *weight = [self getTypeForTypeName:@"体重"];
    
    if (![basicDict[@"show_weight"]boolValue])
        [self.basicTypes removeObject:weight];
    
    MeasureType *height = [self getTypeForTypeName:@"身高"];
    
    if(![basicDict[@"show_height"]boolValue])
        [self.basicTypes removeObject:height];
    
    MeasureType *bmi = [self getTypeForTypeName:@"BMI"];
    
    if(![basicDict[@"show_bmi"]boolValue])
        [self.basicTypes removeObject:bmi];
    
    MeasureType *body_fat_rate = [self getTypeForTypeName:@"体脂"];
    
    if(![basicDict[@"show_body_fat_rate"]boolValue])
        [self.basicTypes removeObject:body_fat_rate];
    
    MeasureType *circumference_of_left_upper = [self getTypeForTypeName:@"上臂围（左）"];
    
    if(![basicDict[@"show_circumference_of_left_upper"]boolValue])
        [self.basicTypes removeObject:circumference_of_left_upper];
    
    MeasureType *circumference_of_right_upper = [self getTypeForTypeName:@"上臂围（右）"];
    
    if(![basicDict[@"show_circumference_of_right_upper"]boolValue])
        [self.basicTypes removeObject:circumference_of_right_upper];
    
    MeasureType *circumference_of_chest = [self getTypeForTypeName:@"胸围"];
    
    if(![basicDict[@"show_circumference_of_chest"]boolValue])
        [self.basicTypes removeObject:circumference_of_chest];
    
    MeasureType *waistline = [self getTypeForTypeName:@"腰围"];
    
    if(![basicDict[@"show_waistline"]boolValue])
        [self.basicTypes removeObject:waistline];
    
    MeasureType *hipline = [self getTypeForTypeName:@"臀围"];
    
    if(![basicDict[@"show_hipline"]boolValue])
        [self.basicTypes removeObject:hipline];
    
    MeasureType *circumference_of_left_thigh = [self getTypeForTypeName:@"大腿围（左）"];
    
    if(![basicDict[@"show_circumference_of_left_thigh"]boolValue])
        [self.basicTypes removeObject:circumference_of_left_thigh];
    
    MeasureType *circumference_of_right_thigh = [self getTypeForTypeName:@"大腿围（右）"];
    
    if(![basicDict[@"show_circumference_of_right_thigh"]boolValue])
        [self.basicTypes removeObject:circumference_of_right_thigh];
    
    MeasureType *circumference_of_left_calf = [self getTypeForTypeName:@"小腿围（左）"];
    
    if(![basicDict[@"show_circumference_of_left_calf"]boolValue])
        [self.basicTypes removeObject:circumference_of_left_calf];
    
    MeasureType *circumference_of_right_calf = [self getTypeForTypeName:@"小腿围（右）"];
    
    if(![basicDict[@"show_circumference_of_right_calf"]boolValue])
        [self.basicTypes removeObject:circumference_of_right_calf];
    
    NSArray *extra = dict[@"extra"];
    
    [extra enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MeasureType *type = [[MeasureType alloc]init];
        
        type.typeName = obj[@"name"];
        
        type.typeId = [obj[@"id"] integerValue];
        
        type.unit = obj[@"unit"];
        
        [self.otherTypes addObject:type];
        
    }];
    
    if (self.request) {
        self.request(YES);
    }
    
}

-(MeasureType *)getTypeForTypeName:(NSString *)name
{
    
    __block MeasureType *type;
    
    [self.basicTypes enumerateObjectsUsingBlock:^(MeasureType *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.typeName isEqualToString:name]) {
            
            type = obj;
            
            *stop = YES;
            
        }
        
    }];
    
    if (!type) {
        
        [self.otherTypes enumerateObjectsUsingBlock:^(MeasureType *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.typeName isEqualToString:name]) {
                
                type = obj;
                
                *stop = YES;
                
            }
            
        }];
        
    }
    
    return type;
    
}

-(void)getInfoWithMeasure:(Measure *)measure
{
    
    self.measure = measure;
    
    self.date = measure.date;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kGetAPI,StaffId,(long)measure.measureId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithDict:responseDic[@"data"][@"measure"]];
            
        }else
        {
            
            if (self.request) {
                self.request(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.request) {
            self.request(NO);
        }
        
    }];
    
}

-(void)createDataWithDict:(NSDictionary *)dict
{
    
    self.infoId = [dict[@"id"]integerValue];
    
    MeasureType *weight = [self getTypeForTypeName:@"体重"];
    
    if (dict[weight.typeKey]) {
        
        weight.value = [dict[weight.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:weight];
        
    }
    
    MeasureType *height = [self getTypeForTypeName:@"身高"];
    
    if (dict[height.typeKey]) {
        
        height.value = [dict[height.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:height];
        
    }
    
    MeasureType *bmi = [self getTypeForTypeName:@"BMI"];
    
    if (dict[bmi.typeKey]) {
        
        bmi.value = [dict[bmi.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:bmi];
        
    }
    
    MeasureType *body_fat_rate = [self getTypeForTypeName:@"体脂"];
    
    if (dict[body_fat_rate.typeKey]) {
        
        body_fat_rate.value = [dict[body_fat_rate.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:body_fat_rate];
        
    }
    
    MeasureType *circumference_of_left_upper = [self getTypeForTypeName:@"上臂围（左）"];
    
    if (dict[circumference_of_left_upper.typeKey]) {
        
        circumference_of_left_upper.value = [dict[circumference_of_left_upper.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_left_upper];
        
    }
    
    MeasureType *circumference_of_right_upper = [self getTypeForTypeName:@"上臂围（右）"];
    
    if (dict[circumference_of_right_upper.typeKey]) {
        
        circumference_of_right_upper.value = [dict[circumference_of_right_upper.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_right_upper];
        
    }
    
    MeasureType *circumference_of_chest = [self getTypeForTypeName:@"胸围"];
    
    if (dict[circumference_of_chest.typeKey]) {
        
        circumference_of_chest.value = [dict[circumference_of_chest.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_chest];
        
    }
    
    MeasureType *waistline = [self getTypeForTypeName:@"腰围"];
    
    if (dict[waistline.typeKey]) {
        
        waistline.value = [dict[waistline.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:waistline];
        
    }
    
    MeasureType *hipline = [self getTypeForTypeName:@"臀围"];
    
    if (dict[hipline.typeKey]) {
        
        hipline.value = [dict[hipline.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:hipline];
        
    }
    
    MeasureType *circumference_of_left_thigh = [self getTypeForTypeName:@"大腿围（左）"];
    
    if (dict[circumference_of_left_thigh.typeKey]) {
        
        circumference_of_left_thigh.value = [dict[circumference_of_left_thigh.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_left_thigh];
        
    }
    
    MeasureType *circumference_of_right_thigh = [self getTypeForTypeName:@"大腿围（右）"];
    
    if (dict[circumference_of_right_thigh.typeKey]) {
        
        circumference_of_right_thigh.value = [dict[circumference_of_right_thigh.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_right_thigh];
        
    }
    
    MeasureType *circumference_of_left_calf = [self getTypeForTypeName:@"小腿围（左）"];
    
    if (dict[circumference_of_left_calf.typeKey]) {
        
        circumference_of_left_calf.value = [dict[circumference_of_left_calf.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_left_calf];
        
    }
    
    MeasureType *circumference_of_right_calf = [self getTypeForTypeName:@"小腿围（右）"];
    
    if (dict[circumference_of_right_calf.typeKey]) {
        
        circumference_of_right_calf.value = [dict[circumference_of_right_calf.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_right_calf];
        
    }
    
    NSArray *extra = dict[@"extra"];
    
    [extra enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MeasureType *bodyTest = [[MeasureType alloc]init];
        
        bodyTest.typeKey = @"other";
        
        bodyTest.typeName = obj[@"name"];
        
        bodyTest.value = obj[@"value"];
        
        bodyTest.unit = obj[@"unit"];
        
        bodyTest.typeId = [obj[@"id"] integerValue];
        
        [self.otherTypes addObject:bodyTest];
        
    }];
    
    NSArray *photos = dict[@"photos"];
    
    [photos enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *url = obj[@"photo"];
        
        [self.photos addObject:url];
        
    }];
    
    if (self.request) {
        self.request(YES);
    }
    
}

-(void)deleteInfo
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:kGetAPI,StaffId,(long)self.measure.measureId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            if (self.deleteFinish) {
                self.deleteFinish(YES);
            }
            
        }else
        {
            
            if (self.deleteFinish) {
                self.deleteFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.deleteFinish) {
            self.deleteFinish(NO);
        }
        
    }];
    
}

-(void)createaInfoWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSString stringWithFormat:@"%@T00:00:00",self.date] forKey:@"created_at"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:[NSString stringWithFormat:@"%ld",(long)self.measure.student.stuId] forKey:@"user_id"];
    
    MeasureType *weight = [self getTypeForTypeName:@"体重"];
    
    if (weight.value.length) {
        
        [para setParameter:weight.value forKey:weight.typeKey];
        
    }
    
    MeasureType *height = [self getTypeForTypeName:@"身高"];
    
    if (height.value.length) {
        
        [para setParameter:height.value forKey:height.typeKey];
        
    }
    
    MeasureType *bmi = [self getTypeForTypeName:@"BMI"];
    
    if (bmi.value.length) {
        
        [para setParameter:bmi.value forKey:bmi.typeKey];
        
    }
    
    MeasureType *body_fat_rate = [self getTypeForTypeName:@"体脂"];
    
    if (body_fat_rate.value.length) {
        
        [para setParameter:body_fat_rate.value forKey:body_fat_rate.typeKey];
        
    }
    
    MeasureType *circumference_of_left_upper = [self getTypeForTypeName:@"上臂围（左）"];
    
    if (circumference_of_left_upper.value.length) {
        
        [para setParameter:circumference_of_left_upper.value forKey:circumference_of_left_upper.typeKey];
        
    }
    
    MeasureType *circumference_of_right_upper = [self getTypeForTypeName:@"上臂围（右）"];
    
    if (circumference_of_right_upper.value.length) {
        
        [para setParameter:circumference_of_right_upper.value forKey:circumference_of_right_upper.typeKey];
        
    }
    
    MeasureType *circumference_of_chest = [self getTypeForTypeName:@"胸围"];
    
    if (circumference_of_chest.value.length) {
        
        [para setParameter:circumference_of_chest.value forKey:circumference_of_chest.typeKey];
        
    }
    
    MeasureType *waistline = [self getTypeForTypeName:@"腰围"];
    
    if (waistline.value.length) {
        
        [para setParameter:waistline.value forKey:waistline.typeKey];
        
    }
    
    MeasureType *hipline = [self getTypeForTypeName:@"臀围"];
    
    if (hipline.value.length) {
        
        [para setParameter:hipline.value forKey:hipline.typeKey];
        
    }
    
    MeasureType *circumference_of_left_thigh = [self getTypeForTypeName:@"大腿围（左）"];
    
    if (circumference_of_left_thigh.value.length) {
        
        [para setParameter:circumference_of_left_thigh.value forKey:circumference_of_left_thigh.typeKey];
        
    }
    
    MeasureType *circumference_of_right_thigh = [self getTypeForTypeName:@"大腿围（右）"];
    
    if (circumference_of_right_thigh.value.length) {
        
        [para setParameter:circumference_of_right_thigh.value forKey:circumference_of_right_thigh.typeKey];
        
    }
    
    MeasureType *circumference_of_left_calf = [self getTypeForTypeName:@"小腿围（左）"];
    
    if (circumference_of_left_calf.value.length) {
        
        [para setParameter:circumference_of_left_calf.value forKey:circumference_of_left_calf.typeKey];
        
    }
    
    MeasureType *circumference_of_right_calf = [self getTypeForTypeName:@"小腿围（右）"];
    
    if (circumference_of_right_calf.value.length) {
        
        [para setParameter:circumference_of_right_calf.value forKey:circumference_of_right_calf.typeKey];
        
    }
    
    NSMutableArray *extraArray = [NSMutableArray array];
    
    for (MeasureType *type in self.otherTypes) {
        
        if (!type.value) {
            type.value = @"";
        }
        
        NSDictionary *dict = @{@"id":[NSString stringWithFormat:@"%ld",(long)type.typeId],@"unit":type.unit,@"value":type.value};
        
        [extraArray addObject:dict];
        
    }
    
    NSMutableArray *photos = [NSMutableArray array];
    
    for (NSString *url in self.photos) {
        
        [photos addObject:@{@"photo":url}];
        
    }
    
    [para setParameter:photos forKey:@"photos"];
    
    [para setParameter:extraArray forKey:@"extra"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kCreateAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)changeInfoResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSString stringWithFormat:@"%@T00:00:00",self.date] forKey:@"created_at"];
    
    [para setParameter:[NSString stringWithFormat:@"%ld",(long)self.measure.student.stuId] forKey:@"user_id"];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    MeasureType *weight = [self getTypeForTypeName:@"体重"];
    
    if (weight.value.length) {
        
        [para setParameter:weight.value forKey:weight.typeKey];
        
    }
    
    MeasureType *height = [self getTypeForTypeName:@"身高"];
    
    if (height.value.length) {
        
        [para setParameter:height.value forKey:height.typeKey];
        
    }
    
    MeasureType *bmi = [self getTypeForTypeName:@"BMI"];
    
    if (bmi.value.length) {
        
        [para setParameter:bmi.value forKey:bmi.typeKey];
        
    }
    
    MeasureType *body_fat_rate = [self getTypeForTypeName:@"体脂"];
    
    if (body_fat_rate.value.length) {
        
        [para setParameter:body_fat_rate.value forKey:body_fat_rate.typeKey];
        
    }
    
    MeasureType *circumference_of_left_upper = [self getTypeForTypeName:@"上臂围（左）"];
    
    if (circumference_of_left_upper.value.length) {
        
        [para setParameter:circumference_of_left_upper.value forKey:circumference_of_left_upper.typeKey];
        
    }
    
    MeasureType *circumference_of_right_upper = [self getTypeForTypeName:@"上臂围（右）"];
    
    if (circumference_of_right_upper.value.length) {
        
        [para setParameter:circumference_of_right_upper.value forKey:circumference_of_right_upper.typeKey];
        
    }
    
    MeasureType *circumference_of_chest = [self getTypeForTypeName:@"胸围"];
    
    if (circumference_of_chest.value.length) {
        
        [para setParameter:circumference_of_chest.value forKey:circumference_of_chest.typeKey];
        
    }
    
    MeasureType *waistline = [self getTypeForTypeName:@"腰围"];
    
    if (waistline.value.length) {
        
        [para setParameter:waistline.value forKey:waistline.typeKey];
        
    }
    
    MeasureType *hipline = [self getTypeForTypeName:@"臀围"];
    
    if (hipline.value.length) {
        
        [para setParameter:hipline.value forKey:hipline.typeKey];
        
    }
    
    MeasureType *circumference_of_left_thigh = [self getTypeForTypeName:@"大腿围（左）"];
    
    if (circumference_of_left_thigh.value.length) {
        
        [para setParameter:circumference_of_left_thigh.value forKey:circumference_of_left_thigh.typeKey];
        
    }
    
    MeasureType *circumference_of_right_thigh = [self getTypeForTypeName:@"大腿围（右）"];
    
    if (circumference_of_right_thigh.value.length) {
        
        [para setParameter:circumference_of_right_thigh.value forKey:circumference_of_right_thigh.typeKey];
        
    }
    
    MeasureType *circumference_of_left_calf = [self getTypeForTypeName:@"小腿围（左）"];
    
    if (circumference_of_left_calf.value.length) {
        
        [para setParameter:circumference_of_left_calf.value forKey:circumference_of_left_calf.typeKey];
        
    }
    
    MeasureType *circumference_of_right_calf = [self getTypeForTypeName:@"小腿围（右）"];
    
    if (circumference_of_right_calf.value.length) {
        
        [para setParameter:circumference_of_right_calf.value forKey:circumference_of_right_calf.typeKey];
        
    }
    
    NSMutableArray *extraArray = [NSMutableArray array];
    
    for (MeasureType *type in self.otherTypes) {
        
        if (!type.value) {
            type.value = @"";
        }
        
        NSDictionary *dict = @{@"id":[NSString stringWithFormat:@"%ld",(long)type.typeId],@"unit":type.unit,@"value":type.value};
        
        [extraArray addObject:dict];
        
    }
    
    NSMutableArray *photos = [NSMutableArray array];
    
    for (NSString *url in self.photos) {
        
        [photos addObject:@{@"photo":url}];
        
    }
    
    [para setParameter:photos forKey:@"photos"];
    
    [para setParameter:extraArray forKey:@"extra"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:kChangeAPI,StaffId,(long)self.infoId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(YES,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(id)copy
{
    
    MeasureDetailInfo *info = [[MeasureDetailInfo alloc]init];
    
    info.infoId = self.infoId;
    
    info.basicTypes = [self.basicTypes mutableCopy];
    
    info.otherTypes = [self.otherTypes mutableCopy];
    
    info.photos = [self.photos mutableCopy];
    
    info.date = [self.date copy];
    
    info.measure = self.measure;
    
    return info;
    
}

@end
