//
//  SpecCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardKind.h"

#import "Spec.h"

@interface SpecCell : UICollectionViewCell

@property(nonatomic,assign)SpecType type;

@property(nonatomic,assign)CardKindType cardKindType;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *cost;

@property(nonatomic,assign)NSInteger validTime;

@property(nonatomic,assign)BOOL checkValid;

@property(nonatomic,assign)BOOL onlyStaffCanSee;

@end
