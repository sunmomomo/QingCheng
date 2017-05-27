
//
//  Message.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/18.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "Message.h"

#import "YFDateService.h"

@implementation Message

- (instancetype)initWithMessageJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        self.title = json[@"title"];
        
        self.url = [NSURL URLWithString:json[@"url"]];
        
        self.time = [json[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        
        self.imgUrl = [NSURL URLWithString:json[@"photo"]];
        
        self.msgId = [json[@"id"] integerValue];
        
        self.readed = [json[@"is_read"] boolValue];
        
        self.content = json[@"description"];
        
        self.type = [json[@"type"] integerValue];
        
        self.gym = [[Gym alloc]init];
        
        self.gym.brand.brandId = [json[@"brand_id"] integerValue];
        
        self.gym.shopId = [json[@"shop_id"] integerValue];
        
        self.gym.name = json[@"sender"];
        
        self.cardId = [json[@"card_id"] guardStringYF];
        
        if (json[@"system_end"]) {
            self.gym.systemEnd = json[@"system_end"];
            
            NSDateFormatter *dateFormatter = [YFDateService dateformatter];
            
            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            
            NSInteger remainDays = [[dateFormatter dateFromString:self.gym.systemEnd] timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]]/86400;
            self.gym.pro = remainDays>=0;
            
        }
        
    }
    return self;
}

- (BOOL)canGoToNotWebVC
{
    if ([self.url.absoluteString rangeOfString:@"/users/checkin/confirm/"].length||[self.url.absoluteString rangeOfString:@"/users/checkout/confirm/"].length ||[self.url.absoluteString rangeOfString:@"/users/checkin/detail/"].length||[self.url.absoluteString rangeOfString:@"/users/checkout/details/"].length || self.type == MessageTypeChangeSeller || self.type == MessageTypeWithoutSeller || self.type == MessageTypeCardNoSufficient || self.type == MessageTypeChangeCoach) {

        return YES;
    }
    return NO;
}


@end
