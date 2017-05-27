//
//  YFTBBaseModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFBaseCell.h"
#import "YFBaseCModel.h"
#import "YFBaseVC.h"

typedef NSMutableArray *(^DataArrayBLock)() ;

typedef NSArray *(^DataoArrayBLock)() ;


@interface YFTBBaseModel : NSObject

//@property(nonatomic,weak)NSMutableArray *dataArray;
@property(nonatomic, copy)DataArrayBLock dataArray;

@property(nonatomic, weak)YFBaseVC *currentVC;
@property(nonatomic, weak)UIView *superViewOfTable;


+(instancetype)tableDelegeteWithArray:(DataArrayBLock)array currentVC:(YFBaseVC *)currentVC;

+(instancetype)tableDelegeteWithArray:(DataArrayBLock)array superViewOfTable:(UIView *)superView;


-(UITableViewCell *)defaultCell:(UITableView *)tableView;


@end
