//
//  CardKindListGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindListGymController.h"

#import "CardKindCell.h"

#import "MOTableView.h"

#import "ChooseView.h"

#import "CardKindEditController.h"

#import "CardKindDetailController.h"

#import "CardKindListInfo.h"

#import "ChangeGymController.h"

#import "QCLoadingHUD.h"

#import "CardKindGymHeader.h"

static NSString *identifier = @"Cell";

@interface CardKindListGymController ()<UITableViewDelegate,MOTableViewDatasource,ChooseViewDatasource,UIActionSheetDelegate,CardKindGymHeaderDelegate>

@property(nonatomic,strong)CardKindListInfo *info;

@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,assign)CardKindState state;

@property(nonatomic,strong)NSMutableArray *headers;

@end

@implementation CardKindListGymController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.headers = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    CardKindListInfo *info = [[CardKindListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CardKindListInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        weakS.info = weakInfo;
        
        [weakS.chooseView reloadTableViewDataWithSuccess:success];
        
        [weakS reloadHeader];
        
    };
    
    [info requestWithGym:self.gym];
    
}

-(void)reloadData
{
    
    CardKindListInfo *info = [[CardKindListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CardKindListInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        weakS.info = weakInfo;
        
        [weakS.chooseView reloadTableViewDataWithSuccess:success];
        
        [weakS reloadHeader];
        
    };
    
    [info requestWithGym:self.gym];
    
}

-(void)createUI
{
    
    self.titleType = MONaviTitleTypeLabel;
    
    self.rightType = MONaviRightTypeAdd;
    
    self.title = @"会员卡种类";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.chooseView = [[ChooseView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.chooseView.rowHeight = Height320(40);
    
    self.chooseView.rowWidth = MSW/4;
    
    self.chooseView.datasource = self;
    
    [self.view addSubview:self.chooseView];
    
}

-(void)reloadHeader
{
    
    for (NSInteger i = 0; i<4; i++) {
        
        CardKindGymHeader *header = self.headers[i];
        
        header.count = [self.info getShowArrayWithType:i andState:self.state andGym:nil].count;
        
        header.state = self.state;
        
    }
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return 4;
    
}

-(NSString *)titleForButtonAtRow:(NSInteger)row
{
    
    return @[@"全部类型",@"储值卡",@"次卡",@"期限卡"][row];
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
    
    view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    CardKindGymHeader *header = [[CardKindGymHeader alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    header.delegate = self;
    
    [view addSubview:header];
    
    if (![self.headers containsObject:header]) {
        
        [self.headers addObject:header];
        
    }
    
    MOTableView *tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, Height320(40), MSW, view.height-Height320(40)) style:UITableViewStylePlain];
    
    tableView.tag = row;
    
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.tableFooterView = [UIView new];
    
    [tableView registerClass:[CardKindCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [mjHeader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [mjHeader setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [mjHeader setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    mjHeader.stateLabel.textColor = [UIColor blackColor];
    
    tableView.mj_header = mjHeader;
    
    [view addSubview:tableView];
    
    return view;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.info getShowArrayWithType:tableView.tag andState:self.state andGym:nil].count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKind *kind = [self.info getShowArrayWithType:tableView.tag andState:self.state andGym:nil][indexPath.row];
    
    NSString *gymStr = @"适用场馆：";
    
    for (NSInteger i = 0; i<kind.gyms.count; i++) {
        
        Gym *gym = kind.gyms[i];
        
        gymStr = [gymStr stringByAppendingString:gym.name];
        
        if (i<kind.gyms.count-1) {
            
            gymStr = [gymStr stringByAppendingString:@"，"];
            
        }
        
    }
    
    NSString *astrictStr = kind.astrict.length?[NSString stringWithFormat:@"限制：%@",kind.astrict]:@"限制：无";
    
    CGSize size = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    CGSize astrictSize = [astrictStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    return Height320(148)+size.height+astrictSize.height;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKindCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardKind *kind = [self.info getShowArrayWithType:tableView.tag andState:self.state andGym:nil][indexPath.row];
    
    cell.cardKindType = kind.type;
    
    cell.cardKindName = kind.cardKindName;
    
    cell.cardId = kind.cardKindId;
    
    cell.astrict = kind.astrict;
    
    cell.summary = kind.summary;
    
    cell.gyms = kind.gyms;
    
    cell.backColor = kind.color;
    
    cell.state = kind.state;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)filterCardKindState
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"正常",@"已停用", nil];
    
    actionSheet.tag = 102;
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex != 2) {
        
        self.state = buttonIndex;
        
        [self.chooseView reloadTableViewDataWithSuccess:YES];
        
        [self reloadHeader];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKindDetailController *svc = [[CardKindDetailController alloc]init];
    
    svc.cardKind = [self.info getShowArrayWithType:tableView.tag andState:self.state andGym:nil][indexPath.row];
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)naviRightClick
{
    
    if ([PermissionInfo sharedInfo].permissions.cardKindPermission.addState) {
        
        CardKindEditController *svc = [[CardKindEditController alloc]init];
        
        svc.isAdd = YES;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS createData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIScrollView *emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40))];
    
    emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(72), Width320(185), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"card_kind_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(18))];
    
    emptyLabel.text = tableView.tag == 0?@"未添加任何会员卡种类":@"未添加该类型会员卡种类";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(14);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}


@end
