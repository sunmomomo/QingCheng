//
//  YFSearchResultSellerListBatchVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultSellerListBatchVC.h"

#import "YFSellerResultDataModel.h"

#import "SellerUserBatchEditController.h"

#import "SellerUserEditCell.h"

#import "UIView+YFLoadingView.h"

static NSString *identifier = @"Cell";


@interface YFSearchResultSellerListBatchVC ()

@property(nonatomic, strong)YFSellerResultDataModel *dataModel;

@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation YFSearchResultSellerListBatchVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creatData) name:kPostAddNewSellerIdtifierYF object:nil];
        
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
}

-(void)creatUI
{
    [super creatUI];
    [self.tableView registerClass:[SellerUserEditCell class] forCellReuseIdentifier:identifier];
}

- (void)reloadData
{
    if (self.dataModel.isSuccess )
    {
        self.users = [self dealArray:self.dataModel.dataArray searStr:self.searchStr];
        
        self.tableView.dataSuccess = YES;
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
        [self setTableFootviewLabelNum:self.users.count];
        
    }else
    {
        if (self.dataModel.isLoading == NO)
        {
            [self creatData];
        }
    }
    
}

- (void)creatData
{
    weakTypesYF
    self.dataModel.searchStr = self.searchStr;
    
    [self.dataModel getResponseDatashowLoadingOn:nil Seller:self.seller andGym:self.gym successBlock:^{
        
        weakS.dataArray = weakS.dataModel.dataArray;
        
        weakS.users = [weakS dealArray:weakS.dataModel.dataArray searStr:weakS.searchStr];
        
        if (weakS.searchStr.length) {
            [weakS reloadData];
        }
        
    } failBlock:^{
        [weakS.tableView.mj_header endRefreshing];
        [self.view showHint:@"网络不给力"];
    }];
    
}


#pragma mark TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height320(75);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.users.count <= indexPath.row) {
        return;
    }
    
    Student *user = self.users[indexPath.row];
    
    BOOL contains = NO;
    
    for (Student *tempUser in self.chooseArray()) {
        
        if (user.stuId == tempUser.stuId) {
            
            contains = YES;
            
            [self.chooseArray() removeObject:tempUser];
            
            break;
            
        }
        
    }
    
    if (!contains) {
        
        [self.chooseArray() addObject:user];
        
    }
    
    [self.tableView reloadData];
    
    if (self.sellerBatchEditVC) {
        
        [self.sellerBatchEditVC.tableView reloadData];
        
        [self.sellerBatchEditVC.chooseView reloadData];
        
        [self.sellerBatchEditVC checkFunc];
        
    }else{
        
        [self.coachBatchEditVC.tableView reloadData];
        
        [self.coachBatchEditVC.chooseView reloadData];
        
        [self.coachBatchEditVC checkFunc];
        
    }
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SellerUserEditCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    Student *stu = self.users[indexPath.row];
    
    cell.title = stu.name;
    
    cell.phone = stu.phone;
    
    cell.sex = stu.sex;
    
    cell.imgUrl = stu.avatar;
    
    NSString *sellers = @"";
    
    for (NSInteger i = 0; i<stu.sellers.count; i++) {
        
        Seller *tempSeller = stu.sellers[i];
        
        if (tempSeller.name.length) {
            
            sellers = [sellers stringByAppendingString:tempSeller.name];
            
        }
        
        if (i<stu.sellers.count-1) {
            
            sellers = [sellers stringByAppendingString:@"，"];
            
        }
        
    }
    
    cell.sellers = sellers;
    
    cell.userType = stu.type;
    
    BOOL contains = NO;
    
    for (Student *tempUser in self.chooseArray()) {
        
        if (tempUser.stuId == stu.stuId) {
            
            contains = YES;
            
            break;
            
        }
        
    }
    
    cell.choosed = contains;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
    
    
}

- (YFSellerResultDataModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[YFSellerResultDataModel alloc] init];
    }
    _dataModel.isChooseStudent = self.isChooseStudent;
    return _dataModel;
}

@end
