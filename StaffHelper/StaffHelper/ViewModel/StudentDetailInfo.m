//
//  StudentDetailInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "StudentDetailInfo.h"

#import "UIColor+Hex.h"

#define kCreateAPI @"/api/staffs/%ld/users/"

#define kStuAPI @"/api/v2/staffs/%ld/users/%ld/"

#define kCourseAPI @"/api/staffs/%ld/users/%ld/schedules/"

#define kAttendanceAPI @"/api/staffs/%ld/users/attendance/records/"

//http://127.0.0.1:9000/api/staffs/49/users/attendance/records/?brand_id=2&shop_id=4&user_id=12

#define kCardAPI @"/api/staffs/%ld/users/%ld/cards/"

#define kFollowAPI @"/api/staffs/%ld/users/%ld/records/"

#import "YFListCache.h"
#import "YFAppConfig.h"

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
        
        self.followArray = [NSMutableArray array];
        
        self.recordArray = [NSMutableArray array];
        
        self.student = student;
        
    }
    
    return self;
    
}

-(void)request
{
    
    [self requestRecoWithStu:self.student];
    
    [self requestStuInfoWithStudent:self.student];
    
}

-(void)requestStuInfoWithStudent:(Student *)student
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kStuAPI,StaffId,(long)student.stuId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        DebugLogYF(@"%@",responseDic);
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            NSDictionary *dict = responseDic[@"data"][@"user"];
            
            self.privateURL = [NSURL URLWithString:responseDic[@"data"][@"private_url"]];
            
            self.groupURL = [NSURL URLWithString:responseDic[@"data"][@"group_url"]];
            
            self.student.name = dict[@"username"];
            
            self.student.phone = dict[@"phone"];
            
            if (dict[@"area_code"]) {
                
                self.student.country = [[CountryPhoneInfo sharedInfo]getCountryWithCode:dict[@"area_code"]];
                
            }
            
            self.student.address = dict[@"address"];
            
            self.student.birth = dict[@"date_of_birth"];
            
            self.student.stuId = [dict[@"id"] integerValue];
            
            self.student.createDate = [[dict[@"joined_at"] componentsSeparatedByString:@"T"]firstObject];
            
            self.student.avatar = [NSURL URLWithString:dict[@"avatar"]];
            
            self.student.photo = [NSURL URLWithString:dict[@"checkin_avatar"]];
            
            self.student.sex = [dict[@"gender"] integerValue]?SexTypeWoman:SexTypeMan;
            
            self.student.type = [dict[@"status"] integerValue];
            
            self.student.remarks = dict[@"remarks"];
            self.student.origin = dict[@"origin"];
            self.student.recommend_by_id = dict[@"recommend_by_id"];
            self.student.recommend_by = dict[@"recommend_by"];

            
            if (dict[@"sellers"]) {
                
                NSMutableArray *sellers = [NSMutableArray array];
                
                [dict[@"sellers"] enumerateObjectsUsingBlock:^(id  _Nonnull sellerObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Seller *seller = [[Seller alloc]init];
                    
                    seller.name = sellerObj[@"username"];
                    
                    seller.sellerId = [sellerObj[@"id"] integerValue];
                    
                    [sellers addObject:seller];
                    
                }];
                
                self.student.sellers = sellers;
                
            }
            
            if (dict[@"coaches"]) {
                
                NSMutableArray *coaches = [NSMutableArray array];
                
                [dict[@"coaches"] enumerateObjectsUsingBlock:^(id  _Nonnull coachObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Coach *coach = [[Coach alloc]init];
                    
                    coach.name = coachObj[@"username"];
                    
                    coach.coachId = [coachObj[@"id"] integerValue];
                    
                    [coaches addObject:coach];
                    
                }];
                
                self.student.coaches = coaches;
                
            }
            
            if (self.stuFinish) {
                self.stuFinish(YES);
            }
            
        }else
        {
            
            if (self.stuFinish) {
                self.stuFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.stuFinish) {
            self.stuFinish(NO);
        }
        
    }];
    
}

