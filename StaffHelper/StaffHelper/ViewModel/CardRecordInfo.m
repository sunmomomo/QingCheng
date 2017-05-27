//
//  CardRecordInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRecordInfo.h"

#define API @"/api/staffs/%ld/cards/%ld/histories/"

@interface CardRecordInfo ()

{
    
    NSInteger _currentPage;
    
    NSInteger _totalPages;
 
    NSInteger _month;
    
    NSInteger _year;
    
    NSInteger _cardId;
    
}

@end

@implementation CardRecordInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.records = [NSMutableArray array];
        
        _currentPage = 0;
        
        _totalPages = 1;
        
    }
    return self;
}

-(void)update
{
    
    if (_currentPage>=_totalPages) {
        
        if (self.requestFinish) {
            self.requestFinish(YES);
        }
        
        return;
        
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSDate *firstDate = [df dateFromString:[NSString stringWithFormat:@"%ld-%ld-01",
                                            (long)_year,(long)_month]];
    
    NSInteger numberOfDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDate].length;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:@"-created_at" forKey:@"order_by"];
    
    [para setParameter:[NSNumber numberWithInteger:_currentPage+1] forKey:@"page"];
    
    [para setParameter:[NSString stringWithFormat:@"%ld-%ld-01",(long)_year,(long)_month] forKey:@"created_at__gte"];
    
    [para setParameter:[NSString stringWithFormat:@"%ld-%ld-%ld",(long)_year,(long)_month,(long)numberOfDays] forKey:@"created_at__lte"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)_cardId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"card_histories"]];
            
            _totalPages = [responseDic[@"data"][@"pages"] integerValue];
            
            _currentPage = [responseDic[@"data"][@"current_page"] integerValue];
            
            self.totalCharge = [NSString stringWithFormat:@"%.2f",[responseDic[@"data"][@"stat"][@"total_account"] floatValue]];
            
            self.totalCost = [NSString stringWithFormat:@"%.2f",[responseDic[@"data"][@"stat"][@"total_cost"] floatValue]];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
}


-(void)requestWithCard:(Card *)card withMonth:(NSInteger)month andYear:(NSInteger)year
{
    
    _month = month;
    
    _year = year;
    
    _cardId = card.cardId;
    
    if (_currentPage>=_totalPages) {
        
        if (self.requestFinish) {
            self.requestFinish(YES);
        }
        
        return;
        
    }
    
    [self update];
    
}

-(void)createDataWithArray:(NSArray*)array
{
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CardRecord *record = [[CardRecord alloc]init];
        
        if ([obj[@"type"] isKindOfClass:[NSString class]]) {
            
            record.typeName = obj[@"type"];
            
        }else{
            
            record.typeName = [obj[@"type"] stringValue];
            
        }
        
        record.type = [obj[@"type_int"] integerValue];
        
        if (record.type == 2) {
            
            record.course.name = obj[@"order"][@"course"][@"name"];
            
            record.course.imgUrl = [NSURL URLWithString:obj[@"order"][@"course"][@"photo"]];
            
            record.courseUser = obj[@"order"][@"username"];
            
            if ([obj[@"order"][@"start"] length]>=16) {
                
                record.courseTime = [[obj[@"order"][@"start"] stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:16];
                
            }
            
            record.courseUserCount = [obj[@"order"][@"count"] integerValue];
            
        }else
        {
            
            record.imgURL = [NSURL URLWithString:obj[@"photo"]];
            
            record.seller = obj[@"seller"][@"username"];
            
        }
        
        if ([obj[@"created_at"] length]>=16) {
            
            record.createTime = [[[obj[@"created_at"] componentsSeparatedByString:@"T"] lastObject] substringToIndex:5];
            
            record.month = [obj[@"created_at"] substringWithRange:NSMakeRange(5, 2)];
            
            if ([record.month hasPrefix:@"0"]) {
                
                record.month = [record.month substringFromIndex:1];
                
            }
                            
            record.date = [obj[@"created_at"] substringWithRange:NSMakeRange(8, 2)];
        
        }
        
        record.cost = [NSString stringWithFormat:@"%.2f",[obj[@"cost"] floatValue]];
        
        if (![dateArray containsObject:record.date]) {
            
            [dateArray addObject:record.date];
            
            record.first = YES;
            
        }else
        {
            
            record.first = NO;
            
        }
        
        [self.records addObject:record];
        
    }];
    
}

@end
