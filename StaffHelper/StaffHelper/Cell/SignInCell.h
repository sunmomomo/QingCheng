//
//  SignInCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInCell : UITableViewCell

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *staffName;

@property(nonatomic,assign)BOOL spread;

@end
