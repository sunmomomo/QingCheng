//
//  YFStudentListRightVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentListRightVC.h"
#import "YFTBSectionsDataSource.h"
#import "YFTBSectionsDelegate.h"
#import "YFTBSectionsModel.h"
#import "YFTBSectionsTitleModel.h"

#import "YFStudentFilterStateModel.h"
#import "YFStudentFilterTimeModel.h"
#import "YFStudentFilterRePeoModel.h"
#import "YFTBSectionsRePoModel.h"
#import "YFStudentFilterOriginModel.h"
#import "YFStudentRightDataModel.h"
#import "YFAppService.h"

#import "YFTBSectionsLineExEdgeDelegate.h"

#import "YFRightVCNoDataModel.h"

#import "YFStudentFilterBirthdayModel.h"

#import "YFStudentFilterGenderModel.h"

#import "YFTBSectionsSellerModel.h"

#define YFDonwnButtonSHeight XFrom5YF(40)

#import "YFSellerDataModel.h"

#import "NSMutableArray+YFExtension.h"

@interface YFStudentListRightVC ()

@property(nonatomic, strong)UIButton *clearAllFilterConditionButton;
@property(nonatomic, strong)UIButton *sureButton;

@property(nonatomic, strong)YFStudentFilterStateModel *stateModel;

@property(nonatomic, strong)YFStudentFilterGenderModel *genderModel;

@property(nonatomic, strong)YFStudentFilterTimeModel *timeModel;

@property(nonatomic, strong)YFStudentFilterBirthdayModel *birthdayModel;


@property(nonatomic,strong)YFStudentRightDataModel *dataModel;

@property(nonatomic,strong)YFTBSectionsRePoModel *sectionReModel;

@property(nonatomic,strong)YFTBSectionsRePoModel *sectionoriModel;

@property(nonatomic, strong)YFTBSectionsSellerModel *sectionSellerModel;

@property(nonatomic,strong)YFSellerDataModel *sellerDataModel;



@end

@implementation YFStudentListRightVC
{
    NSMutableDictionary *_allOrigDic;
    NSMutableDictionary *_allRecoDic;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestSellerData) name:kPostAddNewSellerIdtifierYF object:nil];

        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestOriginData) name:kPostAddOriginToMemeberIdtifierYF object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestRecoData) name:kPostAddRecomendToMemeberIdtifierYF object:nil];
        
        self.isShouldChooseTodayWhenClear = NO;
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.canGetMore = NO;
    [self.navi removeFromSuperview];
    
    self.baseTableView.frame = CGRectMake(0, 0, MSW * StudentRightShowScale, MSH - YFDonwnButtonSHeight);
    
    [self.view addSubview:self.clearAllFilterConditionButton];
    [self.view addSubview:self.sureButton];
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.sureButton.top , self.sureButton.width * 2, 0.5)];
    lineView1.backgroundColor = YFLineViewColor;
    [self.view addSubview:lineView1];
    [self refreshTableListDataNoPull];
}

-(void)showLoadingViewWithMessage:(NSString *)message
{
    
}

