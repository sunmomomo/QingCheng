//
//  BodyTestInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/12.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BodyTestInfo.h"

#define kNewAPI @"/api/measures/tpl/"

#define kGetAPI @"/api/measures/%ld/"

#define kAddAPI @"/api/measures/"

#define kChangeAPI @"/api/measures/%ld/"

@implementation BodyTestInfo

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.basicTypes = [NSMutableArray array];
        
        self.otherTypes = [NSMutableArray array];
        
        self.photos = [NSMutableArray array];
        
        self.bodyTest = [[BodyTest alloc]init];
        
        BodyTestType *height = [[BodyTestType alloc]init];
        
        height.typeKey = @"height";
        
        height.typeName = @"身高";
        
        height.unit = @"cm";
        
        height.value = @"";
        
        [self.basicTypes addObject:height];
        
        BodyTestType *weight = [[BodyTestType alloc]init];
        
        weight.typeKey = @"weight";
        
        weight.typeName = @"体重";
        
        weight.unit = @"kg";
        
        weight.value = @"";
        
        [self.basicTypes addObject:weight];
        
        BodyTestType *bmi = [[BodyTestType alloc]init];
        
        bmi.typeKey = @"bmi";
        
        bmi.typeName = @"BMI";
        
        bmi.unit = @"kg/m^2";
        
        bmi.value = @"";
        
        [self.basicTypes addObject:bmi];
        
        BodyTestType *body_fat_rate = [[BodyTestType alloc]init];
        
        body_fat_rate.typeKey = @"body_fat_rate";
        
        body_fat_rate.typeName = @"体脂";
        
        body_fat_rate.unit = @"%";
        
        body_fat_rate.value = @"";
        
        [self.basicTypes addObject:body_fat_rate];
        
        BodyTestType *circumference_of_left_upper = [[BodyTestType alloc]init];
        
        circumference_of_left_upper.typeKey = @"circumference_of_left_upper";
        
        circumference_of_left_upper.typeName = @"上臂围（左）";
        
        circumference_of_left_upper.unit = @"cm";
        
        circumference_of_left_upper.value = @"";
        
        [self.basicTypes addObject:circumference_of_left_upper];
        
        BodyTestType *circumference_of_right_upper = [[BodyTestType alloc]init];
        
        circumference_of_right_upper.typeKey = @"circumference_of_right_upper";
        
        circumference_of_right_upper.typeName = @"上臂围（右）";
        
        circumference_of_right_upper.unit = @"cm";
        
        circumference_of_right_upper.value = @"";
        
        [self.basicTypes addObject:circumference_of_right_upper];
        
        BodyTestType *circumference_of_chest = [[BodyTestType alloc]init];
        
        circumference_of_chest.typeKey = @"circumference_of_chest";
        
        circumference_of_chest.typeName = @"胸围";
        
        circumference_of_chest.unit = @"cm";
        
        circumference_of_chest.value = @"";
        
        [self.basicTypes addObject:circumference_of_chest];
        
        BodyTestType *waistline = [[BodyTestType alloc]init];
        
        waistline.typeKey = @"waistline";
        
        waistline.typeName = @"腰围";
        
        waistline.unit = @"cm";
        
        waistline.value = @"";
        
        [self.basicTypes addObject:waistline];
        
        BodyTestType *hipline = [[BodyTestType alloc]init];
        
        hipline.typeKey = @"hipline";
        
        hipline.typeName = @"臀围";
        
        hipline.unit = @"cm";
        
        hipline.value = @"";
        
        [self.basicTypes addObject:hipline];
        
        BodyTestType *circumference_of_left_thigh = [[BodyTestType alloc]init];
        
        circumference_of_left_thigh.typeKey = @"circumference_of_left_thigh";
        
        circumference_of_left_thigh.typeName = @"大腿围（左）";
        
        circumference_of_left_thigh.unit = @"cm";
        
        circumference_of_left_thigh.value = @"";
        
        [self.basicTypes addObject:circumference_of_left_thigh];
        
        BodyTestType *circumference_of_right_thigh = [[BodyTestType alloc]init];
        
        circumference_of_right_thigh.typeKey = @"circumference_of_right_thigh";
        
        circumference_of_right_thigh.typeName = @"大腿围（右）";
        
        circumference_of_right_thigh.unit = @"cm";
        
        circumference_of_right_thigh.value = @"";
        
        [self.basicTypes addObject:circumference_of_right_thigh];
        
        BodyTestType *circumference_of_left_calf = [[BodyTestType alloc]init];
        
        circumference_of_left_calf.typeKey = @"circumference_of_left_calf";
        
        circumference_of_left_calf.typeName = @"小腿围（左）";
        
        circumference_of_left_calf.unit = @"cm";
        
        circumference_of_left_calf.value = @"";
        
        [self.basicTypes addObject:circumference_of_left_calf];
        
        BodyTestType *circumference_of_right_calf = [[BodyTestType alloc]init];
        
        circumference_of_right_calf.typeKey = @"circumference_of_right_calf";
        
        circumference_of_right_calf.typeName = @"小腿围（右）";
        
        circumference_of_right_calf.unit = @"cm";
        
        circumference_of_right_calf.value = @"";
        
        [self.basicTypes addObject:circumference_of_right_calf];
        
    }
    
    return self;
}

