//
//  CardKindCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardKindView.h"

#import "CardKind.h"

@interface CardKindCell : UITableViewCell

@property(nonatomic,strong)UIColor *backColor;

@property(nonatomic,assign)CardKindType cardKindType;

@property(nonatomic,copy)NSString *cardKindName;

@property(nonatomic,assign)NSInteger cardId;

@property(nonatomic,copy)NSString *astrict;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic,assign)CardKindState state;

@end
