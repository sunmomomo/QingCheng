//
//  CardCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Card.h"

@interface CardCell : UITableViewCell

@property(nonatomic,strong)Card *card;

-(CGFloat)getHeight;

@end
