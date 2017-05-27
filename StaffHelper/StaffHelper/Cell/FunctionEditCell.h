//
//  FunctionEditCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FunctionEditCellTypeAdd,
    FunctionEditCellTypeDelete,
    FunctionEditCellTypeChoosed,
    FunctionEditCellTypeNone,
} FunctionEditCellType;

@protocol FunctionEditCellDelegate;

@interface FunctionEditCell : UICollectionViewCell

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *identifier;

@property(nonatomic,assign)FunctionEditCellType type;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,weak)id<FunctionEditCellDelegate>delegate;

@property(nonatomic,assign)BOOL noBottomLine;

@end

@protocol FunctionEditCellDelegate <NSObject>

@optional

-(void)addFunctionWithIndexPath:(NSIndexPath*)indexPath;

-(void)deleteFunctionWithIndexPath:(NSIndexPath*)indexPath;

@end
