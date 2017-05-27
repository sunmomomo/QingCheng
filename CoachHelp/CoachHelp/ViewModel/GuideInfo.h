//
//  GuideInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuideInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

+(void)uploadResult:(void(^)(BOOL success,NSString *error))result;

@end
