//
//  MyStudentController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MyStudentController.h"

#import "MyStudentCell.h"

#import "MyStudentInfo.h"

#import "RootController.h"

#import "AddStudentController.h"

#import "AddressBookController.h"

#import "StudentDetailController.h"

#import "ChangeGymController.h"

#import "WebViewController.h"

#import "AppDelegate.h"

#import "PermissionInfo.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

static NSString *titleIdentifier = @"Title";

@interface MyStudentController ()<MOTableViewDatasource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)MyStudentInfo *studentInfo;

@property(nonatomic,strong)UIView *searchView;

@property(nonatomic,strong)UIView *addView;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)NSArray *showArray;

@end

@implementation MyStudentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    
    self.studentInfo = [[MyStudentInfo alloc]init];
    
    [self.studentInfo requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            [self.studentInfo getShowArraySearchText:self.searchBar.text];
            
            self.showArray = self.studentInfo.showArray;
            
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)createData
{
    
    [self reloadData];
    
}


-(void)createUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.rightType = MONaviRightTypeAdd;
    
    self.rightSubType = MONaviRightSubTypeSearch;
    
    self.title = @"会员";
    
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
    
    self.searchView.backgroundColor = kMainColor;
    
    [self.view addSubview:self.searchView];
    
    self.searchView.hidden = YES;
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(7), 23, Width320(257), 37)];
    
    [self.searchView addSubview:self.searchBar];
    
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.masksToBounds = YES;
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 37, self.searchBar.height)];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(17, 11, 16, 16)];
    
    searchImg.image = [UIImage imageNamed:@"search"];
    
    [leftView addSubview:searchImg];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder = @"搜索学员";
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    clearButton.frame = CGRectMake(self.searchBar.right-30, 0, 30, self.searchBar.height);
    
    self.searchBar.rightView = clearButton;
    
    UIImageView *clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(3, 0, 12, 12)];
    
    clearImg.image = [UIImage imageNamed:@"clear"];
    
    clearImg.center = CGPointMake(clearImg.center.x, clearButton.height/2);
    
    [clearButton addSubview:clearImg];
    
    [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchBar addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancel.frame = CGRectMake(self.searchBar.right, 20, MSW-self.searchBar.right, 64-20);
    
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancel setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    cancel.backgroundColor = [UIColor clearColor];
    
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchView addSubview:cancel];

    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
        
    self.tableView.tag = 101;
    
    self.tableView.allowsSelection = YES;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(80.4), 0, 0);
    
    self.tableView.separatorColor = UIColorFromRGB(0xeeeeee);
    
    [self.tableView registerClass:[MyStudentCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
    self.addView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    [self.addView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addTap:)]];
    
    [self.view addSubview:self.addView];
    
    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(MSW-Width320(150), 0, Width320(149), Height320(88))];
    
    addView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    addView.layer.shadowOffset = CGSizeMake(0, 2);
    
    addView.backgroundColor = UIColorFromRGB(0xfafafa);
    
    addView.layer.shadowOpacity = 0.3;
    
     addView.layer.cornerRadius = 2;
    
    [self.addView addSubview:addView];
    
    UIButton *singleAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    
    singleAdd.frame = CGRectMake(0, 0, addView.width, addView.height/2);
    
    [singleAdd setTitle:@"手动添加学员" forState:UIControlStateNormal];
    
    singleAdd.titleLabel.font =  AllFont(16);
    
    [singleAdd setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    
    [singleAdd addTarget:self action:@selector(singleAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    [addView addSubview:singleAdd];
    
    UIButton *batchAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    
    batchAdd.frame = CGRectMake(0, addView.height/2, addView.width, addView.height/2);
    
    [batchAdd setTitle:@"从通讯录添加" forState:UIControlStateNormal];
    
    batchAdd.titleLabel.font =  AllFont(16);
    
    [batchAdd setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    
    [batchAdd addTarget:self action:@selector(batchAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    [addView addSubview:batchAdd];
    
    self.addView.hidden = YES;
    
}

-(void)clear:(UIButton*)btn
{
    
    self.searchBar.text = @"";
    
    [self textFieldDidChanged:self.searchBar];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField.text.length) {
        
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
        
    }else
    {
        
        self.searchBar.rightViewMode = UITextFieldViewModeNever;
        
    }
    
    [self.studentInfo getShowArraySearchText:self.searchBar.text];
    
    self.showArray = self.studentInfo.showArray;
    
    [self.tableView reloadData];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)naviRightSubClick
{
    
    self.searchView.hidden = NO;
    
    self.addView.hidden = YES;
    
    [self.view bringSubviewToFront:self.searchView];
    
}

-(void)cancel:(UIButton*)btn
{
    
    [self.searchBar resignFirstResponder];
    
    self.searchView.hidden = YES;
    
    self.searchBar.text = @"";
    
    [self.studentInfo getShowArraySearchText:self.searchBar.text];
    
    self.showArray = self.studentInfo.showArray;
    
    [self.tableView reloadData];
    
}

-(void)addTap:(UITapGestureRecognizer*)tap
{
    
    self.addView.hidden = YES;
    
}

-(void)singleAdd:(UIButton*)btn
{
    
    self.addView.hidden = YES;
    
    AddStudentController *svc = [[AddStudentController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)batchAdd:(UIButton*)btn
{
    
    self.addView.hidden = YES;
    
    self.addView.hidden = YES;
    
    AddressBookController *svc = [[AddressBookController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)naviRightClick
{
    
    self.addView.hidden = !self.addView.hidden;
    
    [self.view bringSubviewToFront:self.addView];
    
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.showArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:obj[@"head"]];
        
    }];
    
    return array;
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-20-Height320(49))];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(75.5), MSW/3, MSW/3)];
    
    emptyImg.image = [UIImage imageNamed:@"stuempty"];
    
    [view addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, emptyImg.bottom+Height320(19.5), MSW-40, Height320(39))];
    
    emptyLabel.numberOfLines = 0;
    
    emptyLabel.textColor = UIColorFromRGB(0x747474);
    
    emptyLabel.font = AllFont(14);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:emptyLabel];
    
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addbutton.frame = CGRectMake(Width320(75.5), emptyLabel.bottom+Height320(19.5), MSW-Width320(151), Height320(42.7));
    
    addbutton.backgroundColor = kMainColor;
    
    [addbutton setTitle:@"添加学员" forState:UIControlStateNormal];
    
    [addbutton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addbutton.titleLabel.font = AllFont(17);
    
    addbutton.tag = 201;
    
    [addbutton addTarget:self action:@selector(singleAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:addbutton];
    
    if (self.searchBar.text.length) {
        
        emptyLabel.text = @"没有找到相关学员\n你可以添加该学员";
        
        emptyImg.hidden = YES;
        
        addbutton.hidden = NO;
        
        [emptyLabel changeTop:Height320(40)];
        
        [addbutton changeTop:emptyLabel.bottom+Height320(27)];
        
    }else
    {
        
        emptyLabel.text = @"暂无学员";
        
        emptyImg.hidden = NO;
        
        addbutton.hidden = YES;
        
        [emptyLabel changeTop:emptyImg.bottom+Height320(19.5)];
        
        [addbutton changeTop:emptyLabel.bottom+Height320(19.5)];
        
    }
    
    return view;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.showArray.count;
        
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.showArray count]) {
        
        return [[self.showArray[section] valueForKey:@"data"]count];
        
    }else{
        
        return 0;
        
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Student *stu = [self.showArray[indexPath.section] valueForKey:@"data"][indexPath.row];
    
    cell.title = stu.name;
    
    cell.phone = stu.phone;
    
    cell.gender = stu.gender;
    
    cell.imgUrl = stu.photo;
    
    cell.gymName = stu.gym.name;
    
    cell.borderColor = stu.gym.color;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(84);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(24.8);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(24.8))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(29.3), 0, Width320(200), header.height)];
    
    label.text = [self.showArray[section] valueForKey:@"head"];
    
    label.textColor = UIColorFromRGB(0xFF5252);
    
    label.font = AllFont(15);
    
    [header addSubview:label];
    
    return header;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StudentDetailController *svc = [[StudentDetailController alloc]init];
    
    svc.student =[self.showArray[indexPath.section] valueForKey:@"data"][indexPath.row];
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    [self.searchBar resignFirstResponder];
    
}


@end
