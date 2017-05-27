//
//  YFChooseGymVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFChooseGymVC.h"

#import "YFChooseGymViewModel.h"

#import "YFEmptyView.h"

#import "RootController.h"

#import "YFHeader.h"

@interface YFChooseGymVC ()

@property(nonatomic, strong)YFChooseGymViewModel *viewModel;

@end

@implementation YFChooseGymVC
{
    YFEmptyView *_emptyViewYF;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addGymSuccess) name:kAddNewGymIdtifierYF object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [RootController sharedSliderController].isChooseGymToCreatNewGym = NO;
}

- (void)addGymSuccess
{
    [self.navigationController popToViewController:self animated:YES];
    
    [self refreshTableListDataNoPull];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self setRefreshHeadViewYF];
    [self refreshTableListDataNoPull];
}


- (void)requestData
{
    weakTypesYF
    [self.viewModel getResponseDatashowLoadingOn:nil successBlock:^{

        [weakS requestSuccessArray:weakS.viewModel.dataArray];
//        [weakS requestSuccessArray:@[].mutableCopy];

    } failBlock:^{
        [weakS failRequest:nil];
    }];
}
- (void)initView
{
    self.baseTableView.mj_insetB = 50;
    self.baseTableView.scrollIndicatorInsets = self.baseTableView.contentInset;
    self.canGetMore = NO;
    self.title = @"选择报名场馆";
    self.baseTableView.backgroundColor = YFGrayViewColor;
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, MSH - 50, MSW, 50)];
    
    addButton.backgroundColor = [UIColor whiteColor];
    
    [addButton setTitle:@"  新增场馆" forState:UIControlStateNormal];
    
    [addButton setTitleColor:YFThreeChartDeColor forState:UIControlStateNormal];

    [addButton setImage:[UIImage imageNamed:@"AddSmsPeo"] forState:UIControlStateNormal];
    
    [addButton.titleLabel setFont:FontSizeFY(15)];
    
    [addButton addTarget:self action:@selector(addNewGym:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addButton];

    
}


- (YFChooseGymViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [YFChooseGymViewModel dataModel];
    }
    return _viewModel;
}


- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 64, self.baseTableView.width, self.baseTableView.height)];
        
        CGFloat emptyImageWidht = 144;
        
        CGFloat emptyImageYY = 126;
        
        CGFloat emptyImageXX = (_emptyViewYF.width - emptyImageWidht )/ 2.0;
        
        _emptyViewYF.emptyImg.frame = CGRectMake(emptyImageXX, emptyImageYY, emptyImageWidht, 0);
        
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
        
        _emptyViewYF.emptyImg.image = nil;
        
        
        [_emptyViewYF.emptyLabel changeTop:Width(224)];
        
        _emptyViewYF.emptyLabel.textColor = YFCellTitleColor;
        
        _emptyViewYF.emptyLabel.font = FontSizeFY(Width(17.0));
        
        _emptyViewYF.emptyLabel.frame = CGRectMake(_emptyViewYF.emptyLabel.mj_x, _emptyViewYF.emptyImg.bottom + Height320(3.5), _emptyViewYF.emptyLabel.width, _emptyViewYF.emptyLabel.height);
        
        _emptyViewYF.addbutton.hidden = YES;
        
        
        _emptyViewYF.emptyLabel.text = @"暂无场馆";
        
        UILabel *emptyMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _emptyViewYF.emptyLabel.bottom - Height320(4), MSW-40, Height320(13))];
        
        emptyMessageLabel.numberOfLines = 0;
        
        emptyMessageLabel.textColor = RGB_YF(136, 136, 136);
        
        emptyMessageLabel.font = FontSizeFY(Width(14.0));
        
        emptyMessageLabel.textAlignment = NSTextAlignmentCenter;
        
        emptyMessageLabel.text = @"请先添加一个场馆并完善信息";
        
        [_emptyViewYF addSubview:emptyMessageLabel];

        
        CGFloat width = Width(160);
        CGFloat height = Width(44);
        
        _emptyViewYF.addbutton.frame = CGRectMake((MSW - width)/2.0, emptyMessageLabel.bottom + 30, width, height);
        
        [_emptyViewYF.addbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_emptyViewYF.addbutton setBackgroundColor:YFThreeChartDeColor];
        
        [_emptyViewYF.addbutton addTarget:self action:@selector(addNewGym:) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyViewYF.addbutton setTitle:@"新增场馆" forState:UIControlStateNormal];
        
        _emptyViewYF.addbutton.hidden = NO;

        
    }
    
    return _emptyViewYF;
}


- (void)addNewGym:(id)sender
{
    
    [RootController sharedSliderController].isChooseGymToCreatNewGym = YES;
    [[RootController sharedSliderController] pushGuide];
}






@end
