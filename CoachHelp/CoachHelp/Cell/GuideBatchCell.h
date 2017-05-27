//
//  GuideBatchCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideBatchCellDelegate;

@interface GuideBatchCell : UITableViewCell

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *weeks;

@property(nonatomic,assign)id<GuideBatchCellDelegate> delegate;

@end

@protocol GuideBatchCellDelegate <NSObject>

-(void)batchCellDelete:(GuideBatchCell*)cell;

@end