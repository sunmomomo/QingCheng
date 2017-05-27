//
//  IntegralBasicSettingCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntegralBasicSettingCellDelegate ;

@interface IntegralBasicSettingCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,assign)BOOL noLine;

@property(nonatomic,weak)id<IntegralBasicSettingCellDelegate> delegate;

@end

@protocol IntegralBasicSettingCellDelegate <NSObject>

-(void)deleteCell:(IntegralBasicSettingCell*)cell;
                   
@end
