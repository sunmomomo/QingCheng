//
//  RecordCalendarView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MOTableView.h"

@protocol RecordCalendarViewDatasource <NSObject>

-(MOTableView *)tableViewForMonth:(NSInteger)month;

@end

@protocol RecordCalendarViewDelegate <NSObject>

-(void)yearChanged;

-(void)changedMonth:(NSInteger)month;

@end

@interface RecordCalendarView : UIView

@property(nonatomic,assign)NSInteger year;

@property(nonatomic,assign)NSInteger currentMonth;

@property(nonatomic,assign)id<RecordCalendarViewDatasource> datasource;

@property(nonatomic,assign)id<RecordCalendarViewDelegate>delegate;

-(void)reloadDataAtMonth:(NSInteger)month;

@end
