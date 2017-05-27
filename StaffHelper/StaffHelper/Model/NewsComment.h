//
//  NewsComment.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/4.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "News.h"

@interface NewsComment : NSObject

@property(nonatomic,copy)NSString *username;

@property(nonatomic,copy)NSString *toUsername;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *comment;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,strong)News *news;

@end
