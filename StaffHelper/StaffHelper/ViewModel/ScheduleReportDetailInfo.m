    //
//  ScheduleReportDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/5/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ScheduleReportDetailInfo.h"

#define API @"/api/staffs/%ld/reports/schedules/%ld/"

@implementation ScheduleReportDetailInfo

-(void)requestWithReport:(OrderReport *)report result:(RequestCallBack)result
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)report.reportId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            __block BOOL allTimeCard = YES;
            
            NSMutableArray *orders = [NSMutableArray array];
            
            [responseDic[@"data"][@"orders"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SecheduleReportDetailModel *model = [[SecheduleReportDetailModel alloc]init];
                
                model.user = [[User alloc]init];
                
                model.card = [[Card alloc]init];
                
                model.time = [obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                
                if (model.time.length>17) {
                    
                    model.time = [model.time substringToIndex:17];
                    
                }
                
                model.user.username = obj[@"user"][@"username"];
                
                model.user.iconURL = [NSURL URLWithString:obj[@"user"][@"avatar"]];
                
                model.user.phone = obj[@"user"][@"phone"];
                
                model.user.sex = [obj[@"user"][@"gender"] integerValue]==0?SexTypeMan:SexTypeWoman;
                
                model.status = [obj[@"status"] integerValue];
                
                if ([obj[@"channel"] isEqualToString:@"CARD"]) {
                    
                    model.type = ScheduleReportDetailPayTypeCard;
                    
                }else if ([obj[@"channel"] isEqualToString:@"ONLINE"]){
                    
                    model.type = ScheduleReportDetailPayTypeOnline;
                    
                }else if ([obj[@"channel"] isEqualToString:@"WEIXIN"]){
                    
                    model.type = ScheduleReportDetailPayTypeWechat;
                    
                }else if ([obj[@"channel"] isEqualToString:@"WEIXIN_QRCODE"]){
                    
                    model.type = ScheduleReportDetailPayTypeWechatCode;
                    
                }else if ([obj[@"channel"] isEqualToString:@"FREE"]){
                    
                    model.type = ScheduleReportDetailPayTypeNopay;
                    
                }
                
                if (model.type != ScheduleReportDetailPayTypeCard) {
                    
                    allTimeCard = NO;
                    
                }
                
                if (model.type == ScheduleReportDetailPayTypeCard) {
                    
                    model.card.cardKind.cardKindName = obj[@"card"][@"name"];
                    
                    model.card.cardKind.type = [obj[@"card"][@"card_type"] integerValue];
                    
                    model.card.cardNumber = obj[@"card"][@"card_no"];
                    
                    if (model.card.cardKind.type != CardKindTypeTime) {
                        
                        allTimeCard = NO;
                        
                    }
                    
                }
                
                model.count = [obj[@"count"] integerValue];
                
                model.price = [obj[@"total_price"] floatValue];
                
                model.realPrice = [obj[@"total_real_price"] floatValue];
                
                [orders addObject:model];
                
            }];
            
            self.orders = orders;
            
            self.course = [[Course alloc]init];
            
            NSDictionary *courseDict = responseDic[@"data"][@"schedule"];
            
            self.course.count = [courseDict[@"count"] integerValue];
            
            self.course.name = courseDict[@"course"][@"name"];
            
            self.course.start = [courseDict[@"start"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
            
            self.course.end = courseDict[@"end"];
            
            self.course.courseId = [courseDict[@"course"][@"id"] integerValue];
            
            self.course.imgUrl = [NSURL URLWithString:courseDict[@"course"][@"photo"]];
            
            self.course.type = [courseDict[@"course"][@"is_private"] boolValue]?CourseTypePrivate:CourseTypeGroup;
            
            self.serviceCount = [courseDict[@"count"] integerValue];
            
            self.price = [courseDict[@"total_account"] floatValue];
            
            self.times = [courseDict[@"total_times"] integerValue];
            
            self.realPrice = [courseDict[@"total_real_price"] floatValue];
            
            self.coach = [[Coach alloc]init];
            
            self.coach.coachId = [courseDict[@"teacher"][@"id"] integerValue];
            
            self.coach.name = courseDict[@"teacher"][@"username"];
            
            self.coach.iconUrl = [NSURL URLWithString:courseDict[@"teacher"][@"avatar"]];
            
            self.coach.rateScore = [courseDict[@"teacher"][@"score"]floatValue];
            
            self.gym = [[Gym alloc]init];
            
            self.gym.name = courseDict[@"shop"][@"name"];
            
            self.gym.shopId = [courseDict[@"shop"][@"id"] integerValue];
            
            self.gym.address = courseDict[@"shop"][@"address"];
            
            self.allTimeCard = allTimeCard;
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO, responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO, error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

@end

@implementation SecheduleReportDetailModel

@end
