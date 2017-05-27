//
//  RenewHistoryCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RenewHistory.h"

@interface RenewHistoryCell : UITableViewCell

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *validTime;

@property(nonatomic,copy)NSString *staffName;

@property(nonatomic,copy)NSString *realPrice;

@property(nonatomic,assign)RenewHistoryType historyType;

@property(nonatomic,assign)BOOL renewSuccess;

@end
