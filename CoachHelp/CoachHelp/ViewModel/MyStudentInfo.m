//
//  MyStudentInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MyStudentInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/v2/coaches/%ld/students/"

@interface MyStudentInfo ()

{
    
    NSMutableArray *_array;
    
}

@end

@implementation MyStudentInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.students = [NSMutableArray array];
        
        self.gyms = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    if (!CoachId) {
        
        if (self.callBack) {
            
            self.callBack(NO,nil);
            
        }
        
    }else
    {
        
        NSString *api = [NSString stringWithFormat:API,CoachId];
        
        Parameters *para = [[Parameters alloc]init];
        
        if (AppGym.type.length &&AppGym.gymId) {
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
            
            [para setParameter:AppGym.type forKey:@"model"];
            
        }else if(AppGym.shopId && AppGym.brand.brandId){
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
            
            [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
            
        }

        [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                [self createDataWithArray:responseDic[@"data"][@"ships"]];
                
                if (self.callBack) {
                    
                    self.callBack(YES,nil);
                    
                }
                
            }else
            {
                
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
    
}

-(void)createDataWithArray:(NSArray *)array
{
    
    self.headArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Student *stu = [[Student alloc]init];
        
        stu.gym = AppGym;
        
        stu.name = obj[@"username"];
        
        stu.gender = [obj[@"gender"] integerValue]?@"女":@"男";
        
        stu.stuId = [obj[@"user"][@"id"] integerValue];
        
        stu.shipId = [obj[@"id"] integerValue];
        
        stu.photo = [NSURL URLWithString:obj[@"avatar"]];
        
        stu.phone = obj[@"phone"];
        
        if ([obj[@"head"] length]==1) {
            
            int asciicode = [obj[@"head"] characterAtIndex:0];
            
            if ((asciicode>=65 && asciicode <=90) || (asciicode>=97 && asciicode<=122)) {
                
                stu.head = [obj[@"head"] uppercaseString];
                
            }else
            {
                
                stu.head = @"#";
                
            }
            
        }else
        {
            
            stu.head = @"#";
            
        }
        
        if (![self.headArray containsObject:stu.head]) {
            
            [self.headArray addObject:stu.head];
            
        }
        
        [self.students addObject:stu];
        
    }];
    
}

-(void)getShowArraySearchText:(NSString *)searchText
{
    
    _array = [NSMutableArray array];
    
    if (searchText.length==0) {
        
        _array = self.students;
        
    }else if(searchText.length != 0)
    {
        
        for (Student *stu in self.students) {
            
            if ([stu.name rangeOfString:searchText].length||[stu.phone rangeOfString:searchText].length) {
                
                [_array addObject:stu];
                
            }
            
        }
        
    }
    
    [self dealArray];
    
}

-(void)dealArray
{
    
    self.showArray = [NSMutableArray array];
    
    [self.headArray sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]]];
    
    if ([self.headArray containsObject:@"#"]) {
        
        [self.headArray removeObjectAtIndex:0];
        
        [self.headArray addObject:@"#"];
    }
    
    [self.headArray enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *array =[NSMutableArray array];
        
        for (Student *stu in _array) {
            
            if ([stu.head isEqualToString:obj]) {
                
                [array addObject:stu];
                
            }
            
        }
        
        if (array.count) {
            
            [self.showArray addObject:@{@"head":obj,@"data":array}];

        }
        
    }];
    
}


@end
