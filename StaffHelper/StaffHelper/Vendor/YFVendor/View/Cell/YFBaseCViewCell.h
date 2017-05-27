//
//  YFBaseCViewCell.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFBaseCViewCell : UICollectionViewCell

@property(nonatomic, copy)void(^deleteBlock)(id);


@end
