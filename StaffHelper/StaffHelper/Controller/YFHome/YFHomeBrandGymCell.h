//
//  YFHomeBrandGymCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFHomeBrandGymCell : UICollectionViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSURL *imageUrl;

@property(nonatomic,assign)BOOL havePower;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,assign)BOOL pro;

@end
