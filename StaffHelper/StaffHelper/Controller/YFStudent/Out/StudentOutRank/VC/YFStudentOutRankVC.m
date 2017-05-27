//
//  YFStudentOutRankVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentOutRankVC.h"

#import "YFOutRankTimePopView.h"

#import "YFOutRankDaysPopView.h"

#import "YFOutRandCModel.h"

#import "YFStudentOutDataModel.h"

#import "YFEmptyView.h"

#import "YFTBSectionLineEdgeDelegate.h"

@interface YFStudentOutRankVC ()

@property(nonatomic, strong)YFStudentOutDataModel *dataModel;

@property(nonatomic, strong)UIView *tableFootView;

@property(nonatomic, strong)UILabel *tableFootLabel;


@end

@implementation YFStudentOutRankVC
{
    YFEmptyView *_emptyViewYF;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.classsArray = @[[YFOutRankTimePopView class],[YFOutRankDaysPopView class]];
        CGFloat yy =  64.0 + GTWSelectOperationViewHeight;
        
        self.popViewFrame = CGRectMake(0, yy, MSW, MSH - yy);
        
        self.buttonTitleArray = @[@"最近30天",@"出勤天数"];

    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"出勤排行";
    self.operationView = [self operationViewYF];
    [self.view addSubview:self.operationView];
    self.baseTableView.frame = CGRectMake(0,self.operationView.height + 64.0, MSW, MSH - self.operationView.height - 64.0);
    self.numberOfEachPage = 30;
    [self setRefreshHeadViewYF];
//    [self refreshTableListDataNoPull];
    
}

- (void)requestData
{
    self.dataModel.page = self.dataPage;
    
    UIButton *button = [self.operationView buttonWithIndex:1];

    NSString *orderby = self.allParam[@"order_by"];
    
    self.orderby = [orderby stringByReplacingOccurrencesOfString:@"-" withString:@""];

    if ([orderby hasPrefix:@"-"])
    {
        self.isDownToTop = NO;
    
        [button setImage:[UIImage imageNamed:@"filterUnSelectDown"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"filterUnSelectDown"] forState:UIControlStateSelected];
    }else
    {
        self.isDownToTop = YES;
        
        [button setImage:[UIImage imageNamed:@"filterUnSelectUp"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"filterUnSelectUp"] forState:UIControlStateSelected];
    }
    
    
    weakTypesYF
    [self.dataModel getOutRankResponseDatashowLoadingOn:nil conditonParam:self.allParam successBlock:^{
        [weakS requestSuccessArray:weakS.dataModel.dataArray];
        [weakS.baseTableView setTableHeaderView:weakS.tableFootView];

    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
//    NSMutableArray *dataArray = [NSMutableArray array];
//    YFOutRandCModel *model = [YFOutRandCModel defaultWithYYModelDic:nil];
//    
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
//    [dataArray addObject:model];
    
}

- (GTWSelectOperationView *)operationViewYF
{
// filterUnSelectUp
//  filterUnSelectDown
    
   GTWSelectOperationView *operationView = [[GTWSelectOperationView alloc]initWithDataSourceFY:self.buttonTitleArray sepImageArray:@[@"buttonUnSelectedUp",@"filterUnSelectDown"] downImageArray:@[@"buttonUnSelectedDown",@"filterUnSelectDown"] delegate:self font:[UIFont systemFontOfSize:IPhone4_5_6_6PYF(13, 13, 14, 14)]];
    
    operationView.upSeleImageArray = @[@"buttonUnSelectedUp",@"filterSelectUp"];
    
    operationView.downSeleImageArray = @[@"buttonUnSelectedDown",@"filterSelectDown"];
    
    operationView.backgroundColor = [UIColor whiteColor];
    
    operationView.frame = CGRectMake(0, 64.0, self.view.width, GTWSelectOperationViewHeight);
    
    operationView.delegate = self;

    return operationView;
}

- (YFStudentOutDataModel *)dataModel
{
    if (_dataModel == nil) {
        _dataModel = [YFStudentOutDataModel dataModel];
    }
    return _dataModel;
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
    
    if ([self.showPopView isKindOfClass:[YFOutRankTimePopView class]])
    {
        YFOutRankTimePopView *shoRankTimeVC = (YFOutRankTimePopView *)self.showPopView;
        
        
        
        if (self.dataModel.dataModel.total_count.integerValue > 0)
        {
            NSString *title = shoRankTimeVC.footerDateStr;
            if (title.length == 0) {
                title = self.showPopView.value;
            }
            
            if (title.length == 0) {
                title = @"最近30天";
            }
            _tableFootLabel.text = [NSString stringWithFormat:@"%@出勤会员共%@人",title,self.dataModel.dataModel.total_count];
            _tableFootView.hidden = NO;
        }else
        {
            _tableFootView.hidden = YES;
        }
    }
    return _tableFootView;
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
        
        _emptyViewYF.emptyLabel.text = @"筛选时段内没有会员出勤";
        
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