-(void)requestChestCardInfoWithStudent:(Student *)student
{
    
    self.cardArray = [NSMutableArray array];
    
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
    
    [para setParameter:@"-id" forKey:@"order_by"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kCardAPI,StaffId,(long)student.stuId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createCardDataWithArray:responseDic[@"data"][@"cards"]];
            
            if (self.cardDataFinish) {
                self.cardDataFinish(YES);
            }
            
        }else
        {
            
            if (self.cardDataFinish) {
                self.cardDataFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.cardDataFinish) {
            self.cardDataFinish(NO);
        }
        
    }];
    
}
-(void)requestCardInfoWithStudent:(Student *)student
{
    
    self.cardArray = [NSMutableArray array];
    
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
    
    [para setParameter:@"-id" forKey:@"order_by"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kCardAPI,StaffId,(long)student.stuId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createCardDataWithArray:responseDic[@"data"][@"cards"]];
            
            if (self.cardDataFinish) {
                self.cardDataFinish(YES);
            }
            
        }else
        {
            
            if (self.cardDataFinish) {
                self.cardDataFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.cardDataFinish) {
            self.cardDataFinish(NO);
        }
        
    }];
    
}

-(void)requestFollowDataWithStudent:(Student *)student
{
    
    self.followArray = [NSMutableArray array];
    
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
    
    [para setParameter:@"app" forKey:@"format"];
    
    [para setParameter:@"created_at" forKey:@"order_by"];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kFollowAPI,StaffId,(long)student.stuId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createFollowDataWithArray:responseDic[@"data"][@"records"]];
            
            if (self.followFinish) {
                self.followFinish(YES);
            }
            
        }else
        {
            
            if (self.followFinish) {
                self.followFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.followFinish) {
            self.followFinish(NO);
        }
        
    }];
    
}

-(void)requestRecoWithStu:(Student *)stu
{
    
    self.recordArray = [NSMutableArray array];
    
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
    
    [para.data addEntriesFromDictionary:self.recoShopidParam];
    
    [para setInteger:(long)stu.stuId forKey:@"user_id"];
    
    
    DebugLogParamYF(@"%@",para.data);
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kAttendanceAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createRecordGymDataWithArray:responseDic[@"data"][@"shops"]];

            [self createRecordDataWithArray:responseDic[@"data"][@"attendances"]];
            
            self.statModel = [YFStatAbsenModel defaultWithYYModelDic:responseDic[@"data"][@"stat"]];
            
            if (self.recordFinish) {
                self.recordFinish(YES);
            }
            
        }else
        {
            
            if (self.recordFinish) {
                self.recordFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.recordFinish) {
            self.recordFinish(NO);
        }
        
    }];
    
    [self requestFollowDataWithStudent:stu];
    
    [self requestCardInfoWithStudent:stu];
    
}

-(void)createCardDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Card *card = [[Card alloc]init];
        
        card.cardId = [obj[@"id"] integerValue];
        
        card.color = [UIColor colorWithHexString:obj[@"color"]];
        
        card.cardNumber = obj[@"card_no"];
        
        card.cardName = obj[@"name"];
        
        card.cardKind.cardKindName = obj[@"name"];
        
        card.state = [obj[@"is_locked"] boolValue]?CardStateRest:CardStateNormal;
        
        card.cardKind.type = [obj[@"type"] integerValue];
        
        card.checkValid = [obj[@"check_valid"] boolValue];
        
        card.lockStart = [obj[@"lock_start"] length]?[obj[@"lock_start"] substringToIndex:10]:@"";
        
        card.lockEnd = [obj[@"lock_end"] length]?[obj[@"lock_end"] substringToIndex:10]:@"";
        
        card.start = [obj[@"start"] length]?[obj[@"start"] substringToIndex:10]:@"";
        
        card.end = [obj[@"end"] length]?[obj[@"end"] substringToIndex:10]:@"";
        
        card.validFrom = [obj[@"valid_from"] length]?[obj[@"valid_from"] substringToIndex:10]:@"";
        
        card.validTo = [obj[@"valid_to"] length]?[obj[@"valid_to"] substringToIndex:10]:@"";
        
        card.remain = [obj[@"balance"] integerValue];
        
        NSMutableArray *users = [NSMutableArray array];
        
        [obj[@"users"] enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Student *stu = [[Student alloc]init];
            
            stu.stuId = [object[@"id"] integerValue];
            
            stu.name = object[@"username"];

            [users addObject:stu];
            
        }];
        
        card.users = users;
        
        NSMutableArray *gyms = [NSMutableArray array];
        
        [obj[@"card_tpl"][@"shops"] enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Gym *gym = [[Gym alloc]init];
            
            gym.shopId = [object[@"id"] integerValue];
            
            gym.name = object[@"name"];
            
            gym.brand.brandId = [BRANDID integerValue];
            
            [gyms addObject:gym];
            
        }];
        
        card.cardKind.gyms = gyms;
        
        card.cardKind.cardKindId = [obj[@"card_tpl"][@"id"] integerValue];
        
        [self.cardArray addObject:card];
        
    }];
    
}

