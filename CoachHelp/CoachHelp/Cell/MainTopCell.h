//
//  MainTitleCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/16.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTopCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *img;

@property(nonatomic,copy)NSString *selectedImg;

@property(nonatomic,copy)NSURL *imgUrl;

-(void)selected;

@end
