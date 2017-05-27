//
//  CardRestCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardRest.h"

@protocol CardRestCellDelegate <NSObject>

-(void)deleteRest:(UIButton*)btn;
-(void)backOfLeaveAction:(UIButton*)btn;

@end

@interface CardRestCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,copy)NSString *remark;

@property(nonatomic,assign)NSInteger receive;

@property(nonatomic,copy)NSString *operateTime;

@property(nonatomic,copy)NSString *staffName;

@property(nonatomic,assign)CardRestStatus restStatus;

@property(nonatomic,assign)id<CardRestCellDelegate> delegate;

@property(nonatomic, strong)NSString *stateStr;

@property(nonatomic, assign)CGFloat remarkHeight;


- (CGFloat)getCellHeight;
@end
