//
//  YFSignUpListAddPerVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListAddPerVC.h"

#import "YFSignUpViewModel.h"

#import "YFSignUpListAddPerCModel.h"

#import "NSMutableArray+YFExtension.h"

#import "YFSignUpListSelectShowViewVC.h"

@interface YFSignUpListAddPerVC ()

@property(nonatomic, strong)YFSignUpViewModel *viewModel;

@property(nonatomic, strong)NSMutableSet *selectModelSet;

@property(nonatomic, strong)NSMutableArray *selectModelArray;

@property(nonatomic, strong)UILabel *numLabel;

@property(nonatomic, strong)UIView *funcView;

@property(nonatomic, strong)YFSignUpListSelectShowViewVC *chooseVC;

@end

@implementation YFSignUpListAddPerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.canGetMore = NO;
    [self setRefreshHeadViewYF];
    [self refreshTableListDataNoPull];

    self.leftTitle = @"取消";
    self.leftColor = [UIColor whiteColor];
    self.rightTitle = @"完成";
    [self initView];
}


- (void)initView
{
    [self.view addSubview:self.funcView];
}


- (void)requestData
{
    self.viewModel.page = self.dataPage;
    self.viewModel.competition_id = self.competition_id;
    
    weakTypesYF
    [self.viewModel getResponseDatashowLoadingOn:nil listModelClass:[YFSignUpListAddPerCModel class] successBlock:^{
        
        [weakS checkCannotSelectArray];
        
        [weakS checkSelectArrayState];

        [weakS requestSuccessArray:weakS.viewModel.arrayModel.listArray];
        
    } failBlock:^{
        [weakS failRequest:nil];
    }];

    
//    [self requestSuccessArray:[YFSignUpListAddPerCModel creatTestModelArray]];
}
// 已经选择的不能再选择
- (void)checkCannotSelectArray
{
    if (self.choosedNumIdDic.count == 0)
    {
        return;
    }

    for (YFSignUpListAddPerCModel *model in self.viewModel.arrayModel.listArray) {
        if ([self.choosedNumIdDic containsObject:model.su_id])
        {
            model.isCannotSelected = YES;
        }
    }
    [self checkSelectState];
}

// 检查 选择状态
- (void)checkSelectArrayState
{
    if (self.selectModelSet.count == 0)
    {
        return;
    }
    
    for (YFSignUpListAddPerCModel *model in self.viewModel.arrayModel.listArray) {
        if ([self.selectModelSet containsObject:model.su_id])
        {
            model.isSelected = YES;
        }
    }
    [self checkSelectState];
}



- (void)setSelctModel:(YFSignUpListAddPerCModel *)model check:(BOOL)check
{
    model.isSelected = YES;

    weakTypesYF
    [self.selectModelArray addObjectYF:[model sameModel:^(YFSignUpListAddPerCModel *mm) {
        [weakS.selectModelArray removeObject:mm];
        [weakS.chooseVC reloadData];
        
        if (weakS.selectModelArray.count == 0)
        {
            [weakS.chooseVC close];
        }
        for (YFSignUpListAddPerCModel *baseModel in weakS.baseDataArray)
        {
            if (baseModel.su_id.integerValue ==  mm.su_id.integerValue)
            {
                baseModel.isSelected = NO;
                [weakS.baseTableView reloadData];
            }
        }
        
    }]];
    
    if (model.su_id)
    {
        [self.selectModelSet addObject:model.su_id];
    }
    
    if (check)
    {
    [self checkSelectState];
    }
}

- (void)removeSelctModel:(YFSignUpListAddPerCModel *)model
{
    model.isSelected = NO;

    YFSignUpListAddPerCModel *remoModel;
    for (YFSignUpListAddPerCModel *selecModel in self.selectModelArray)
    {
        if (selecModel.su_id.integerValue == model.su_id.integerValue)
        {
            remoModel = selecModel;
        }
    }
    if (remoModel)
    {
        [self.selectModelArray removeObject:remoModel];
    }
    
    [self.chooseVC reloadData];
    
    if (model.su_id)
    {
        [self.selectModelSet removeObject:model.su_id];
    }
    [self checkSelectState];
}


