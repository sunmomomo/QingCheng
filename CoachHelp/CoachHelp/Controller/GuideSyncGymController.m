//
//  GuideSyncGymController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideSyncGymController.h"

#import "GuideGymCell.h"

#import "Gym.h"

#import "RootController.h"

static NSString *identifier = @"Cell";

@interface GuideSyncGymController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIActivityIndicatorView *loadingView;

@property(nonatomic,strong)UILabel *loadingLabel;

@property(nonatomic,strong)UIButton *enterButton;

@end

@implementation GuideSyncGymController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self createUI];

    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.loadingView.hidden = YES;
        
        self.loadingLabel.hidden = YES;
        
        self.enterButton.hidden = NO;
        
    });
    
}

-(void)createUI
{
    
    self.title = @"同步健身房";
    
    self.leftType = MONaviLeftTypeNO;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[GuideGymCell class] forCellReuseIdentifier:identifier];
    
    UILabel *tableHeader = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(68))];
    
    tableHeader.text = [NSString stringWithFormat:@"检测到您是以下%ld家健身房的教练\n系统会自动同步健身房数据",(unsigned long)self.gyms.count];
    
    tableHeader.textColor = UIColorFromRGB(0x333333);
    
    tableHeader.textAlignment = NSTextAlignmentCenter;
    
    tableHeader.numberOfLines = 0;
    
    tableHeader.font = AllFont(14);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UIView *tableFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(74))];
    
    self.tableView.tableFooterView = tableFooter;
    
    self.loadingView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(Width320(96), Height320(24), Width320(20), Height320(20))];
    
    [self.loadingView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    [self.loadingView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    [self.loadingView startAnimating];
    
    [tableFooter addSubview:self.loadingView];
    
    self.loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.loadingView.right+Width320(8), Height320(24), Width320(180), Height320(20))];
    
    self.loadingLabel.text = @"正在同步数据，请稍后";
    
    self.loadingLabel.textColor = UIColorFromRGB(0x333333);
    
    self.loadingLabel.font = AllFont(14);
    
    [tableFooter addSubview:self.loadingLabel];
    
    self.enterButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(15), Height320(15), MSW-Width320(30), Height320(44))];
    
    self.enterButton.backgroundColor = kMainColor;
    
    self.enterButton.layer.cornerRadius = 2;
    
    [self.enterButton setTitle:@"查看我的课程" forState:UIControlStateNormal];
    
    [self.enterButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.enterButton.titleLabel.font = AllFont(16);
    
    [self.enterButton addTarget:self action:@selector(enterRoot) forControlEvents:UIControlEventTouchUpInside];
    
    self.enterButton.hidden = YES;
    
    [tableFooter addSubview:self.enterButton];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.gyms.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(64);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuideGymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.gyms[indexPath.row];
    
    cell.title = gym.name;
    
    cell.subtitle = gym.brand.name;
    
    cell.imageUrl = gym.imgUrl;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)enterRoot
{
 
    MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
    
    [RootController sharedSliderController].selectIndex = 0;
    
    [RootController sharedSliderController].navigationController.navigationBar.hidden = YES;
    
    [[RootController sharedSliderController] showGuide];
    
    [[RootController sharedSliderController]reloadData];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


@end
