//
//  CheckinCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoursePlanBatch.h"

@protocol CheckinCellDelegate;

@interface CheckinCell : UITableViewCell

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,copy)NSString *chest;

@property(nonatomic,assign)CardKindType cardType;

@property(nonatomic,copy)NSString *remain;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,strong)NSArray *courseBatches;

@property(nonatomic,assign)BOOL haveChest;

@property(nonatomic,weak)id<CheckinCellDelegate> delegate;

@end


@protocol CheckinCellDelegate <NSObject>

-(void)chestChooseWithCheckinCell:(CheckinCell*)cell;

-(void)checkinWithCheckinCell:(CheckinCell *)cell;

-(void)ignoreCheckinWithCheckinCell:(CheckinCell *)cell;

-(void)uploadPhotoWithCheckinCell:(CheckinCell *)cell;

@end
