//
//  ChooseView.h
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/13.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseViewDatasource <NSObject>

@required

-(NSInteger)numberOfRowInChooseView;

-(UIScrollView*)viewForRow:(NSInteger)row;

@optional

-(NSString *)titleForButtonAtRow:(NSInteger)row;

-(UIView*)viewForButtonAtRow:(NSInteger)row;

-(BOOL)newAtRow:(NSInteger)row;

-(void)chooseViewEndRefresh;

-(void)chooseButtonClick:(NSInteger)index;

@end

@interface ChooseView : UIView

@property(nonatomic,assign)float rowWidth;

@property(nonatomic,assign)float rowGap;

@property(nonatomic,assign)float lineHeight;

@property(nonatomic,assign)BOOL noRefresh;

@property(nonatomic,assign,setter=setRowHeight:)float rowHeight;

@property(nonatomic,assign)NSInteger selectNum;

@property(nonatomic,assign,setter= setDatasource:)id<ChooseViewDatasource> datasource;

-(void)reload;

-(void)reloadAtIndex:(NSInteger)index;

-(void)reloadData;

-(void)reloadTableViewDataWithSuccess:(BOOL)success;

-(void)reloadTitle;

-(void)selectNum:(NSInteger)num;

@end
