//
//  GymBrandCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Gym.h"

@protocol GymBrandCellDelegate <NSObject>

-(void)gymBrandCellDidSelectGym:(Gym*)gym;

-(void)manageBrand:(Brand*)brand;

@end

@interface GymBrandCell : UITableViewCell

@property(nonatomic,strong)Brand *brand;

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic,weak)id<GymBrandCellDelegate>delegate;

@end