-(void)requestData
{
    NSMutableArray *sectionArray = [NSMutableArray array];
    
    YFTBSectionsModel *models1 = [[YFTBSectionsModel alloc] init];
    
    [models1.dataArray addObject:self.stateModel];
    
    YFTBSectionsModel *models12 = [[YFTBSectionsModel alloc] init];
    
    [models12.dataArray addObject:self.genderModel];
    
    
    YFTBSectionsModel *models2 = [[YFTBSectionsModel alloc] init];
    
    [models2.dataArray addObject:self.timeModel];
    
    YFTBSectionsModel *models3;
    
    if (self.isCanFilterBirthday)
    {
        models3 = [[YFTBSectionsModel alloc] init];
        
        [models3.dataArray addObject:self.birthdayModel];
    }
    
   
    
    //    for (NSUInteger i = 0; i < 10; i ++)
    //    {
    //        YFStudentFilterRePeoModel *models3Model = [[YFStudentFilterRePeoModel alloc] initWithDictionary:nil];
    //        [self.sectionReModel.dataArray addObject:models3Model];
    //    }
    
    //    YFTBSectionsRePoModel *sectionModel4 = [[YFTBSectionsRePoModel alloc] init];
    //    sectionModel4.tableView =self.baseTableView;
    //    sectionModel4.sectionTitle = @"来源";
    //    [sectionModel4 setStudentFilterRePeo];
    
    
    //    for (NSUInteger i = 0; i < 10; i ++)
    //    {
    //        YFStudentFilterOriginModel *models3Model = [[YFStudentFilterOriginModel alloc] initWithDictionary:nil];
    //        [sectionModel4.dataArray addObject:models3Model];
    //    }
    
    [sectionArray addObjectYF:models1];
    [sectionArray addObjectYF:models12];
    
    [sectionArray addObjectYF:models2];
    if (models3) {
        [sectionArray addObjectYF:models3];
    }
    if (self.isCanFilterSeller)
    {
    [sectionArray addObjectYF:self.sectionSellerModel];
    }
    
    [sectionArray addObjectYF:self.sectionReModel];
    [sectionArray addObjectYF:self.sectionoriModel];
    
    [self requestSuccessArray:sectionArray];
    
    if (self.isCanFilterSeller)
    {
    [self requestSellerData];
    }
    [self requestRecoData];
    [self requestOriginData];
    
}

- (void)requestSellerData
{
       weakTypesYF
    [self.sellerDataModel getResponseDatashowLoadingOn:nil gym:self.gym isHaveAllSeller:NO successBlock:^{
    
        [weakS.sectionSellerModel.dataArray removeAllObjects];
    
        if (weakS.sellerDataModel.dataMOdel.listArray.count <=0)
        {
            [weakS.sectionSellerModel.dataArray addObject:[YFRightVCNoDataModel defaultWithDic:nil]];
        }
        else
        {
            [weakS.sectionSellerModel.dataArray addObject:weakS.sectionSellerModel.sellerCModel];
            
            if (self.seller_id && [self.seller_id isKindOfClass:[NSString class]])
            {
                for (YFSellerModel *model in weakS.sellerDataModel.dataMOdel.listArray)
                {
                    if ([model.s_id isEqualToString:self.seller_id])
                    {
                        model.isSelected = YES;
                        
                        weakS.sectionSellerModel.sellerCModel.param = @{@"seller_id":model.s_id};
                    }
                }
            }
            
            weakS.sectionSellerModel.sellerCModel.dataArray = weakS.sellerDataModel.dataMOdel.listArray;
        }
        [weakS.baseTableView reloadData];
    } failBlock:^{
    }];

}

- (void)requestRecoData
{
    weakTypesYF
    [self.dataModel getResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
        weakS.sectionReModel.dataArray = weakS.dataModel.reArray;
        
        [weakS setCheckrecoSelected];
        if (weakS.sectionReModel.dataArray.count == 0)
        {
            [weakS.sectionReModel.dataArray addObject:[YFRightVCNoDataModel defaultWithDic:nil]];
        }
        [weakS.baseTableView reloadData];
    } failBlock:^{
        
    }];
    
}

- (void)requestOriginData
{
    weakTypesYF
    [self.dataModel getOriginResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
        weakS.sectionoriModel.dataArray = weakS.dataModel.oriArray;
        [weakS setCheckOriSelected];
        if (weakS.sectionoriModel.dataArray.count == 0)
        {
            [weakS.sectionoriModel.dataArray addObject:[YFRightVCNoDataModel defaultWithDic:nil]];
        }
        [weakS.baseTableView reloadData];
    } failBlock:^{
        
    }];
    
}

#pragma mark Action

