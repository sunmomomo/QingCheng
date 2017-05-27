//
//  YFTBBaseModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBBaseModel.h"
#import "YFAppConfig.h"

@implementation YFTBBaseModel

+(instancetype)tableDelegeteWithArray:(DataArrayBLock)array currentVC:(YFBaseVC *)currentVC
{
    YFTBBaseModel *tableDelegate = [[[self class] alloc] init];
    tableDelegate.dataArray = array;
    if (tableDelegate.dataArray) {
        DebugLogYF(@"******");
    }else
    {
        DebugLogYF(@"&&&&&&&&&&&&");
    }
    tableDelegate.currentVC = currentVC;
    return tableDelegate;
}

+(instancetype)tableDelegeteWithArray:(DataArrayBLock)array superViewOfTable:(UIView *)superView
{
    YFTBBaseModel *tableDelegate = [[[self class] alloc] init];
    tableDelegate.dataArray = array;
    tableDelegate.superViewOfTable = superView;
    return tableDelegate;
}


-(UITableViewCell *)defaultCell:(UITableView*)tableView
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

//-(YFBaseCell *)cellFromBaseCellModelFY:(YFBaseCModel *)cellModel
//{
//    YFBaseCell *cell;
//    
//    DebugLogYF(@"%@%@",cellModel.cellNibName,[cellModel class]);
//    
//    if (cellModel.cellClass)
//    {
//        cell = [[cellModel.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellModel.cellIdentifier];
//    }else
//    {
//        cell = [[[NSBundle mainBundle] loadNibNamed:cellModel.cellNibName owner:nil options:nil] firstObject];
//    }
//    cell.currentVC = self.currentVC;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    [cellModel setCell:cell toObjectFY:self.currentVC];
//    
//    return cell;
//}


@end
