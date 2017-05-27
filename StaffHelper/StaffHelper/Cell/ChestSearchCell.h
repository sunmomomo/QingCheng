//
//  ChestSearchCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChestSearchCell : UICollectionViewCell

@property(nonatomic,assign)BOOL canSelected;

@property(nonatomic,assign)BOOL haveRightLine;

@property(nonatomic,assign)BOOL haveBottomLine;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL choosed;

@end
