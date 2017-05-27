//
//  YFAddSmsPeopleCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAddSmsPeopleCModel.h"

#import "YFTagView.h"

#import "YFAddSmsPeopleCell.h"

#import "YFBaseRefreshTBVC.h"

@interface YFAddSmsPeopleCModel ()<EYTagViewDelegate>



@end

static NSString *yFAddSmsPeopleCell = @"YFAddSmsPeopleCell";

@implementation YFAddSmsPeopleCModel



- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFAddSmsPeopleCell;
        self.cellClass = [YFAddSmsPeopleCell class];
        self.cellHeight = 50.0;
        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

- (void)setCell:(YFAddSmsPeopleCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell.tagView.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [baseCell.tagView setTitleBlock:^NSString *(Student *ss) {
        
        return ss.name;
    }];
    
    if (self.tagsModelArray.count)
    {
    [baseCell.tagView addTagModels:self.tagsModelArray];
    [self heightDidChangedTagView:baseCell.tagView];
    }
}

-(void)bindCell:(YFAddSmsPeopleCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.tagView.delegate = self;
}

- (void)heightDidChangedTagView:(YFTagView *)tagView
{
    if (tagView.height < 50)
    {
        self.cellHeight = 50;
    }
    else
    {
        self.cellHeight = tagView.height;
    }
    [((YFBaseRefreshTBVC *)self.weakCell.currentVC).baseTableView reloadData];
}

- (void)addButtonAction:(UIButton *)sender
{
    if (self.addButtonBlock) {
        self.addButtonBlock(self);
    }
}

- (void)addStudentArray:(NSMutableArray *)array
{
    YFAddSmsPeopleCell *cell = (YFAddSmsPeopleCell *)self.weakCell;
    
    [cell.tagView removeAllTag];
    
    [cell.tagView addTagModels:array];
}

@end
