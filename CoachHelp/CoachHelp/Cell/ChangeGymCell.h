//
//  ChangeGymCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeGymCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,assign)BOOL isAll;

@property(nonatomic,assign)BOOL isChoosed;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)BOOL havePower;

@end
