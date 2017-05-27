//
//  YFStudnetOriginVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudnetOriginVC.h"
#import "YFStudentRightDataModel.h"
#import "YFAddOriginCModel.h"

@interface YFStudnetOriginVC ()

@property(nonatomic,strong)YFStudentRightDataModel *dataModel;


@end

@implementation YFStudnetOriginVC

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPull) name:kPostAddOriginIdtifierYF object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.title.length == 0)
    {
        self.title = @"来源";
    }

    
    if (!self.isCanAdd)
    {
    [self.navi removeFromSuperview];
    }
    self.canGetMore = NO;
    
    
    [self refreshTableListDataNoPull];
    [self setRefreshHeadViewYF];
}

-(void)requestData
{
    weakTypesYF
    [self.dataModel getOriginResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
        
        if (weakS.isCanAdd)
        {
            for (YFStudentFilterOriginModel *model in weakS.dataModel.oriArray) {
                if (weakS.selectName && [model.name isEqualToString:weakS.selectName]) {
                    model.isSelected = YES;
                }
            }
            YFAddOriginCModel *model = [YFAddOriginCModel defaultWithDic:nil];
            [weakS.dataModel.oriArray insertObject:model atIndex:0];
        }else
        {
            YFStudentFilterOriginModel *model = [YFStudentFilterOriginModel defaultWithDic:nil];
            model.name = @"全部";
            model.o_id = @"";
            if (!weakS.selectModel ) {
                model.isSelected = YES;
                _selectModel = model;

            }else
            {
                for (YFStudentFilterOriginModel *subModel in weakS.dataModel.oriArray) {
                    if ([subModel.name isEqualToString: weakS.selectModel.name]) {
                        _selectModel = subModel;
                       
                        subModel.isSelected = YES;
                    }
                }

            }
            [weakS.dataModel.oriArray insertObject:model atIndex:0];
        }
        [weakS requestSuccessArray:weakS.dataModel.oriArray];
    } failBlock:^{
        [weakS failRequest:nil];
    }];

}

- (YFStudentRightDataModel *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [[YFStudentRightDataModel alloc] init];
    }
    _dataModel.isFilter = _isFilter;
    return _dataModel;
}

-(void)emptyDataReminderAction
{
    
}

-(void)setSelectModel:(YFStudentFilterOriginModel *)selectModel
{
    if (!selectModel)
    {
        _selectModel.isSelected = NO;
    }
    if (_selectModel && [_selectModel isEqual:selectModel] == NO) {
        _selectModel.isSelected = NO;
    }
    _selectModel = selectModel;
    [self.baseTableView reloadData];
    
    if (self.selectBlock) {
        self.selectBlock();
    }
}

- (void)setChooseName:(NSString *)name
{
    self.selectModel = nil;
    
    if (!name  || name.length == 0)
    {
        return;
    }
    if (self.isCanAdd == NO) {
        for (YFStudentFilterOriginModel *model in self.baseDataArray)
        {
            if ([model.name isEqualToString:name])
            {
                model.isSelected = YES;
                self.selectModel = model;
            }
        }
    }
    [self.baseTableView reloadData];
}

@end