- (void)clearAllFilterConditionButtonAction:(UIButton *)button
{
    [self sureToClearAllCondiciton];
    
    //    weakTypesYF
    //    [YFAppService showAlertMessage:@"确定重置所有筛选条件吗？" sureBlock:^{
    //    }];
}

- (void)sureToClearAllCondiciton
{
    self.stateModel.isMember = NO;
    self.stateModel.isFollowing = NO;
    self.stateModel.isNewReg = NO;
    
    self.genderModel.gender = @"";
    self.timeModel.startTime = @"";
    self.timeModel.endTime = @"";
    if (self.isShouldChooseTodayWhenClear)
    {
        [self.timeModel selectTodayButton];
    }
    else
    {
        [self.timeModel unSelectAllButton];
    }
    
    self.birthdayModel.startTime = @"";
    self.birthdayModel.endTime = @"";
 
    [self.sectionSellerModel.sellerCModel setUnSelectSellerModel];

    
    [self.allRecoDic removeAllObjects];
    [self.allOrigDic removeAllObjects];
    [self setCheckOriSelected];
    [self setCheckrecoSelected];
    
    [self.baseTableView reloadData];
    
    //    [self sureButtonAction:self.sureButton];
}

- (void)sureButtonAction:(UIButton *)button
{
    self.filterModel.status = self.stateModel.statusString;
    self.filterModel.startTime = self.timeModel.startTime;
    self.filterModel.endTime = self.timeModel.endTime;
    self.filterModel.startBirthDayTime = self.birthdayModel.startTime;
    self.filterModel.endBirthDayTime = self.birthdayModel.endTime;
    self.filterModel.gender = self.genderModel.gender;
    
    self.filterModel.timeType  = self.timeModel.timeType;
    
    self.filterModel.seller_id = self.sectionSellerModel.sellerCModel.selelctModel.s_id;
    
    self.filterModel.allOrigDic = [NSMutableDictionary dictionaryWithDictionary:self.allOrigDic];
    self.filterModel.allRecoDic = [NSMutableDictionary dictionaryWithDictionary:self.allRecoDic];
    
    if (self.sureBlock) {
        self.sureBlock();
    }
}


-(void)setFilterModel:(YFFilterOtherModel *)filterModel
{
    _filterModel = filterModel;
    
    NSArray *statusArray = [filterModel.status componentsSeparatedByString:@","];
    
    if (statusArray.count == 0) {
        statusArray =  [filterModel.status componentsSeparatedByString:@"，"];
    }
    
    self.timeModel.startTime = filterModel.startTime;
    self.timeModel.endTime = filterModel.endTime;
    self.timeModel.timeType = self.filterModel.timeType;

    if (self.isCanFilterBirthday)
    {
        self.birthdayModel.startTime = filterModel.startBirthDayTime;
        self.birthdayModel.endTime = filterModel.endBirthDayTime;
    }
    self.genderModel.gender = filterModel.gender;
    
    
    
    if (statusArray.count == 0) {
        self.stateModel.isMember = NO;
        self.stateModel.isFollowing = NO;
        self.stateModel.isNewReg = NO;
    }else
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        for (NSArray *str in statusArray) {
            
            [dic setObject:@"dd" forKey:[NSString stringWithFormat:@"%@",str]];
        }
        
        if ([dic objectForKey:YFIsNewRe])
        {
            self.stateModel.isNewReg = YES;
        }else
        {
            self.stateModel.isNewReg = NO;
        }
        
        if ([dic objectForKey:YFIsFollowing])
        {
            self.stateModel.isFollowing = YES;
        }else
        {
            self.stateModel.isFollowing = NO;
        }
        
        if ([dic objectForKey:YFIsMember])
        {
            self.stateModel.isMember = YES;
        }
        else
        {
            self.stateModel.isMember = NO;
        }
    }
    
    
    [self checkSellerIdSelect];
    
    [self.baseTableView reloadData];
}
#pragma mark  代理Model 的设置
-(YFTBBaseDatasource *)dataSourceTBYF
{
    weakTypesYF
    return [YFTBSectionsDataSource tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
    } currentVC:self];
}