- (void)checkSelectState
{
    [self.chooseVC setBaseDataArray:self.selectModelArray];
    if (self.selectModelArray.count) {
        
        if (self.selectModelArray.count<=99)
        {
            self.numLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.selectModelArray.count];
        }
        else
        {
            self.numLabel.text = @"...";
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.funcView changeTop:MSH-Height320(40)];
            
        } completion:^(BOOL finished) {
            
            self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0, self.funcView.height, 0);
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.funcView changeTop:MSH];
            
        } completion:^(BOOL finished) {
            
            self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
        
    }

}

#pragma mark Getter

- (NSMutableSet *)selectModelSet
{
    if (!_selectModelSet)
    {
        _selectModelSet = [NSMutableSet set];
    }
    return _selectModelSet;
}

- (NSMutableArray *)selectModelArray
{
    if (!_selectModelArray)
    {
        _selectModelArray = [NSMutableArray array];
    }
    return _selectModelArray;
}

- (YFSignUpViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [YFSignUpViewModel dataModel];
        _viewModel.gym_id = self.gym_id;

    }
    return _viewModel;
}

- (UIView *)funcView
{
    if (!_funcView)
    {
        
        UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height320(40))];
        
        view.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        view.layer.borderWidth = OnePX;
        
        view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:view];
        
        self.funcView = view;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(118), Height320(10), Width320(20), Height320(20))];
        
        label.backgroundColor = kMainColor;
        
        label.layer.cornerRadius = label.width/2;
        
        label.layer.masksToBounds = YES;
        
        label.textColor = UIColorFromRGB(0xffffff);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = AllFont(12);
    
        [self.funcView addSubview:label];
    
        self.numLabel = label;
        
        UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(self.numLabel.right, 0, Width320(60), Height320(40))];
        
        [self.funcView addSubview:showButton];
        
        [showButton addTarget:self action:@selector(showChoose) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(4), 0, Width320(40), Height320(40))];
        
        showLabel.text = @"已选择";
        
        showLabel.textColor = UIColorFromRGB(0x333333);
        
        showLabel.textAlignment = NSTextAlignmentCenter;
        
        showLabel.font = AllFont(12);
        
        [showButton addSubview:showLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(showLabel.right+Width320(3), Height320(17), Width320(12), Height320(7))];
        
        arrowImg.image = [UIImage imageNamed:@"down_arrow"];
        
        arrowImg.transform = CGAffineTransformMakeRotation(M_PI);
        
        [showButton addSubview:arrowImg];
    }
    return _funcView;
}

- (YFSignUpListSelectShowViewVC *)chooseVC
{
    if (!_chooseVC)
    {
        YFSignUpListSelectShowViewVC *showVC = [[YFSignUpListSelectShowViewVC alloc] initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        _chooseVC = showVC;
        
        _chooseVC.view.hidden = YES;
        
        [self.view addSubview:showVC.view];
    }
    return _chooseVC;
}

#pragma mark Action
- (void)showChoose
{
    [self.chooseVC show];
}

- (void)setChoosedNumIdDic:(NSSet *)choosedNumIdDic
{
    _choosedNumIdDic = choosedNumIdDic;
    
    if (choosedNumIdDic.count)
    {
    [self.selectModelSet setByAddingObjectsFromSet:choosedNumIdDic];
    }
}

- (void)naviRightClick
{
    NSMutableArray *selectDataArray = [NSMutableArray array];
    
    for (YFSignUpListAddPerCModel *model in self.baseDataArray) {
        if (model.isSelected || model.isCannotSelected)
        {
            [selectDataArray addObjectYF:model.dataDic];
        }
    }
       
    if (self.chooseArrayB)
    {
        self.chooseArrayB(selectDataArray,self);
    }
}



@end
