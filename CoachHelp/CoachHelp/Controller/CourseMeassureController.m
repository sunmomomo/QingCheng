//
//  CourseMeassureController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseMeassureController.h"

#import "CourseMeassureCell.h"

#import "CourseMeassureInfo.h"

#import "MOTableView.h"

#import "WebViewController.h"

static NSString *identifier = @"Cell";

@interface CourseMeassureController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CourseMeassureInfo *info;

@property(nonatomic,strong)UIView *emptyView;

@end

@implementation CourseMeassureController

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
    
    self.emptyView.hidden = self.info.meassures.count != 0;
    
    self.info = [[CourseMeassureInfo alloc]init];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            self.emptyView.hidden = self.info.meassures.count != 0;
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.chooseFinish?@"选择默认课程计划":@"课件";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(36))];
    
    [self.view addSubview:header];
    
    UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(14), Height320(14))];
    
    hintImg.image = [UIImage imageNamed:@"hint_circle"];
    
    [header addSubview:hintImg];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(hintImg.right+Width320(6), 0, MSW-Width320(22)-hintImg.right, Height320(36))];
    
    hintLabel.text = @"APP端暂时不支持添加课程计划模板";
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.font = AllFont(12);
    
    [header addSubview:hintLabel];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, header.bottom, MSW, MSH-header.bottom)];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CourseMeassureCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    self.emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.emptyView.hidden = YES;
    
    [self.view addSubview:self.emptyView];
    
    self.emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(73), Height320(84), Width320(174), Height320(146))];
    
    emptyImg.image = [UIImage imageNamed:@"report_empty"];
    
    [self.emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(60))];
    
    emptyLabel.text = @"您还没有任何课程计划模板\n请到网页后台进行添加\nhttp://cloud.qingchengfit.cn/...";
    
    emptyLabel.numberOfLines = 3;
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [self.emptyView addSubview:emptyLabel];
    
    UIButton *copyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(64), emptyLabel.bottom+Height320(8), Width320(128), Height320(21))];
    
    [copyButton setTitle:@"复制链接到剪贴板" forState:UIControlStateNormal];
    
    [copyButton setTitleColor:UIColorFromRGB(0x0DB14B) forState:UIControlStateNormal];
    
    [copyButton addTarget:self action:@selector(copyLink) forControlEvents:UIControlEventTouchUpInside];
    
    copyButton.titleLabel.font = AllFont(13);
    
    [self.emptyView addSubview:copyButton];
    
}

-(void)copyLink
{
    
    NSString *link = @"http://cloud.qingchengfit.cn/";
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = link;
    
    [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.chooseFinish) {
        
        return self.info.meassures.count+1;
        
    }else{
        
        return self.info.meassures.count;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseMeassureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (self.chooseFinish) {
        
        if (indexPath.row == 0) {
            
            cell.title = @"不使用任何课程计划模板";
            
            cell.isUnused = YES;
            
            if (!self.course.meassure) {
                
                cell.isChoosed = YES;
                
            }
            
        }else{
            
            CourseMeassure *meassure = self.info.meassures[indexPath.row-1];
            
            cell.title = meassure.name;
            
            cell.subtitle = [meassure tagsDescription];
            
            cell.isUnused = NO;
            
            cell.isChoosed = self.course.meassure && self.course.meassure.meassureId == meassure.meassureId;
            
        }
        
    }else{
        
        CourseMeassure *meassure = self.info.meassures[indexPath.row];
        
        cell.title = meassure.name;
        
        cell.subtitle = [meassure tagsDescription];
        
        cell.isUnused = NO;
        
        cell.isChoosed = NO;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CourseMeassure *meassure;
    
    if (self.chooseFinish) {
        
        if (indexPath.row == 0) {
            
            meassure = nil;
            
        }else{
            
            meassure = self.info.meassures[indexPath.row-1];
            
        }
        
    }else{
        
        meassure = self.info.meassures[indexPath.row];
        
    }
    
    self.course.meassure = meassure;
    
    if (self.chooseFinish) {
        
        self.chooseFinish();
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        svc.url = meassure.url;
        
        __weak typeof(self)weakS = self;
        
        svc.completeAction = ^{
            
            [weakS reloadData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}


@end
