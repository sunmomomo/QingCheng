 //
//  YFSearchResultStudentStateVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultStudentStateVC.h"
#import "YFSearchStuStateDataModel.h"

#import "YFStudentStateModel.h"

@interface YFSearchResultStudentStateVC ()

@property(nonatomic, strong)YFSearchStuStateDataModel *dataModel;

@property(nonatomic, assign)BOOL isRefreshData;


@end

@implementation YFSearchResultStudentStateVC
{
    NSString *_searchStr;
}


//-(instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListData) name:kPostModifyOrAddStudentIdtifierYF object:nil];
//    }
//    return self;
//}
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isRefreshData = NO;
    self.canGetMore = NO;
    
//    [self setRefreshHeadViewYF];
}


-(void)refreshTableListData
{
    if (_isRefreshData)
    {
        return;
    }
    NSString *str = _searchStr;
    _searchStr = @"";
    [self searchStrChangeYF:str];
}

- (void)searchStrChangeYF:(NSString *)str
{
    if ([_searchStr isEqualToString:str] == YES)
    {
        return;
    }
    [self requestSearchWithStrYF:str];

}

-(void)requestSearchWithStrYF:(NSString *)str
{
    _searchStr = str;
    
    [self dealUsers];
    
    return;
//    if (_searchStr.length == 0)
//    {
//    }else
//    {
//        weakTypesYF
//        self.dataModel.searchStr = _searchStr;
//        [self.dataModel getResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
//            weakS.isRefreshData = NO;
//            weakS.baseDataArray = weakS.dataModel.showDataArray;
//            [weakS.baseTableView reloadData];
//            [weakS setTableFootviewLabelNum:weakS.dataModel.allMemNum.integerValue];
//            
//        } failBlock:^{
//            
//        }];
//    }

}

- (YFSearchStuStateDataModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[YFSearchStuStateDataModel alloc] init];
    }
    _dataModel.isToday = self.isToday;
    _dataModel.status = self.status;
    return _dataModel;
}

- (void)setDataArrayFromFilterData:(NSMutableArray *)dataArrayFromFilterData
{
    _dataArrayFromFilterData = dataArrayFromFilterData;
    
    [self dealUsers];
}



- (NSMutableArray *)dealArray:(NSMutableArray *)array searStr:(NSString *)searStr
{
    if (searStr.length==0) {
        
        return [NSMutableArray array];
    }else if(searStr.length != 0)
    {
        NSMutableArray *users = [NSMutableArray array];
        for (YFStudentStateModel *tempStu in array) {
            
            if ([[tempStu.username lowercaseString] rangeOfString:[searStr lowercaseString]].length||[tempStu.phone rangeOfString:searStr].length) {
                [users addObject:tempStu];
            }
        }
        return users;
    }
    return nil;
}

-(void)dealUsers
{
    self.searStrDes = [NSString stringWithFormat:@"搜索%@名会员",@(self.dataArrayFromFilterData.count)];
    
    NSMutableArray *temUsers = [self dealArray:self.dataArrayFromFilterData searStr:_searchStr];
    
    self.baseDataArray = temUsers;

    [self setTableFootviewLabelNum:self.baseDataArray.count];
    if (_searchStr.length > 0 && self.baseDataArray.count == 0)
    {
        self.searStrDes = @"无搜索结果";
    }
    
    [self.baseTableView reloadData];
}



- (void)setTableFootviewLabelNum:(NSInteger )count
{
    
    //    搜索全部会员，无搜索结果
    if (count > 0) {
        self.tableFootView.hidden = NO;
        self.tableFootLabel.text = [NSString stringWithFormat:@"%@名会员",@(count)];
        [self.baseTableView setTableFooterView:self.tableFootView];
        [self.emptyView removeFromSuperview];
        
    }else
    {
        [self.baseTableView addSubview:self.emptyView];
        self.tableFootView.hidden = YES;
        [self.baseTableView setTableFooterView:[[UIView alloc] init]];
    }
}




@end
