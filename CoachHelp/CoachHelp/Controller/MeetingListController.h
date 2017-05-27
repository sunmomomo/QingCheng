//
//  MeetingListController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "MeetingsListInfo.h"

@interface MeetingListController : MOViewController

@property(nonatomic,strong)MeetingsListInfo *meetingsInfo;

-(void)createData;

-(void)reloadData;

@end
