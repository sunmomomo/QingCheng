//
//  ChestCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChestCell : UICollectionViewCell

@property(nonatomic,assign)BOOL canSelected;

@property(nonatomic,assign)BOOL haveRightLine;

@property(nonatomic,assign)BOOL haveBottomLine;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,assign)BOOL longTermUse;

@property(nonatomic,assign)BOOL isEmpty;

@end
