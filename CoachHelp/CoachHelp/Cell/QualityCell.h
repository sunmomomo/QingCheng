//
//  QualityCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QualityCellDelegate;

@interface QualityCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *ogn;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *validTime;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)BOOL isVerified;

@property(nonatomic,assign)id<QualityCellDelegate> delegate;

@end

@protocol QualityCellDelegate <NSObject>

-(void)cellClickImg:(QualityCell*)cell;

@end
