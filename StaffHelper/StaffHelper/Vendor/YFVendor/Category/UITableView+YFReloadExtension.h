//
//  UITableView+YFReloadExtension.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YFReloadExtension)

- (void)insertRowsAtSectionYF:(NSInteger)section beginRow:(NSInteger )beginRow endRow:(NSInteger)endRow;

- (void)reloadSectionYF:(NSInteger)section;

- (void)deleteIndexPathYF:(NSIndexPath *)indexPath;

- (void)deleteSectionYF:(NSInteger )section row:(NSInteger)row;

@end
