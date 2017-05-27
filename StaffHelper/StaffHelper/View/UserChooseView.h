//
//  UserChooseView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserChooseViewDatasource <UITableViewDataSource,UITableViewDelegate>

@end

@interface UserChooseView : UIView

@property(nonatomic,assign)float maxHeight;

@property(nonatomic,weak)id<UserChooseViewDatasource> datasource;

-(void)show;

-(void)reloadData;

-(void)close;

@end
