//
//  StudentChooseCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentChooseCell : UITableViewCell

@property(nonatomic,assign)BOOL select;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *iconURL;

@end
