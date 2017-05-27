//
//  FunctionCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FunctionCellTypeFree,
    FunctionCellTypePro,
    FunctionCellTypeNone,
} FunctionCellType;

@interface FunctionCell : UICollectionViewCell

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *identifier;

@property(nonatomic,assign)FunctionCellType type;

@end
