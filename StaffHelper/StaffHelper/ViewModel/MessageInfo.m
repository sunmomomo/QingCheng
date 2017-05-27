//
//  MessageInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MessageInfo.h"

#define API @"/api/v2/notifications/"

#define ReadAPI @"/api/notifications/clear/"

#define ReadAllAPI @"/api/v2/notifications/"

@interface MessageInfo ()

{
    
    NSInteger _currentPage;
    
    NSInteger _totalPages;
    
}

@end

@implementation MessageInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.messages = [NSMutableArray array];
        
        _currentPage = 0;
        
        _totalPages = 1;
        
    }
    return self;
}

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    if(_currentPage >= _totalPages){
        
        if (self.callBack) {
            self.callBack(YES,@"无更多数据");
        }
        
        return;
        
    }
    
    if (!StaffId) {
        
        if (self.callBack) {
            
            self.callBack(NO,nil);
            
        }
        
        return;
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithInteger:_currentPage+1] forKey:@"page"];
    
    [para setParameter:@"-created_at" forKey:@"order_by"];
    
    switch (self.type) {
            
        case MessageInfoTypeGym:
            
            [para setParameter:@"11,12,13,15" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeSystem:
            
            [para setParameter:@"20002" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeStudy:
            
            [para setParameter:@"10001,10002,10003,10004,10005,10006,10007,10008" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeCheckin:
            
            [para setParameter:@"1,2,8,9" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeMatch:
            
            [para setParameter:@"20004" forKey:@"type__in"];
            
            break;
            
        default:
            break;
    }
        
    [MOAFHelp AFGetHost:ROOT bindPath:API param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.unReadCount = [responseDic[@"data"][@"unread_count"] integerValue];
            
            _currentPage = [responseDic[@"data"][@"current_page"] integerValue];
            
            _totalPages = [responseDic[@"data"][@"pages"] integerValue];
            
            [responseDic[@"data"][@"notifications"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Message *msg = [[Message alloc]init];
                
                msg.title = obj[@"title"];
                
                msg.type = [obj[@"type"] integerValue];
                
                msg.url = [NSURL URLWithString:obj[@"url"]];
                
                msg.time = [obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                
                if ([obj[@"photo"]rangeOfString:@"!"].length) {
                    
                    msg.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                    
                }else{
                    
                    msg.imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@!120x120",obj[@"photo"]]];
                    
                }
                
                msg.msgId = [obj[@"id"] integerValue];
                
                msg.readed = [obj[@"is_read"] boolValue];
                
                msg.content = obj[@"description"];

                msg.gym = [[Gym alloc]init];
                
                msg.gym.brand.brandId = [obj[@"brand_id"] integerValue];
                
                msg.gym.shopId = [obj[@"shop_id"] integerValue];
                
                msg.cardId = obj[@"card_id"];
                
                msg.gym.name = obj[@"sender"];
                
                [self.messages addObject:msg];
                
            }];
            
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

-(void)readAllMessageResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    switch (self.type) {
            
        case MessageInfoTypeGym:
            
            [para setParameter:@"11,12,13,15" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeSystem:
            
            [para setParameter:@"20002" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeStudy:
            
            [para setParameter:@"10001,10002,10003,10004,10005,10006,10007,10008" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeCheckin:
            
            [para setParameter:@"1,2,8,9" forKey:@"type__in"];
            
            break;
            
        case MessageInfoTypeMatch:
            
            [para setParameter:@"20004" forKey:@"type__in"];
            
            break;
        
        case MessageInfoTypeReply:
            
            [para setParameter:@"20003" forKey:@"type__in"];
            
        default:
            break;
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:ReadAllAPI putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
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

-(void)readMessage:(Message *)message result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:StaffId forKey:@"staff_id"];
    
    [para setInteger:message.msgId forKey:@"id"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:@"%@",ReadAPI] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
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

-(void)readMessages:(NSArray *)messages result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:StaffId forKey:@"staff_id"];
    
    [para setParameter:messages forKey:@"id__in"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:@"%@",ReadAPI] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
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

@end
