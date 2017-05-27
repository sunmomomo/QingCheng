//
//  AllFunctionInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "AllFunctionInfo.h"

#define API @"/api/v2/staffs/%ld/gym-module-custom/"

@implementation Function

-(id)copy
{
    
    Function *func = [[Function alloc]init];
    
    func.key = self.key;
    
    func.module = self.module;
    
    func.imagePath = self.imagePath;
    
    func.title = self.title;
    
    func.pro = self.pro;
    
    return func;
    
}

@end

@implementation FunctionGroup



@end

@implementation AllFunctionInfo

+(AllFunctionInfo *)defaultInfo
{
    
    AllFunctionInfo *info = [[AllFunctionInfo alloc]init];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"functionInfo" ofType:@"plist"];
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray *allFuncs = [NSMutableArray array];
    
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FunctionGroup *group = [[FunctionGroup alloc]init];
        
        group.title = obj[@"title"];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in obj[@"data"]) {
            
            Function *function = [[Function alloc]init];
            
            function.key = dict[@"key"];
            
            function.module = dict[@"module"];
            
            function.title = dict[@"title"];
            
            function.imagePath = dict[@"imagePath"];
            
            function.pro = [dict[@"pro"] boolValue];
            
            [array addObject:function];
            
        }
        
        group.functions = [array copy];
        
        [allFuncs addObject:group];
        
    }];
    
    info.allFunctions = [allFuncs copy];
    
    return info;
    
}

+(Function *)functionWithKey:(NSString *)key
{
    
    Function *func = nil;
    
    AllFunctionInfo *info = [AllFunctionInfo defaultInfo];
    
    for (FunctionGroup *group in info.allFunctions) {
        
        for (Function *function in group.functions) {
            
            if ([function.key isEqualToString:key]) {
                
                func = function;
                
            }
            
        }
        
    }
    
    return func;
    
}

+(Function*)functionWithTitle:(NSString *)title
{
    
    Function *func = nil;
    
    AllFunctionInfo *info = [AllFunctionInfo defaultInfo];
    
    for (FunctionGroup *group in info.allFunctions) {
        
        for (Function *function in group.functions) {
            
            if ([function.title isEqualToString:title]) {
                
                func = function;
                
            }
            
        }
        
    }
    
    return func;
    
}

-(void)requestMyFunctionResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.myFunctions = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]== 200) {
            
            if ([responseDic[@"data"][@"module_custom"] isKindOfClass:[NSArray class]]) {
                
                [responseDic[@"data"][@"module_custom"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSString class]]) {
                        
                        Function *func = [[Function alloc]init];
                        
                        func = [AllFunctionInfo functionWithKey:obj];
                        
                        if (func) {
                            
                            [self.myFunctions addObject:func];
                            
                        }
                        
                    }
                    
                }];
                
            }
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)uploadMyFunctions:(NSArray *)functions result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    NSMutableArray *funcs = [NSMutableArray array];
    
    for (Function *func in functions) {
        
        [funcs addObject:func.key];
        
    }
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:funcs forKey:@"module_custom"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

+(NSArray *)defaultFunctions
{
    
    NSData *gymData = [[NSUserDefaults standardUserDefaults]objectForKey:@"func_edit"];
    
    NSArray *editGyms = [NSKeyedUnarchiver unarchiveObjectWithData:gymData];
    
    BOOL contains = NO;
    
    for (Gym *gym in editGyms) {
        
        if ([gym isEqualToGym:AppGym]) {
            
            contains = YES;
            
            break;
            
        }
        
    }
    
    NSMutableArray *functions = [NSMutableArray array];
    
    if (contains) {
        
        return functions;
        
    }
    
    [functions addObject:[AllFunctionInfo functionWithTitle:@"课程预约"]];
    
    [functions addObject:[AllFunctionInfo functionWithTitle:@"团课"]];
    
    [functions addObject:[AllFunctionInfo functionWithTitle:@"私教"]];
    
    [functions addObject:[AllFunctionInfo functionWithTitle:@"会员"]];
    
    [functions addObject:[AllFunctionInfo functionWithTitle:@"会员卡"]];
    
    [functions addObject:[AllFunctionInfo functionWithTitle:@"教练"]];
    
    [functions addObject:[AllFunctionInfo functionWithTitle:@"会员端配置"]];
    
    return functions;
    
}

@end
