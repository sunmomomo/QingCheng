//
//  CardKindView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardKind.h"

@interface CardKindView : UIImageView

@property(nonatomic,strong)UIColor *cardBackColor;

@property(nonatomic,assign)CardKindType cardKindType;

@property(nonatomic,copy)NSString *cardKindName;

@property(nonatomic,assign)NSInteger cardId;

@property(nonatomic,copy)NSString *astrict;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic,assign)CardKindState state;

@end
