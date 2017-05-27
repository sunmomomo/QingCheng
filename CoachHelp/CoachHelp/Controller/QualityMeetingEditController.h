//
//  QualityMeetingEditController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/25.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Quality.h"

@interface QualityMeetingEditController : MOViewController

@property(nonatomic,strong)Quality *quality;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,copy)void(^editFinish)(Quality *quality);

@end
