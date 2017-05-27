//
//  WorkCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Work.h"

@interface WorkCell : UITableViewCell

@property(nonatomic,strong,setter=setWork:)Work *work;

@property(nonatomic,assign)CGFloat cellHeight;

@end