-(void)getAddInfoWithStudent:(Student *)stu
{
    
    self.bodyTest.student = stu;
    
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
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:kNewAPI param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
    
    BodyTestType *weight = [self getTypeForTypeName:@"体重"];
    
    if (![basicDict[@"show_weight"]boolValue])
        [self.basicTypes removeObject:weight];
    
    BodyTestType *height = [self getTypeForTypeName:@"身高"];
    
    if(![basicDict[@"show_height"]boolValue])
        [self.basicTypes removeObject:height];
    
    BodyTestType *bmi = [self getTypeForTypeName:@"BMI"];
    
    if(![basicDict[@"show_bmi"]boolValue])
        [self.basicTypes removeObject:bmi];
    
    BodyTestType *body_fat_rate = [self getTypeForTypeName:@"体脂"];
    
    if(![basicDict[@"show_body_fat_rate"]boolValue])
        [self.basicTypes removeObject:body_fat_rate];
    
    BodyTestType *circumference_of_left_upper = [self getTypeForTypeName:@"上臂围（左）"];
    
    if(![basicDict[@"show_circumference_of_left_upper"]boolValue])
        [self.basicTypes removeObject:circumference_of_left_upper];
    
    BodyTestType *circumference_of_right_upper = [self getTypeForTypeName:@"上臂围（右）"];
    
    if(![basicDict[@"show_circumference_of_right_upper"]boolValue])
        [self.basicTypes removeObject:circumference_of_right_upper];
    
    BodyTestType *circumference_of_chest = [self getTypeForTypeName:@"胸围"];
    
    if(![basicDict[@"show_circumference_of_chest"]boolValue])
        [self.basicTypes removeObject:circumference_of_chest];
    
    BodyTestType *waistline = [self getTypeForTypeName:@"腰围"];
    
    if(![basicDict[@"show_waistline"]boolValue])
        [self.basicTypes removeObject:waistline];
    
    BodyTestType *hipline = [self getTypeForTypeName:@"臀围"];
    
    if(![basicDict[@"show_hipline"]boolValue])
        [self.basicTypes removeObject:hipline];
    
    BodyTestType *circumference_of_left_thigh = [self getTypeForTypeName:@"大腿围（左）"];
    
    if(![basicDict[@"show_circumference_of_left_thigh"]boolValue])
        [self.basicTypes removeObject:circumference_of_left_thigh];
    
    BodyTestType *circumference_of_right_thigh = [self getTypeForTypeName:@"大腿围（右）"];
    
    if(![basicDict[@"show_circumference_of_right_thigh"]boolValue])
        [self.basicTypes removeObject:circumference_of_right_thigh];
    
    BodyTestType *circumference_of_left_calf = [self getTypeForTypeName:@"小腿围（左）"];
    
    if(![basicDict[@"show_circumference_of_left_calf"]boolValue])
        [self.basicTypes removeObject:circumference_of_left_calf];
    
    BodyTestType *circumference_of_right_calf = [self getTypeForTypeName:@"小腿围（右）"];
    
    if(![basicDict[@"show_circumference_of_right_calf"]boolValue])
        [self.basicTypes removeObject:circumference_of_right_calf];
    
    NSArray *extra = dict[@"extra"];
    
    [extra enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BodyTestType *type = [[BodyTestType alloc]init];
        
        type.typeName = obj[@"name"];
        
        type.typeId = [obj[@"id"] integerValue];
        
        type.unit = obj[@"unit"];
        
        [self.otherTypes addObject:type];
        
    }];
    
    if (self.request) {
        self.request(YES);
    }
    
}

-(BodyTestType *)getTypeForTypeName:(NSString *)name
{
    
    __block BodyTestType *type;
    
    [self.basicTypes enumerateObjectsUsingBlock:^(BodyTestType *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.typeName isEqualToString:name]) {
            
            type = obj;
            
            *stop = YES;
            
        }
        
    }];
    
    if (!type) {
        
        [self.otherTypes enumerateObjectsUsingBlock:^(BodyTestType *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.typeName isEqualToString:name]) {
                
                type = obj;
                
                *stop = YES;
                
            }
            
        }];
        
    }
    
    return type;
    
}

