//
//  MeetingsListInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Meeting.h"

@interface MeetingsListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *meetings;

@property(nonatomic,copy)void(^request)(BOOL success);

-(void)requestData;

@end
