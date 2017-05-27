//
//  StudentDetailInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "StudentDetailInfo.h"

#define kStuAPI @"/api/v2/coaches/%ld/students/%ld/"

#define kCourseAPI @"/api/students/%ld/schedules/"

#define kCardAPI @"/api/students/%ld/cards/"

#define kTestAPI @"/api/students/%ld/measures/"

#define DELETEAPI @"/api/v2/coaches/%ld/students/%ld/"

@interface StudentDetailInfo ()

{
    
    Parameters *_para;
    
}

@end

@implementation StudentDetailInfo

-(instancetype)initWithStudent:(Student *)student
{
    
    if (self = [super init]) {
        
        self.cardArray = [NSMutableArray array];
        
        self.testArray = [NSMutableArray array];
        
        self.recordArray = [NSMutableArray array];
        
        self.student = student;
        
        _para = [[Parameters alloc]init];
        
        if (AppGym.type.length &&AppGym.gymId) {
            
            [_para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
            
            [_para setParameter:AppGym.type forKey:@"model"];
            
        }else if(AppGym.shopId && AppGym.brand.brandId){
            
            [_para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
            
            [_para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
            
        }
        
        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kStuAPI,CoachId,(long)student.shipId] param:_para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                self.privateURL = [NSURL URLWithString:responseDic[@"data"][@"private_url"]];
                
                self.groupURL = [NSURL URLWithString:responseDic[@"data"][@"group_url"]];
                
                [self createStuDataWithDict:responseDic[@"data"][@"ship"]];
                
            }else
            {
                
                if (self.stuData) {
                    self.stuData(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.stuData) {
                self.stuData(NO);
            }
            
        }];
        
        [MOAFHelp AFGetHost:ROOT bindPath:                                                                                                                                                                                                                                                                                                                    [NSString stringWithFormat:kCourseAPI,(long)self.student.stuId] param:_para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self createCourseDataWithArray:responseDic[@"data"][@"schedules"]];
                
            }else{
                
                if (self.recordData) {
                    self.recordData(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.recordData) {
                self.recordData(NO);
            }
            
        }];
        
        [_para.data removeObjectForKey:@"order_by"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kCardAPI,(long)self.student.stuId] param:_para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self createCardDataWithArray:responseDic[@"data"][@"cards"]];
                
            }else
            {
                
                if (self.cardData) {
                    self.cardData(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.cardData) {
                self.cardData(NO);
            }
            
        }];
        
        [self reloadTestData];
        
    }
    
    return self;
    
}

-(void)reloadTestData
{
    
    self.testArray = [NSMutableArray array];

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kTestAPI,(long)self.student.stuId] param:_para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createTestDataWithArray:responseDic[@"data"][@"measures"]];
            
        }else
        {
            
            if (self.bodyTestData) {
                self.bodyTestData(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.bodyTestData) {
            self.bodyTestData(NO);
        }
        
    }];
    
}

-(void)createTestDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BodyTest *test = [[BodyTest alloc]init];
        
        if ( [obj[@"updated_at"] length]>=10) {
            
            test.date = [obj[@"updated_at"] substringToIndex:10];
            
        }
        
        test.testId = [obj[@"id"] integerValue];
        
        test.student = self.student;
        
        [self.testArray addObject:test];
        
    }];
    
    if (self.bodyTestData) {
        self.bodyTestData(YES);
    }
    
}

