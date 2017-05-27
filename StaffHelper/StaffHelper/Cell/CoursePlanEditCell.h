//
//  CoursePlanEditCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIButton+Category.h"

@interface CoursePlanEditCell : UITableViewCell

@property(nonatomic,assign)BOOL canEdit;

@property(nonatomic,assign)BOOL isChoosed;

@property(nonatomic,copy)NSString *day;

@property(nonatomic,copy)NSString *week;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,strong)NSIndexPath *indexPath;

@end
