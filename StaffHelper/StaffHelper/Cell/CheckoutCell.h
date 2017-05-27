//
//  CheckoutCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckoutCellDelegate;

@interface CheckoutCell : UITableViewCell

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,copy)NSString *remain;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *chestName;

@property(nonatomic,copy)NSString *checkinTime;

@property(nonatomic,assign)BOOL noIgnore;

@property(nonatomic,weak)id<CheckoutCellDelegate> delegate;

@end

@protocol CheckoutCellDelegate <NSObject>

-(void)checkoutCellCheckout:(CheckoutCell*)cell;

-(void)uploadPhotoWithCheckoutCell:(CheckoutCell *)cell;

@optional

-(void)ignoreCheckoutWithCheckoutCell:(CheckoutCell*)cell;

@end
