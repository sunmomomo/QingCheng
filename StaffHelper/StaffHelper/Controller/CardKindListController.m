//
//  CardKindListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindListController.h"

#import "ChangeGymController.h"

#import "CardKindDetailController.h"

#import "CardKindEditController.h"

#import "ChooseView.h"

#import "CardKindCell.h"

#import "CardKindListInfo.h"

#import "QCLoadingHUD.h"

#import "UIImage+Category.h"

#import "MOTableView.h"

#import "CardKindHeader.h"

static NSString *identifier =@"Cell";

@interface CardKindListController ()<ChooseViewDatasource,UITableViewDelegate,MOTableViewDatasource,UIActionSheetDelegate,CardKindHeaderDelegate>

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)CardKindListInfo *info;

@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,assign)CardKindType type;

@property(nonatomic,assign)CardKindState state;

@property(nonatomic,strong)NSMutableArray *headers;

@end

@implementation CardKindListController

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
        
        [weakS reloadHeaderLabel];
        
    };
    
    if (self.gym) {
        
        [info requestWithGym:self.gym];
        
    }else{
        
        [info request];
        
    }
    
}

-(void)reloadHeaderLabel
{
    
    for (NSInteger i = 0;i<3;i++) {
        
        CardKindHeader *header = self.headers[i];
        
        header.count = (i == 0?[[self.info getShowArrayWithType:self.type andState:self.state andGym:self.gym] count]:i == 1?[[self.info getShowArrayWithSingle:NO andType:self.type andState:self.state andGym:self.gym] count]:[[self.info getShowArrayWithSingle:YES andType:self.type andState:self.state andGym:self.gym] count]);
        
        header.type = self.type;
        
        header.state = self.state;
        
    }
    
}

-(void)reloadData
{
    
    CardKindListInfo *info = [[CardKindListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CardKindListInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        weakS.info = weakInfo;
        
        [weakS.chooseView reloadTableViewDataWithSuccess:success];
        
        [weakS reloadHeaderLabel];
        
    };
    
    if (self.gym) {
        
        [info requestWithGym:self.gym];
        
    }else{
        
        [info request];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"全部场馆";
    
    self.titleType = MONaviTitleTypeButton;
    
    self.rightType = MONaviRightTypeAdd;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.chooseView = [[ChooseView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.chooseView.rowHeight = Height320(40);
    
    self.chooseView.rowWidth = MSW/3;
    
    self.chooseView.datasource = self;
    
    [self.view addSubview:self.chooseView];
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return 3;
    
}

-(NSString *)titleForButtonAtRow:(NSInteger)row
{
    
    return @[@"全部",@"多场馆通卡",@"单场馆卡"][row];
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
    
    view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    CardKindHeader *header = [[CardKindHeader alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    header.delegate = self;
    
    [view addSubview:header];
    
    if (![self.headers containsObject:header]) {
        
        [self.headers addObject:header];
        
    }
    
    MOTableView *tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, Height320(40), MSW,view.height-Height320(40)) style:UITableViewStylePlain];
    
    tableView.tag = row;
    
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.tableFooterView = [UIView new];
    
    [tableView registerClass:[CardKindCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    
    [mj_header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [mj_header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [mj_header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    mj_header.stateLabel.textColor = [UIColor blackColor];
    
    tableView.mj_header = mj_header;
    
    [view addSubview:tableView];
    
    return view;
    
}

-(void)filterCardKindState
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"正常",@"已停用", nil];
    
    actionSheet.tag = 102;
    
    [actionSheet showInView:self.view];
    
}

-(void)filterCardKindType
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部类型",@"储值类型",@"次卡类型",@"期限类型", nil];
    
    actionSheet.tag = 101;
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 101) {
        
        if (buttonIndex<4) {
            
            self.type = buttonIndex;
            
            [self.chooseView reloadTableViewDataWithSuccess:YES];
            
            [self reloadHeaderLabel];
            
        }
        
    }else{
        
        if (buttonIndex != 2) {
            
            self.state = buttonIndex;
            
            [self.chooseView reloadTableViewDataWithSuccess:YES];
            
            [self reloadHeaderLabel];
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKind *kind = nil;
    
    if (tableView.tag == 0) {
        
        kind = [self.info getShowArrayWithType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }else if(tableView.tag == 1){
        
        kind = [self.info getShowArrayWithSingle:NO andType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }else{
        
        kind = [self.info getShowArrayWithSingle:YES andType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 0) {
        
        return [[self.info getShowArrayWithType:self.type andState:self.state andGym:self.gym] count];
        
    }else if (tableView.tag == 1){
        
        return [[self.info getShowArrayWithSingle:NO andType:self.type andState:self.state andGym:self.gym] count];
        
    }else
    {
        
        return [[self.info getShowArrayWithSingle:YES andType:self.type andState:self.state andGym:self.gym] count];
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKindCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardKind *kind = nil;
    
    if (tableView.tag == 0) {
        
        kind = [self.info getShowArrayWithType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }else if(tableView.tag == 1){
        
        kind = [self.info getShowArrayWithSingle:NO andType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }else{
        
        kind = [self.info getShowArrayWithSingle:YES andType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }
    
    cell.cardKindType = kind.type;
    
    cell.cardKindName = kind.cardKindName;
    
    cell.cardId = kind.cardKindId;
    
    cell.gyms = kind.gyms;
    
    cell.astrict = kind.astrict;
    
    cell.summary = kind.summary;
    
    cell.backColor = kind.color;

    cell.state = kind.state;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKindDetailController *svc = [[CardKindDetailController alloc]init];
    
    CardKind *kind = nil;
    
    if (tableView.tag == 0) {
        
        kind = [self.info getShowArrayWithType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }else if(tableView.tag == 1){
        
        kind = [self.info getShowArrayWithSingle:NO andType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }else{
        
        kind = [self.info getShowArrayWithSingle:YES andType:self.type andState:self.state andGym:self.gym][indexPath.row];
        
    }
    
    svc.cardKind = kind;
    
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

-(void)naviTitleClick
{
    
    ChangeGymController *svc = [[ChangeGymController alloc]init];
    
    svc.gym = self.gym;
    
    svc.permission = [Permission cardKindPermission];
    
    __weak typeof(self)weakS = self;
    
    svc.changed = ^(Gym *gym){
        
        weakS.title = gym?gym.name:@"全部场馆";
        
        weakS.gym = gym;
        
        [weakS createData];
        
    };
    
    [self presentViewController:svc animated:YES completion:nil];
    
}
@end
