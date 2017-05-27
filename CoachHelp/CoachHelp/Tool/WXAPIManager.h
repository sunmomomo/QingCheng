//
//  WXAPIManager.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/2/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WXApi.h"

#import "WXUtil.h"

#import "ApiXml.h"

typedef enum : NSUInteger {
    ShareTypeFreind,
    ShareTypeMoment,
    ShareTypeCopyLink,
} ShareType;

@protocol WXApiManagerDelegate <NSObject>

@optional

-(void)payResult:(NSInteger)result;

-(void)shareResult:(NSInteger)result andType:(ShareType)type;

@end

@interface WXAPIManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

@property(nonatomic,assign)ShareType type;

-(void)payWithParameters:(NSDictionary *)para;

-(void)shareWithParameters:(NSDictionary *)para andScene:(int)scene;
+(instancetype)sharedManager;

@end