-(void)createRecordGymDataWithArray:(NSArray*)array
{
    self.gymArray = [NSMutableArray array];

    array = [array guardArrayYF];
    
    for (NSDictionary *dic in array) {
        Gym *gym = [[Gym alloc]init];
        
        gym.shopId = [dic[@"id"] integerValue];
        
        gym.name = dic[@"name"];
        
        gym.imgUrl = dic[@"photo"];
        
        [self.gymArray addObject:gym];
    }
}

-(void)createRecordDataWithArray:(NSArray*)array
{
    
    NSMutableArray *monthArray = [NSMutableArray array];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Record *record = [[Record alloc]init];
        
        record.type = [obj[@"type"] integerValue];
        
        Gym *gym = [[Gym alloc]init];
            
        gym.shopId = [obj[@"shop"][@"id"] integerValue];
            
        gym.name = obj[@"shop"][@"name"];

        record.gym = gym;
        
        
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
        
        course.type = [obj[@"course"][@"is_private"] integerValue];
        
      
        
        if ([obj[@"start"] length]>=16) {
            
            record.startTime = [obj[@"start"] substringWithRange:NSMakeRange(11, 5)];
            
        }
        
        if ([obj[@"end"] length]>=16) {
            
            record.endTime = [obj[@"end"] substringWithRange:NSMakeRange(11, 5)];
            
        }
        
        if (![dateArray containsObject:date]) {
            
            record.showDate = YES;
            
            [dateArray addObject:date];
            
        }else
        {
            
            record.showDate = NO;
            
        }
        
        if (![monthArray containsObject:@{@"month":record.month,@"year":record.year}]) {
            
            [monthArray addObject:@{@"month":record.month,@"year":record.year}];
            
        }
        
        [tempArray addObject:record];
        
    }];
    
    for (NSDictionary *dict in monthArray) {
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (Record *record in tempArray) {
            
            if ([record.month isEqualToString:dict[@"month"]] && [record.year isEqualToString:dict[@"year"]]) {
                
                [dataArray addObject:record];
                
            }
            
        }
        
        NSInteger groupCount = 0;
        
        NSInteger privareCount = 0;
        
        NSInteger checkInCount = 0;
        
        for (Record *record in dataArray) {
            
            if (record.type == CourseTypeGroup) {
                
                groupCount++;
                
            }else if (record.type == CourseTypePrivate){
                
                privareCount++;
                
            }else if (record.type == CourseTypeCheckin){
                checkInCount++;
            }
            
        }
        
        [self.recordArray addObject:@{@"date":dict,@"data":dataArray,@"group_count":[NSNumber numberWithInteger:groupCount],@"private_count":[NSNumber numberWithInteger:privareCount],@"checkin_count":[NSNumber numberWithInteger:checkInCount]}];
        
    }
    
}

