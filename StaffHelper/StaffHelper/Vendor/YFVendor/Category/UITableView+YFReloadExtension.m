//
//  UITableView+YFReloadExtension.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "UITableView+YFReloadExtension.h"

@implementation UITableView (YFReloadExtension)

- (void)insertRowsAtSectionYF:(NSInteger)section beginRow:(NSInteger )beginRow endRow:(NSInteger)endRow
{
    DebugLogParamYF(@"插入 %@ -%@ cell", @(beginRow),@(endRow));
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = beginRow; i <= endRow; i ++)
    {
        [array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    [self insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];

}

- (void)reloadSectionYF:(NSInteger)section
{
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)deleteIndexPathYF:(NSIndexPath *)indexPath
{
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)deleteSectionYF:(NSInteger )section row:(NSInteger)row
{
    [self deleteIndexPathYF:[NSIndexPath indexPathForRow:row inSection:section]];
}

@end
