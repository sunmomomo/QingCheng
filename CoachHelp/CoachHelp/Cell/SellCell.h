//
//  SellCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL sectionFirst;

@property(nonatomic,copy)NSString *month;

@property(nonatomic,copy)NSString *day;

@property(nonatomic,copy)NSString *card;

@property(nonatomic,assign)float cost;

@end
