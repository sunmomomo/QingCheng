//
//  CardKindSpecCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardKind.h"

@interface CardKindSpecCell : UICollectionViewCell

@property(nonatomic,copy)NSString *charge;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,assign)NSInteger validDays;

@property(nonatomic,copy)NSString *types;

@property(nonatomic,assign)BOOL checkValid;

@property(nonatomic,assign)CardKindType cardKindType;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,assign)BOOL onlyStaffCanSee;

@end
