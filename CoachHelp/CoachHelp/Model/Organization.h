//
//  Organization.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Organization : NSObject

@property(nonatomic,assign)NSInteger ognId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *contact;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)BOOL ishot;

@property(nonatomic,assign)BOOL isCertificate;

@end
