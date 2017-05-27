//
//  YFCollectionViewSellerCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCollectionViewSellerCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UIImageView *chooseImg;

@property(nonatomic, assign)BOOL isSelected;

@end
