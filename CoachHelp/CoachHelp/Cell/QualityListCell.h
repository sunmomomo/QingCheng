//
//  QualityListCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/3/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QualityListCell : UITableViewCell

@property(nonatomic,assign)BOOL isVerified;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSString *validTime;

@property(nonatomic,assign)BOOL isHide;

@end