-(void)createCardDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Card *card = [[Card alloc]init];
        
        card.cardKind.type = [obj[@"type"] integerValue];
        
        card.checkValid = [obj[@"check_valid"] boolValue];
        
        card.remain = [obj[@"account"] floatValue];
        
        card.remainTimes = [obj[@"times"] stringValue];
        
        card.cardName = obj[@"name"];
        
        card.url = [NSURL URLWithString:obj[@"url"]];
        
        if ([obj[@"valid_from"] length]>=10)
            card.validFrom = [obj[@"valid_from"] substringToIndex:10];

        if([obj[@"valid_to"]length]>=10)
            card.validTo = [obj[@"valid_to"] substringToIndex:10];
        
        if ([obj[@"start"] length]>=10)
            card.start = [obj[@"start"] substringToIndex:10];
        
        if ([obj[@"end"] length]>=10)
            card.end = [obj[@"end"] substringToIndex:10];
        
        card.cardId = [obj[@"id"] integerValue];
        
        card.students = [[obj[@"users"] componentsSeparatedByString:@","]mutableCopy];
        
        [self.cardArray addObject:card];
        
    }];
    
    if (self.cardData) {
        self.cardData(YES);
    }
    
}

-(void)createCourseDataWithArray:(NSArray *)array
{
    
    NSMutableArray *yearArray = [NSMutableArray array];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Record *record = [[Record alloc]init];
        
        Course *course = record.course;
        
        record.recordId = [obj[@"id"]integerValue];
        
        record.coachName = obj[@"teacher"][@"username"];
        
        record.url = [NSURL URLWithString:obj[@"url"]];
        
        NSString *date;
        
        if ([obj[@"start"] length]>=10) {
            
            date = [obj[@"start"] substringToIndex:10];
            
            record.date = [date substringWithRange:NSMakeRange(8, 2)];
            
            record.month = [NSString stringWithFormat:@"%@月",[date substringWithRange:NSMakeRange(5, 2)]];
            
            record.year = [date substringWithRange:NSMakeRange(0, 4)];

        }
        
        course.imgUrl = [NSURL URLWithString:obj[@"course"][@"photo"]];
        
        course.courseId = [obj[@"course"][@"id"] integerValue];
        
        course.name = obj[@"course"][@"name"];
        
        if ([obj[@"start"] length]>11) {
            
            record.startTime = [obj[@"start"] substringWithRange:NSMakeRange(11, 5)];
            
        }
        
        if ([obj[@"end"] length]>11) {
            
            record.endTime = [obj[@"end"] substringWithRange:NSMakeRange(11, 5)];
            
        }
        
        if (![dateArray containsObject:date]) {
            
            record.showDate = YES;
            
            [dateArray addObject:date];
            
        }else
        {
            
            record.showDate = NO;
            
        }
        
        if (![yearArray containsObject:record.year]) {
            
            [yearArray addObject:record.year];
            
        }
        
        [tempArray addObject:record];
        
    }];
    
    for (NSString *year in yearArray) {
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (Record *record in tempArray) {
            
            if ([record.year isEqualToString:year]) {
                
                [dataArray addObject:record];
                
            }
            
        }
        
        [self.recordArray addObject:@{@"year":year,@"data":dataArray}];
        
    }
    
    if (self.recordData) {
        self.recordData(YES);
    }
    
}

-(void)createStuDataWithDict:(NSDictionary *)dict
{
    
    self.student.phone = dict[@"phone"];
    
    self.student.birth = dict[@"date_of_birth"];
    
    self.student.address = dict[@"address"];
    
    self.student.photo = [NSURL URLWithString:dict[@"avatar"]];
    
    if ([dict[@"joined_at"] length]>=10) {
        
        self.student.createDate = [dict[@"joined_at"] substringToIndex:10];
        
    }
    
    if (dict[@"area_code"]) {
        
        self.student.country = [[CountryPhoneInfo sharedInfo]getCountryWithCode:dict[@"area_code"]];
        
    }
        
    if (self.stuData) {
        self.stuData(YES);
    }
    
}

-(void)deleteWithStudentId:(NSInteger)stuId
{
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:AppGym.type forKey:@"model"];
    
    [para setParameter:[NSString stringWithFormat:@"%ld",(long)AppGym.gymId] forKey:@"id"];
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:DELETEAPI,CoachId,(long)stuId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]== 200) {
            
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

@end