-(void)createFollowDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FollowRecord *record = [[FollowRecord alloc]init];
        
        if ([obj[@"type"] isEqualToString:@"record"]) {
            
            record.type = FollowRecordTypeText;
            
            record.content = obj[@"content"];
            
            CGSize size = [obj[@"content"] boundingRectWithSize:CGSizeMake(Width320(222), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
            
            record.size = size;
            
        }else if([obj[@"type"] isEqualToString:@"attachment"])
        {
            
            record.type = FollowRecordTypeImage;
            
            record.imageURL = [NSURL URLWithString:obj[@"link"]];
            
        }
        
        if (obj[@"created_at"]) {
            
            record.time = [[obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:16];
                              
        }
        
        record.staff.name = obj[@"created_by"][@"username"];
        
        record.staff.iconUrl = [NSURL URLWithString:obj[@"created_by"][@"avatar"]];
        
        record.staff.staffId = [obj[@"created_by"][@"id"] integerValue];
        
        record.recordId = [obj[@"id"] integerValue];
        
        [self.followArray addObject:record];
        
    }];
    
}

-(void)createStudent:(Student *)stu result:(void (^)(BOOL, NSString *,Student*))result
{
    
    self.addCallBack = result;
    
    Gym *gym = ((AppDelegate *)[UIApplication sharedApplication].delegate).gym;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:gym.gymId] forKey:@"id"];
        
        [para setParameter:gym.type forKey:@"model"];
        
    }else if (AppGym.shopId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else
    {
        
        NSString *shops = @"";
        
        for (Gym *tempGym in stu.gyms) {
            
            shops = [shops stringByAppendingString:[NSString stringWithInteger:tempGym.shopId]];
            
            if ([stu.gyms indexOfObject:tempGym]<stu.gyms.count-1) {
                
                shops = [shops stringByAppendingString:@","];
                
            }
            
        }
        
        [para setParameter:shops forKey:@"shops"];
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [para setParameter:stu.name forKey:@"username"];
    
    [para setParameter:stu.birth forKey:@"date_of_birth"];
    
    [para setParameter:stu.address forKey:@"address"];
    
    [para setParameter:stu.photo.absoluteString forKey:@"checkin_avatar"];
    
    [para setParameter:stu.phone forKey:@"phone"];
    
    [para setParameter:stu.country.countryNo forKey:@"area_code"];
    
    [para setParameter:stu.sex == SexTypeMan?@"0":@"1" forKey:@"gender"];
    
    [para setParameter:stu.recommend_by_id forKey:@"recommend_by_id"];
    [para setParameter:stu.origin forKey:@"origin"];
    [para setParameter:stu.remarks forKey:@"remarks"];

    
    if (stu.sellers.count) {
        
        NSString *sellerIdStr = @"";
        
        for(NSInteger i = 0;i<stu.sellers.count;i++){
            
            Seller *seller = stu.sellers[i];
            
            sellerIdStr = [sellerIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)seller.sellerId]];
            
            if (i<stu.sellers.count-1) {
                
                sellerIdStr = [sellerIdStr stringByAppendingString:@","];
                
            }
            
        }
        
        [para setParameter:sellerIdStr forKey:@"seller_ids"];
        
    }
    
    if (stu.coaches.count) {
        
        NSString *coachIdStr = @"";
        
        for(NSInteger i = 0;i<stu.coaches.count;i++){
            
            Coach *coach = stu.coaches[i];
            
            coachIdStr = [coachIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)coach.coachId]];
            
            if (i<stu.coaches.count-1) {
                
                coachIdStr = [coachIdStr stringByAppendingString:@","];
                
            }
            
        }
        
        [para setParameter:coachIdStr forKey:@"coach_ids"];
        
    }
    
    DebugLogYF(@"%@",para.data);

    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kCreateAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
//            NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//            
//            NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"studentList.txt"];
//            
//            NSData *data = [NSData dataWithContentsOfFile:newFielPath];
            
