//
//  ChestBorrowChooseStudentController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestBorrowChooseStudentController.h"

#import "StudentCell.h"

#import "StudentListInfo.h"

#import "StudentEditController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface ChestBorrowChooseStudentController ()<UITableViewDelegate,MOTableViewDatasource,UITextFieldDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)StudentListInfo *info;

@end

@implementation ChestBorrowChooseStudentController

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
    
    self.info = [[StudentListInfo alloc]init];
    
    [self.info requestChestStudentWithGym:AppGym success:^{
        
        self.tableView.dataSuccess = YES;
        
        [self.tableView reloadData];
        
    } Failure:^{
        
        self.tableView.dataSuccess = NO;
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择会员";
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(52))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:header];
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(12), Height320(10), Width320(258), Height320(32))];
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    
    self.searchBar.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [header addSubview:self.searchBar];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(30), Height320(32))];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(12), Height320(12))];
    
    searchImg.image = [UIImage imageNamed:@"student_search"];
    
    [leftView addSubview:searchImg];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBar.placeholder = @"会员姓名、手机号";
    
    self.searchBar.font = AllFont(12);
    
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    self.searchBar.delegate = self;
    
    [self.searchBar addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.searchBar.right+Width320(12), Height320(13), Width320(26), Height320(26))];
    
    [addButton setImage:[UIImage imageNamed:@"student_add"] forState:UIControlStateNormal];
    
    [header addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addStudent) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, header.bottom, MSW, MSH-header.bottom) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.allowsSelection = YES;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(110), 0, 0);
    
    [self.tableView registerClass:[StudentCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)addStudent
{
    
    StudentEditController *svc = [[StudentEditController alloc]init];
    
    svc.isAdd = YES;
    
    svc.gym = AppGym;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)textFieldDidChanged:(UITextField*)textField
{
    
    self.info.searchStr = self.searchBar.text;
    
    [self.tableView reloadData];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.info.showArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self.info.showArray.count?[[self.info.showArray[section] valueForKey:@"data"]count]:0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Student *stu = self.info.showArray[indexPath.section][@"data"][indexPath.row];
    
    cell.phone = stu.phone;
    
    cell.title = stu.name;
    
    cell.imgUrl = stu.avatar;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(64);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(24.8);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(25))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(29.3), 0, Width320(200), header.height)];
    
    label.font = AllFont(12);
    
    label.text = [self.info.showArray[section] valueForKey:@"head"];
    
    label.textColor = UIColorFromRGB(0xFF5252);
    
    [header addSubview:label];
    
    return header;
    
}


-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.info.showArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:obj[@"head"]];
        
    }];
    
    return array;
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(75.5), MSW/3, MSW/3)];
    
    emptyImg.image = [UIImage imageNamed:@"stuempty"];
    
    [view addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, emptyImg.bottom+Height320(19.5), MSW-40, Height320(39))];
    
    emptyLabel.numberOfLines = 0;
    
    emptyLabel.textColor = UIColorFromRGB(0x747474);
    
    emptyLabel.font = AllFont(14);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:emptyLabel];
    
    emptyLabel.text = @"暂无会员";
    
    emptyImg.hidden = NO;
    
    [emptyLabel changeTop:emptyImg.bottom+Height320(19.5)];
    
    return view;
    
}

-(void)dealloc
{
    
    self.info.searchStr = @"";
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Student *stu = self.info.showArray[indexPath.section][@"data"][indexPath.row];
    
    if (self.chooseFinish) {
        
        self.chooseFinish(stu);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
