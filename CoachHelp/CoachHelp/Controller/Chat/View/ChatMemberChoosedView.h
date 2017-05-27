//
//  ChatMemberChoosedView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/31.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MembersChanged)(NSMutableArray *array);

@interface ChatMemberChoosedView : UIView

@property(nonatomic,strong)NSMutableArray *members;

-(void)show;

-(void)setMembersChanged:(MembersChanged)block;

@end
