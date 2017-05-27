//
//  StudentDeleteCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StudentDeleteCellDelegate <NSObject>

-(void)studentDelete:(UIButton*)button;

@end

@interface StudentDeleteCell : UITableViewCell

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,assign)id<StudentDeleteCellDelegate> delegate;

@end
