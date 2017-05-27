//
//  MOSwitchCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  MOSwitchCellDelegate;

@interface MOSwitchCell : UIView

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,assign)BOOL on;

@property(nonatomic,assign)BOOL noLine;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)BOOL cardStopped;

@property(nonatomic,assign)id<MOSwitchCellDelegate> delegate;

@end

@protocol MOSwitchCellDelegate <NSObject>

@optional

-(void)switchCellSwitchChanged:(MOSwitchCell*)cell;

@end