//            = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
            
            NSDictionary *dic = [YFListCache cacheOnDocumentDicForKey:YFCacheKey];
            
            NSMutableDictionary *dict = [responseDic[@"data"][@"user"] mutableCopy];
            
            if (gym) {
                
                [dict setValue:@[@{@"id":[NSNumber numberWithInteger:gym.shopId],@"name":gym.name}] forKey:@"shops"];
                
            }else
            {
                
                NSMutableArray *shopArray = [NSMutableArray array];
                
                for (Gym *tempGym in stu.gyms) {
                    
                    [shopArray addObject:@{@"id":[NSNumber numberWithInteger:tempGym.shopId],@"name":tempGym.name.length?tempGym.name:@""}];
                    
                }
                
                [dict setValue:shopArray forKey:@"shops"];
                
            }

            [YFListCache setStudentDic:dict toDic:dic];
        
                        
//            NSError*error =nil;
//            
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
//            
//            NSString *content = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            
//            content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            
//            [content writeToFile:newFielPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            stu.stuId = [responseDic[@"data"][@"user"][@"id"] integerValue];
            
            stu.avatar = [NSURL URLWithString:responseDic[@"data"][@"user"][@"avatar"]];
            
            if (self.addCallBack) {
                
                self.addCallBack(YES,nil,stu);
                
                self.addCallBack = nil;
                
            }
            
        }else
        {
            
            if (self.addCallBack) {
                
                self.addCallBack(NO,responseDic[@"msg"],nil);
                
                self.addCallBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.addCallBack) {
            
            self.addCallBack(NO,error,nil);
            
            self.addCallBack = nil;
            
        }
        
    }];
    
}

-(void)changeStudent:(Student *)stu result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
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
    
    [para setParameter:stu.name forKey:@"username"];
    
    [para setParameter:stu.birth forKey:@"date_of_birth"];
    
    [para setParameter:stu.address forKey:@"address"];
    
    [para setParameter:stu.avatar.absoluteString forKey:@"avatar"];
    
    [para setParameter:stu.phone forKey:@"phone"];
    
    [para setParameter:stu.sex == SexTypeMan?@"0":@"1" forKey:@"gender"];
    
    [para setParameter:stu.origin forKey:@"origin"];
    [para setParameter:stu.recommend_by_id forKey:@"recommend_by_id"];
    [para setParameter:stu.remarks forKey:@"remarks"];

    
    DebugLogYF(@"%@",para.data);
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:kStuAPI,StaffId,(long)stu.stuId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
//            NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//            
//            NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"studentList.txt"];
//            
//            NSData *data = [NSData dataWithContentsOfFile:newFielPath];
//            
//            NSMutableArray *array = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
            
            NSDictionary *dic = [YFListCache cacheOnDocumentDicForKey:YFCacheKey];

            
            NSMutableArray *array = [YFListCache  cacheOnDocumentStudentArrayFromDic:dic];
            
            NSMutableArray *gymArray = [NSMutableArray array];
            
            for (Gym *gym in stu.gyms) {
                
                [gymArray addObject:@{@"id":[NSNumber numberWithInteger:gym.shopId],@"name":gym.name}];
                
            }
            
            NSDictionary *stuDict = @{@"username":stu.name,@"gender":stu.sex == SexTypeMan?@"0":@"1",@"id":[NSNumber numberWithInteger:stu.stuId],@"avatar":stu.avatar.absoluteString,@"phone":stu.phone,@"shops":gymArray,@"head":stu.head,@"status":[NSString stringWithFormat:@"%@",@(stu.type)],@"area_code":stu.country.countryNo,@"join_at":stu.createDate,@"checkin_avatar":stu.photo.absoluteString};
            
            for (NSDictionary *dict in array) {
                
                if ([dict[@"id"] integerValue] == stu.stuId) {
                    
                    [array replaceObjectAtIndex:[array indexOfObject:dict] withObject:stuDict];
                    
                    break;
                    
                }
                
            }
            
            [YFListCache setStudentArray:array toDic:dic];
            
//            NSError*error =nil;
//            
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
//            
//            NSString *content = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            
//            content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
//            [content writeToFile:newFielPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
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

