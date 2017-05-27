//
//  CourseBatchCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CourseBatchCellDelegate <NSObject>

-(void)cellEditClick:(UIButton*)btn;

@end

@interface CourseBatchCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,weak)id<CourseBatchCellDelegate> delegate;

@end
