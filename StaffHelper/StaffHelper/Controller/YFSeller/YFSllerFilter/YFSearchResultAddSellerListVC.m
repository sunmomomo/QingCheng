//
//  YFSearchResultAddSellerListVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultAddSellerListVC.h"


#import "YFSellerResultDataModel.h"

#import "SellerUserAddController.h"

#import "SellerUserEditCell.h"

#import "UIView+YFLoadingView.h"

#import "UserChooseView.h"

static NSString *identifier = @"Cell";


@interface YFSearchResultAddSellerListVC ()
@property(nonatomic, strong)YFSellerResultDataModel *dataModel;

@end

@implementation YFSearchResultAddSellerListVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creatData) name:kPostModifyOrAddStudentIdtifierYF object:nil];

        [self creatData];
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)creatUI
{
    [super creatUI];
    [self.tableView registerClass:[SellerUserEditCell class] forCellReuseIdentifier:identifier];

}

- (void)reloadData
{
    if (self.dataModel.isSuccess)
    {
        [self dealUsers];
        [self setTableFootviewLabelNum:self.users.count];
        [self.tableView reloadData];
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
    self.dataModel.searchStr =self.searchStr;
    
    if (self.coach) {
        
        [self.dataModel getAddCoachResponseDatashowLoadingOn:nil Coach:self.coach andGym:self.gym successBlock:^{
            
            weakS.tableView.dataSuccess = YES;
            
            [weakS.tableView.mj_header endRefreshing];
            
            if (weakS.searchStr) {
                [weakS reloadData];
            }
        } failBlock:^{
            [weakS.tableView.mj_header endRefreshing];
            
            [weakS.view showHint:@"网络不给力"];
        }];
    }else{
        
        [self.dataModel getAddSellerResponseDatashowLoadingOn:nil Seller:self.seller andGym:self.gym successBlock:^{
            
            weakS.tableView.dataSuccess = YES;
            
            [weakS.tableView.mj_header endRefreshing];
            
            if (weakS.searchStr) {
                [weakS reloadData];
            }
        } failBlock:^{
            [weakS.tableView.mj_header endRefreshing];
            
            [weakS.view showHint:@"网络不给力"];
        }];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height320(75);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SellerUserEditCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Student *stu = self.users[indexPath.row];
    
    cell.title = stu.name;
    
    cell.phone = stu.phone;
    
    cell.sex = stu.sex;
    
    cell.imgUrl = stu.avatar;
    
    if (self.coachAddVC) {
        
        NSString *coaches = @"";
        
        for (NSInteger i = 0; i<stu.coaches.count; i++) {
            
            Coach *tempCoach = stu.coaches[i];
            
            if (tempCoach.name.length) {
                
                coaches = [coaches stringByAppendingString:tempCoach.name];
                
            }
            
            if (i<stu.coaches.count-1) {
                
                coaches = [coaches stringByAppendingString:@"，"];
                
            }
            
        }
        
        cell.coaches = coaches;
        
    }else{
        
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
        
    }
    
    cell.userType = stu.type;
    
    
    BOOL chooseable = ![stu.sellersDic objectForKey:self.seller.sellerStrId];
    
    if (chooseable) {
        
        BOOL contains = NO;
        
        for (Student *tempUser in self.chooseArray()) {
            
            if (tempUser.stuId == stu.stuId) {
                
                contains = YES;
                
                break;
                
            }
            
        }
        
        cell.choosed = contains;
        
        cell.unchoosedable = NO;
        
    }else{
        
        cell.choosed = YES;
        
        cell.unchoosedable = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        Student *user = self.users[indexPath.row];
        
        BOOL chooseable = YES;
        
        BOOL contains = NO;
        
        for (Seller *tempSeller in user.sellers) {
            
            if (tempSeller.sellerId == self.seller.sellerId) {
                
                chooseable = NO;
                
                break;
                
            }
            
        }
        
        if (chooseable) {
            
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
            
            if (self.sellerAddVC) {
                
                [self.sellerAddVC.tableView reloadData];
                
                [self.sellerAddVC.chooseView reloadData];
                
                [self.sellerAddVC checkFunc];
                
            }else{
                
                [self.coachAddVC.tableView reloadData];
                
                [self.coachAddVC.chooseView reloadData];
                
                [self.coachAddVC checkFunc];
                
            }
            
        }
}

- (void)setShowAllSwitch:(BOOL)showAllSwitch
{
    _showAllSwitch = showAllSwitch;
    [self dealUsers];
    [self setTableFootviewLabelNum:self.users.count];

}
-(void)dealUsers
{
    NSMutableArray *temUsers = [self dealArray:self.dataModel.dataArray searStr:self.searchStr];

    if (!self.showAllSwitch) {
        
        self.users = temUsers;
        
    }else{
        
        NSMutableArray *users = [NSMutableArray array];
        
        for (Student *student in temUsers) {
            
                if (!student.sellers.count) {
                    
                    [users addObject:student];
                }
        }
        self.users = users;
    }
    [self.tableView reloadData];
}

#pragma mark Getter
- (YFSellerResultDataModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[YFSellerResultDataModel alloc] init];
    }
    return _dataModel;
}

@end
