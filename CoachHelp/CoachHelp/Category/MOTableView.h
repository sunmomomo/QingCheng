//
//  MOTableView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCTableViewHUD : UIView

-(void)loading;

-(void)stopLoading;

@end

@protocol MOTableViewDatasource;

@interface MOTableView : UITableView

@property(nonatomic,assign)BOOL dataSuccess;

@property(nonatomic,strong)UIView *emptyView;

@property(nonatomic,assign)id<MOTableViewDatasource> emptyDatasource;

@end


@protocol MOTableViewDatasource <UITableViewDataSource>

@optional

-(UIView *)emptyViewForTableView:(MOTableView *)tableView;

@end

