//
//  MainSecCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/16.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainSecCell : UITableViewCell

@property(nonatomic,copy,setter=setTitle:)NSString *title;

@property(nonatomic,assign)NSInteger num;

-(void)selected;

@end