-(void)changeSellers:(NSArray *)sellers withGym:(Gym *)gym withStudent:(Student *)stu result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
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

    if (sellers.count) {
        
        NSString *sellerIdStr = @"";
        
        for(NSInteger i = 0;i<sellers.count;i++){
            
            Seller *seller = sellers[i];
            
            sellerIdStr = [sellerIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)seller.sellerId]];
            
            if (i<sellers.count-1) {
                
                sellerIdStr = [sellerIdStr stringByAppendingString:@","];
                
            }
            
        }
        
        [para setParameter:sellerIdStr forKey:@"seller_ids"];
        
    }else{
        
        [para setParameter:@"" forKey:@"seller_ids"];
        
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:kStuAPI,StaffId,(long)stu.stuId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
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

-(void)deleteStudent:(Student *)stu withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
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

    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:kStuAPI,StaffId,(long)stu.stuId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
//            NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
            
//            NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"studentList.txt"];
//            
//            NSData *data = [NSData dataWithContentsOfFile:newFielPath];
//            
//            NSMutableArray *array = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
            
            NSDictionary *dic = [YFListCache cacheOnDocumentDicForKey:YFCacheKey];
            
            
            NSMutableArray *array = [YFListCache  cacheOnDocumentStudentArrayFromDic:dic];

            
            
            for (NSDictionary *dict in array) {
                
                if ([dict[@"id"] integerValue] == stu.stuId) {
                    
                    if (AppGym) {
                        
                        NSMutableArray *gymArray = [stu.gyms mutableCopy];
                        
                        for (Gym *stuGym in gymArray) {
                            
                            if (stuGym.shopId == AppGym.shopId) {
                                
                                [gymArray removeObject:stuGym];
                                
                                break;
                                
                            }
                            
                        }
                        
                        stu.gyms = [gymArray copy];
                        
                    }else
                    {
                        
                        [array removeObject:dict];
                        
                    }
                    
                    break;
                    
                }
                
            }
            [YFListCache setStudentArray:array toDic:dic];

            
//            NSError*error =nil;
//            
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
//            
//            NSString *content = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            
//            content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            
//            [content writeToFile:newFielPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
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

-(void)deleteStudent:(Student *)stu withGyms:(NSArray *)gyms result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    NSString *shopIds = @"";
    
    for (Gym *gym in gyms) {
        
        shopIds = [shopIds stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)gym.shopId]];
        
        if ([gyms indexOfObject:gym]<gyms.count-1) {
            
            shopIds = [shopIds stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:shopIds forKey:@"shop_ids"];
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:kStuAPI,StaffId,(long)stu.stuId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
//            NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//            
//            NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"studentList.txt"];
//            
//            NSData *data = [NSData dataWithContentsOfFile:newFielPath];
//            
//            NSMutableArray *array = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
            
            NSDictionary *dic = [YFListCache cacheOnDocumentDicForKey:YFCacheKey];
            
            
            NSMutableArray *array = [YFListCache  cacheOnDocumentStudentArrayFromDic:dic];
            
            for (NSDictionary *dict in array) {
                
                if ([dict[@"id"] integerValue] == stu.stuId) {
                    
                    NSMutableArray *gymArray = [stu.gyms mutableCopy];
                    
                    for (Gym *gym in gyms) {
                        
                        for (Gym *stuGym in gymArray) {
                            
                            if (stuGym.shopId == gym.shopId) {
                                
                                [gymArray removeObject:stuGym];
                                
                                break;
                                
                            }
                            
                        }
                        
                    }
                    
                    stu.gyms = [gymArray copy];
                    
                    break;
                    
                }
                
            }
            
//            NSError*error =nil;
//            
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
//            
//            NSString *content = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            
//            content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            
//            [content writeToFile:newFielPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            [YFListCache setStudentArray:array toDic:dic];

            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
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

-(void)uploadFollow:(FollowRecord *)follow
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (follow.type == FollowRecordTypeImage) {
        
        [para setParameter:follow.imageURL.absoluteString forKey:@"attachment"];
        
    }else
    {
        
        [para setParameter:follow.content forKey:@"content"];
        
    }
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kFollowAPI,StaffId,(long)self.student.stuId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self requestFollowDataWithStudent:self.student];
            
            // 跟进 记录改变
            [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddNewFollowingIdtifierYF object:nil];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
    }];
    
}

@end