-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionsLineExEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}

#pragma mark Getter
- (UIButton *)clearAllFilterConditionButton
{
    if (!_clearAllFilterConditionButton)
    {
        CGFloat buttonWidth = MSW * StudentRightShowScale / 2.0;
        _clearAllFilterConditionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _clearAllFilterConditionButton.frame = CGRectMake(0, MSH -  YFDonwnButtonSHeight, buttonWidth, YFDonwnButtonSHeight);
        [_clearAllFilterConditionButton setTitle:@"重置" forState:UIControlStateNormal];
        [_clearAllFilterConditionButton setTitleColor:YFCellTitleColor forState:UIControlStateNormal];
        [_clearAllFilterConditionButton.titleLabel setFont:AllFont(14)];
        _clearAllFilterConditionButton.backgroundColor = YFMainBackColor;
        [_clearAllFilterConditionButton addTarget:self action:@selector(clearAllFilterConditionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearAllFilterConditionButton;
}

- (UIButton *)sureButton
{
    if (!_sureButton)
    {
        CGFloat buttonWidth = MSW * StudentRightShowScale / 2.0;
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _sureButton.frame = CGRectMake(buttonWidth, MSH -  YFDonwnButtonSHeight, buttonWidth, YFDonwnButtonSHeight);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton.titleLabel setFont:AllFont(14)];
        _sureButton.backgroundColor = RGB_YF(11, 177, 75.0);
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sureButton;
}

-(YFStudentFilterStateModel *)stateModel
{
    if (!_stateModel)
    {
        YFStudentFilterStateModel *model = [[YFStudentFilterStateModel alloc] initWithDictionary:nil];
        model.edgeInsets = UIEdgeInsetsMake(0, YFCellBeginGap, 0, 0);
        _stateModel= model;
    }
    return _stateModel;
}

-(YFStudentFilterGenderModel *)genderModel
{
    if (!_genderModel)
    {
        YFStudentFilterGenderModel *model = [[YFStudentFilterGenderModel alloc] initWithDictionary:nil];
        model.edgeInsets = UIEdgeInsetsMake(0, YFCellBeginGap, 0, 0);
        _genderModel= model;
    }
    return _genderModel;
}


- (YFStudentFilterTimeModel *)timeModel
{
    if (!_timeModel) {
        YFStudentFilterTimeModel *model2 = [[YFStudentFilterTimeModel alloc] initWithDictionary:nil];
        _timeModel = model2;
        _timeModel.edgeInsets = UIEdgeInsetsMake(0, YFCellBeginGap, 0, 0);
    
    }

    return _timeModel;
}

- (YFStudentFilterBirthdayModel *)birthdayModel
{
    if (!_birthdayModel) {
        YFStudentFilterBirthdayModel *model2 = [[YFStudentFilterBirthdayModel alloc] initWithDictionary:nil];
        _birthdayModel = model2;
        _timeModel.edgeInsets = UIEdgeInsetsMake(0, YFCellBeginGap, 0, 0);
        
    }
    return _birthdayModel;
}

- (YFStudentRightDataModel *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [[YFStudentRightDataModel alloc] init];
    }
    _dataModel.isFilter = self.isFilter;
    _dataModel.seller_id = self.seller_id;
    return _dataModel;
}


- (YFTBSectionsRePoModel *)sectionReModel
{
    if (!_sectionReModel) {
        YFTBSectionsRePoModel *sectionModel3 = [[YFTBSectionsRePoModel alloc] init];
        sectionModel3.tableView =self.baseTableView;
        sectionModel3.sectionTitle = @"推荐人";
        [sectionModel3 setStudentFilterRePeo];
        
        _sectionReModel = sectionModel3;
    }
    return _sectionReModel;
}


- (YFTBSectionsSellerModel *)sectionSellerModel
{
    if (!_sectionSellerModel) {
        
        YFTBSectionsSellerModel *sectionModel3 = [[YFTBSectionsSellerModel alloc] init];
        sectionModel3.tableView =self.baseTableView;
        sectionModel3.sectionTitle = @"销售";
        [sectionModel3 setStudentFilterRePeo];

        _sectionSellerModel = sectionModel3;
    }
    return _sectionSellerModel;
}

- (YFTBSectionsRePoModel *)sectionoriModel
{
    if (!_sectionoriModel) {
        YFTBSectionsRePoModel *sectionModel3 = [[YFTBSectionsRePoModel alloc] init];
        sectionModel3.tableView =self.baseTableView;
        sectionModel3.sectionTitle = @"来源";
        [sectionModel3 setStudentFilterRePeo];
        
        _sectionoriModel = sectionModel3;
    }
    return _sectionoriModel;
}

- (NSMutableDictionary *)allOrigDic
{
    if (!_allOrigDic) {
        _allOrigDic = [NSMutableDictionary dictionary];
    }
    return _allOrigDic;
}

-(void)setAllOrigDic:(NSMutableDictionary *)allOrigDic
{
    _allOrigDic = [NSMutableDictionary dictionaryWithDictionary:allOrigDic];
    [self setCheckOriSelected];
    [self.baseTableView reloadData];
}

-(void)setCheckOriSelected
{
    self.selectModel.isSelected = NO;
    
    for (YFStudentFilterOriginModel *model in self.dataModel.oriArray)
    {
        if ([model isKindOfClass:[YFStudentFilterOriginModel class]])
        {
            if ([self.allOrigDic objectForKey:model.o_id])
            {
                model.isSelected = YES;
                self.selectModel = model;
                
                //                break;
            }else
            {
                model.isSelected = NO;
            }
        }
    }
}

-(void)setAllRecoDic:(NSMutableDictionary *)allRecoDic
{
    _allRecoDic = [NSMutableDictionary dictionaryWithDictionary:allRecoDic];
    [self setCheckrecoSelected];
    [self.baseTableView reloadData];
}

-(void)setCheckrecoSelected
{
    self.selectReModel.isSelected = NO;
    
    for (YFStudentFilterRePeoModel *model in self.dataModel.reArray)
    {
        if ([model isKindOfClass:[YFStudentFilterRePeoModel class]])
        {
            if ([self.allRecoDic objectForKey:model.r_id])
            {
                model.isSelected = YES;
                self.selectReModel = model;
            }
            else
            {
                model.isSelected = NO;
            }
        }
    }
}

- (void)checkSellerIdSelect
{
    for (YFSellerModel *model in self.sellerDataModel.dataMOdel.listArray) {
        if (!self.filterModel.seller_id && model.s_id == nil)
        {
            self.sectionSellerModel.sellerCModel.selelctModel.isSelected = NO;
            model.isSelected = YES;
            self.sectionSellerModel.sellerCModel.selelctModel = model;
        }else   if (self.filterModel.seller_id && model.s_id &&  [self.filterModel.seller_id isEqualToString:model.s_id])
        {
            self.sectionSellerModel.sellerCModel.selelctModel.isSelected = NO;
            model.isSelected = YES;
            self.sectionSellerModel.sellerCModel.selelctModel = model;
        }
    }
}



- (NSMutableDictionary *)allRecoDic
{
    if (!_allRecoDic) {
        _allRecoDic = [NSMutableDictionary dictionary];
    }
    return _allRecoDic;
}

-(YFSellerDataModel *)sellerDataModel
{
    if (!_sellerDataModel)
    {
        _sellerDataModel = [[YFSellerDataModel alloc] init];
    }
    return _sellerDataModel;
}

- (BOOL)isCanFilterSeller
{
    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone) {
        return NO;
    }
    
    return _isCanFilterSeller;
}

@end
