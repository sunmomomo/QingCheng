//
//  YFAbsenceStatisticVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAbsenceStatisticVC.h"

#import "GTWSelectOperationView.h"

#import "YFAbsenceStaTimePopView.h"

#import "YFAbsenceStaticCModel.h"

#import "YFStudentOutDataModel.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFEmptyView.h"

#import "YFTBSectionLineEdgeDelegate.h"

@interface YFAbsenceStatisticVC ()

@property(nonatomic, strong)YFStudentOutDataModel *dataModel;

@property(nonatomic, strong)UIView *tableFootView;

@property(nonatomic, strong)UILabel *tableFootLabel;

@end

@implementation YFAbsenceStatisticVC
{
    YFEmptyView *_emptyViewYF;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.classsArray = @[[YFAbsenceStaTimePopView class]];
        self.popViewFrame =  CGRectMake(0, 64 + GTWSelectOperationViewHeight, MSW, MSH  - 64.0 - GTWSelectOperationViewHeight);
        self.buttonTitleArray = @[@"缺勤7-30天"];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.numberOfEachPage = 30;

    self.title = @"缺勤统计";
    self.baseTableView.frame = CGRectMake(0, 64 + GTWSelectOperationViewHeight, self.view.width, self.view.height  - 64.0 - GTWSelectOperationViewHeight);
    
    [self refreshTableListDataNoPull];
    [self setRefreshHeadViewYF];
}

- (void)requestData
{
    self.dataModel.page = self.dataPage;
    
    if (self.allParam.count == 0)
    {
        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setObje_FY:@"7" toKey:@"absence__gt"];
        
        [paraDic setObje_FY:@"30" toKey:@"absence__lte"];
        
        self.allParam = paraDic;
    }
    weakTypesYF
    [self.dataModel getAbsenceResponseDatashowLoadingOn:nil conditonParam:self.allParam successBlock:^{
    
        [weakS requestSuccessArray:weakS.dataModel.dataArray];
        [weakS.baseTableView setTableHeaderView:weakS.tableFootView];
    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
//    NSMutableArray *dataArray = [NSMutableArray array];
//    YFAbsenceStaticCModel *model = [YFAbsenceStaticCModel defaultWithYYModelDic:nil];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    
//    self.baseDataArray = dataArray;
//    [self.baseTableView reloadData];
//    
//    [self.baseTableView setTableHeaderView:self.tableFootView];
}

-(UIView *)tableFootView
{
    if (!_tableFootView)
    {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 42)];
        _tableFootView.backgroundColor = YFGrayViewColor;
        CGFloat labelWidth = _tableFootView.width - 38;
        _tableFootLabel = [[UILabel alloc] initWithFrame:CGRectMake(19.0, 0, labelWidth, _tableFootView.height)];
        
        _tableFootLabel.backgroundColor = YFGrayViewColor;
        _tableFootLabel.textColor = RGB_YF(153, 153, 153);
        _tableFootLabel.font = FontSizeFY(XFrom5To6YF(12.0));
        _tableFootLabel.textAlignment = NSTextAlignmentLeft;
        [_tableFootView addSubview:_tableFootLabel];
    }
    if (self.dataModel.dataModel.total_count.integerValue > 0)
    {
        NSString *title = self.showPopView.value;
        if (title.length == 0) {
            title = @"缺勤7-30天";
        }
        _tableFootLabel.text = [NSString stringWithFormat:@"%@的会员共计%@人",title,self.dataModel.dataModel.total_count];
        _tableFootView.hidden = NO;
    }else
    {
        _tableFootView.hidden = YES;
    }
    
    return _tableFootView;
}


- (YFStudentOutDataModel *)dataModel
{
    if (_dataModel == nil) {
        _dataModel = [YFStudentOutDataModel dataModel];
    }
    return _dataModel;
}


-(void)emptyDataReminderAction
{
    [self.baseTableView addSubview:self.emptyView];
}


- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 0, self.baseTableView.width, self.baseTableView.height)];
        
        CGFloat emptyImageWidht = Width320(80);
        
        CGFloat emptyImageYY = Width320(83);
        
        CGFloat emptyImageXX = (_emptyViewYF.width - emptyImageWidht )/ 2.0;
        
        _emptyViewYF.emptyImg.frame = CGRectMake(emptyImageXX, emptyImageYY, emptyImageWidht, emptyImageWidht);
        
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
        
        _emptyViewYF.emptyImg.image = [UIImage imageNamed:@"filterStudentEmpty"];
        
        _emptyViewYF.emptyLabel.text = @"筛选时段内没有会员缺勤";
        
        _emptyViewYF.emptyLabel.textColor = YFCellTitleColor;
        
        _emptyViewYF.emptyLabel.font = AllFont(14);
        
        
        _emptyViewYF.emptyLabel.frame = CGRectMake(_emptyViewYF.emptyLabel.mj_x, _emptyViewYF.emptyImg.bottom + Height320(3.5), _emptyViewYF.emptyLabel.width, _emptyViewYF.emptyLabel.height);
        
        _emptyViewYF.addbutton.hidden = YES;
        
    }
    
    //        _emptyViewYF.emptyImg.hidden = NO;
    //
    //
    //        [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom+Height320(19.5)];
    //
    //        [_emptyViewYF.addbutton changeTop:_emptyViewYF.emptyLabel.bottom+Height320(19.5)];
    
    return _emptyViewYF;
}


-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}







@end
