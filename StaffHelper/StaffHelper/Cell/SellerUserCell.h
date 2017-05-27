//
//  SellerUserCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerUserCell : UITableViewCell

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,assign)UserType userType;

@property(nonatomic,assign)SellerType sellerType;


@property(nonatomic,copy)NSString *sellers;

@property(nonatomic,copy)NSString *coaches;

@property(nonatomic,assign)BOOL noLine;

@end