-(void)getInfoWithTest:(BodyTest *)test
{
    
    self.bodyTest = test;
    
    self.date = test.date;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:AppGym.type forKey:@"model"];
    
    [para setInteger:AppGym.gymId forKey:@"id"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kGetAPI,(long)test.testId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
    
    BodyTestType *weight = [self getTypeForTypeName:@"体重"];
    
    if (dict[weight.typeKey]) {
        
        weight.value = [dict[weight.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:weight];
        
    }
    
    BodyTestType *height = [self getTypeForTypeName:@"身高"];
    
    if (dict[height.typeKey]) {
        
        height.value = [dict[height.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:height];
        
    }
    
    BodyTestType *bmi = [self getTypeForTypeName:@"BMI"];
    
    if (dict[bmi.typeKey]) {
        
        bmi.value = [dict[bmi.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:bmi];
        
    }
    
    BodyTestType *body_fat_rate = [self getTypeForTypeName:@"体脂"];
    
    if (dict[body_fat_rate.typeKey]) {
        
        body_fat_rate.value = [dict[body_fat_rate.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:body_fat_rate];
        
    }
    
    BodyTestType *circumference_of_left_upper = [self getTypeForTypeName:@"上臂围（左）"];
    
    if (dict[circumference_of_left_upper.typeKey]) {
        
        circumference_of_left_upper.value = [dict[circumference_of_left_upper.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_left_upper];
        
    }
    
    BodyTestType *circumference_of_right_upper = [self getTypeForTypeName:@"上臂围（右）"];
    
    if (dict[circumference_of_right_upper.typeKey]) {
        
        circumference_of_right_upper.value = [dict[circumference_of_right_upper.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_right_upper];
        
    }
    
    BodyTestType *circumference_of_chest = [self getTypeForTypeName:@"胸围"];
    
    if (dict[circumference_of_chest.typeKey]) {
        
        circumference_of_chest.value = [dict[circumference_of_chest.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_chest];
        
    }
    
    BodyTestType *waistline = [self getTypeForTypeName:@"腰围"];
    
    if (dict[waistline.typeKey]) {
        
        waistline.value = [dict[waistline.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:waistline];
        
    }
    
    BodyTestType *hipline = [self getTypeForTypeName:@"臀围"];
    
    if (dict[hipline.typeKey]) {
        
        hipline.value = [dict[hipline.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:hipline];
        
    }
    
    BodyTestType *circumference_of_left_thigh = [self getTypeForTypeName:@"大腿围（左）"];
    
    if (dict[circumference_of_left_thigh.typeKey]) {
        
        circumference_of_left_thigh.value = [dict[circumference_of_left_thigh.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_left_thigh];
        
    }
    
    BodyTestType *circumference_of_right_thigh = [self getTypeForTypeName:@"大腿围（右）"];
    
    if (dict[circumference_of_right_thigh.typeKey]) {
        
        circumference_of_right_thigh.value = [dict[circumference_of_right_thigh.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_right_thigh];
        
    }
    
    BodyTestType *circumference_of_left_calf = [self getTypeForTypeName:@"小腿围（左）"];
    
    if (dict[circumference_of_left_calf.typeKey]) {
        
        circumference_of_left_calf.value = [dict[circumference_of_left_calf.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_left_calf];
        
    }
    
    BodyTestType *circumference_of_right_calf = [self getTypeForTypeName:@"小腿围（右）"];
    
    if (dict[circumference_of_right_calf.typeKey]) {
        
        circumference_of_right_calf.value = [dict[circumference_of_right_calf.typeKey] stringValue];
        
    }else
    {
        
        [self.basicTypes removeObject:circumference_of_right_calf];
        
    }
    
    NSArray *extra = dict[@"extra"];
    
    [extra enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BodyTestType *bodyTest = [[BodyTestType alloc]init];
        
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
    
    [para setParameter:AppGym.type forKey:@"model"];
    
    [para setInteger:AppGym.gymId forKey:@"id"];
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:kGetAPI,(long)self.bodyTest.testId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)changeInfoWithIsAdd:(BOOL)isAdd
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (isAdd) {
      
        [para setParameter:[NSString stringWithFormat:@"%@T00:00:00",self.date] forKey:@"created_at"];
    
    }else
    {
        
        [para setParameter:[NSString stringWithFormat:@"%@T00:00:00",self.date] forKey:@"updated_at"];
        
    }
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSString stringWithFormat:@"%ld",(long)self.bodyTest.student.stuId] forKey:@"user_id"];
    
    BodyTestType *weight = [self getTypeForTypeName:@"体重"];
    
    if (weight.value.length) {
        
        [para setParameter:weight.value forKey:weight.typeKey];
        
    }
    
    BodyTestType *height = [self getTypeForTypeName:@"身高"];
    
    if (height.value.length) {
        
        [para setParameter:height.value forKey:height.typeKey];
        
    }
    
    BodyTestType *bmi = [self getTypeForTypeName:@"BMI"];
    
    if (bmi.value.length) {
        
        [para setParameter:bmi.value forKey:bmi.typeKey];
        
    }
    
    BodyTestType *body_fat_rate = [self getTypeForTypeName:@"体脂"];
    
    if (body_fat_rate.value.length) {
        
        [para setParameter:body_fat_rate.value forKey:body_fat_rate.typeKey];
        
    }
    
    BodyTestType *circumference_of_left_upper = [self getTypeForTypeName:@"上臂围（左）"];
    
    if (circumference_of_left_upper.value.length) {
        
        [para setParameter:circumference_of_left_upper.value forKey:circumference_of_left_upper.typeKey];
        
    }
    
    BodyTestType *circumference_of_right_upper = [self getTypeForTypeName:@"上臂围（右）"];
    
    if (circumference_of_right_upper.value.length) {
        
        [para setParameter:circumference_of_right_upper.value forKey:circumference_of_right_upper.typeKey];
        
    }
    
    BodyTestType *circumference_of_chest = [self getTypeForTypeName:@"胸围"];
    
    if (circumference_of_chest.value.length) {
        
        [para setParameter:circumference_of_chest.value forKey:circumference_of_chest.typeKey];
        
    }
    
    BodyTestType *waistline = [self getTypeForTypeName:@"腰围"];
    
    if (waistline.value.length) {
        
        [para setParameter:waistline.value forKey:waistline.typeKey];
        
    }
    
    BodyTestType *hipline = [self getTypeForTypeName:@"臀围"];
    
    if (hipline.value.length) {
        
        [para setParameter:hipline.value forKey:hipline.typeKey];
        
    }
    
    BodyTestType *circumference_of_left_thigh = [self getTypeForTypeName:@"大腿围（左）"];
    
    if (circumference_of_left_thigh.value.length) {
        
        [para setParameter:circumference_of_left_thigh.value forKey:circumference_of_left_thigh.typeKey];
        
    }
    
    BodyTestType *circumference_of_right_thigh = [self getTypeForTypeName:@"大腿围（右）"];
    
    if (circumference_of_right_thigh.value.length) {
        
        [para setParameter:circumference_of_right_thigh.value forKey:circumference_of_right_thigh.typeKey];
        
    }
    
    BodyTestType *circumference_of_left_calf = [self getTypeForTypeName:@"小腿围（左）"];
    
    if (circumference_of_left_calf.value.length) {
        
        [para setParameter:circumference_of_left_calf.value forKey:circumference_of_left_calf.typeKey];
        
    }
    
    BodyTestType *circumference_of_right_calf = [self getTypeForTypeName:@"小腿围（右）"];
    
    if (circumference_of_right_calf.value.length) {
        
        [para setParameter:circumference_of_right_calf.value forKey:circumference_of_right_calf.typeKey];
        
    }
    
    NSMutableArray *extraArray = [NSMutableArray array];
    
    for (BodyTestType *type in self.otherTypes) {
        
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
    
    if (isAdd) {
        
        [MOAFHelp AFPostHost:ROOT bindPath:kAddAPI postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                if (self.changeFinish) {
                    self.changeFinish(YES);
                }
                
            }else
            {
                
                if (self.changeFinish) {
                    self.changeFinish(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.changeFinish) {
                self.changeFinish(NO);
            }
            
        }];
        
    }else
    {
        
        [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:kChangeAPI,(long)self.infoId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                if (self.changeFinish) {
                    self.changeFinish(YES);
                }
                
            }else
            {
                
                if (self.changeFinish) {
                    self.changeFinish(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.changeFinish) {
                self.changeFinish(NO);
            }
            
        }];
        
    }
    
}

-(id)copy
{
    
    BodyTestInfo *info = [[BodyTestInfo alloc]init];
    
    info.infoId = self.infoId;
    
    info.basicTypes = [self.basicTypes mutableCopy];
    
    info.otherTypes = [self.otherTypes mutableCopy];
    
    info.photos = [self.photos mutableCopy];
    
    info.date = [self.date copy];
    
    info.bodyTest = self.bodyTest;
    
    return info;
    
}

@end
