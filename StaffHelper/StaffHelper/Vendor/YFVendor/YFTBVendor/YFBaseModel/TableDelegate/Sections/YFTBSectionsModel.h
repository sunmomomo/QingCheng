//
//  YFTBSectionsModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFTBSectionsModel : NSObject

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)UIView *headerView;
@property(nonatomic, assign)CGFloat headerHeight;


@property(nonatomic, strong)UIView *footerView;
@property(nonatomic, assign)CGFloat footerHeight;

@property(nonatomic, assign)NSUInteger sectionCount;

@property(nonatomic,strong)NSIndexPath *indexPath;


@property(nonatomic, weak)UITableView *weakTableView;

@end
