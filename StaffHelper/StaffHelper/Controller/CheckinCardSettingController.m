//
//  CheckinSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinCardSettingController.h"

#import "MOSwitchCell.h"

#import "QCTextFieldCell.h"

#import "KeyboardManager.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CheckinCardSettingController ()<MOTableViewDatasource,UITableViewDelegate,MOSwitchCellDelegate,QCTextFieldCellDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIView *emptyView;

@end

@implementation CheckinCardSettingController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)dealloc
{
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.tableView.dataSuccess = YES;
    
    if (!self.info) {
        
        self.info = [[CheckinSettingInfo alloc]init];
        
        [self.info requestCardKindsResult:^(BOOL success, NSString *error) {
            
            [self.tableView reloadData];
            
            self.emptyView.hidden = self.info.cardKinds.count;
            
        }];
        
    }else{
        
        [self.tableView reloadData];
        
        self.emptyView.hidden = self.info.cardKinds.count;
        
    }
    
}

-(void)createUI
{
    
    self.title = @"签到设置";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[QCTextFieldCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    self.tableView.tableHeaderView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    self.emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(118), Width320(185), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"card_empty"];
    
    [self.emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), self.emptyView.width, Height320(16))];
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.text = @"没有可用的会员卡种类";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textAlignment  = NSTextAlignmentCenter;
    
    [self.emptyView addSubview:emptyLabel];
    
    [self.view addSubview:self.emptyView];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    MOSwitchCell *cell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    cell.titleLabel.textColor = UIColorFromRGB(0x666666);
    
    cell.backgroundColor = UIColorFromRGB(0xffffff);
    
    CardKind *cardKind = self.info.cardKinds[section];
    
    cell.titleLabel.text = cardKind.cardKindName;
    
    cell.on = cardKind.isUsed;
    
    [header addSubview:cell];
    
    UIView *topSep = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1/[UIScreen mainScreen].scale)];
    
    topSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:topSep];
    
    UIView *bottomSep = [[UIView alloc]initWithFrame:CGRectMake(cardKind.isUsed&&cardKind.type!=CardKindTypeTime?Width320(16):0, cell.height-1/[UIScreen mainScreen].scale, cardKind.isUsed?cell.width-Width320(32):MSW, 1/[UIScreen mainScreen].scale)];
    
    bottomSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:bottomSep];
    
    cell.delegate = self;
    
    cell.tag = section;
    
    return header;
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    CardKind *cardKind = self.info.cardKinds[cell.tag];
    
    cardKind.isUsed = cell.on;
    
    [self.tableView reloadData];
    
    [self reloadSetting];
    
    if (cell.on) {
        
        QCTextFieldCell *tfCell = (QCTextFieldCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:cell.tag]];
        
        [tfCell becomeFirstResponder];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return Height320(12);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, -1/[UIScreen mainScreen].scale, MSW, 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [footer addSubview:sep];
    
    return footer;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(40);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QCTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardKind *cardKind = self.info.cardKinds[indexPath.section];
    
    cell.textField.mustInput = YES;
    
    cell.textField.text  = cardKind.costString;
    
    cell.textField.noLine = YES;
    
    cell.textField.placeholder = cardKind.type == CardKindTypePrepaid?@"每人每次签到费用（元）":@"每人每次签到费用（次）";
    
    cell.indexPath = indexPath;
    
    cell.delegate = self;
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.info.cardKinds.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    CardKind *cardKind = self.info.cardKinds[section];
    
    return cardKind.type == CardKindTypeTime?0:cardKind.isUsed?1:0;
    
}


-(void)cell:(QCTextFieldCell *)cell textFieldDidChanged:(NSString *)string
{
    
    CardKind *cardKind = self.info.cardKinds[cell.indexPath.section];
    
    cardKind.cost = [string integerValue];
    
    cardKind.costString = string;
    
    [self reloadSetting];
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}

-(void)reloadSetting
{
    
    for (MOViewController *vc in self.navigationController.viewControllers) {
        
        if ([NSStringFromClass([vc class])isEqualToString:@"CheckinWaySettingController"]) {
            
            [vc reloadData];
            
        }
        
    }
    
}


@end
