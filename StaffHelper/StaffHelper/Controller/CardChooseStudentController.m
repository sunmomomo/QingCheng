//
//  CardChooseStudentController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardChooseStudentController.h"

#import "StudentChooseCell.h"

#import "StudentListInfo.h"

#import "CardCreateChooseSpecController.h"

#import "StudentEditController.h"

#import "MOTableView.h"

#import "StudentDeleteCell.h"

#import "CardDetailInfo.h"

#import "CardDetailController.h"

#import "QCLoadingHUD.h"

#import "CardListController.h"

#import "StudentDetailController.h"

#import "UserChooseView.h"

static NSString *identifier = @"Cell";

static NSString *deleteIdentifier = @"Delete";

@interface CardChooseStudentController ()<UITableViewDelegate,MOTableViewDatasource,StudentDeleteCellDelegate,UITextFieldDelegate,UserChooseViewDatasource>

@property(nonatomic,strong)StudentListInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSMutableArray *chooseArray;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)NSMutableArray *otherStudentArray;

@property(nonatomic,strong)UIView *funcView;

@property(nonatomic,strong)UILabel *numLabel;

@property(nonatomic,strong)UserChooseView *chooseView;

@end

@implementation CardChooseStudentController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.otherStudentArray = [NSMutableArray array];
        
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
    
    self.chooseArray = [NSMutableArray array];
    
    if (self.student) {
        
        [self.chooseArray addObject:self.student];
        
        [self.chooseView reloadData];
        
        [self checkFunc];
        
    }
    
    self.info = [[StudentListInfo alloc]init];
    
    [self.info requestCardStudentWithGym:self.gym andIsEdit:self.isEdit success:^{
        
        self.tableView.dataSuccess = YES;
        
        if (self.isEdit) {
            
            for (Student *stu in self.card.users) {
                
                BOOL contains = NO;
                
                for (Student *localStu in self.info.students) {
                    
                    if (stu.stuId == localStu.stuId) {
                        
                        contains = YES;
                        
                        [self.chooseArray addObject:localStu];
                        
                        break;
                        
                    }
                    
                }
                
                if (!contains) {
                    
                    [self.otherStudentArray addObject:stu];
                    
                }
                
            }
            
        }
        
        [self.chooseView reloadData];
        
        [self.tableView reloadData];
        
        [self checkFunc];
        
    } Failure:^{
        
        self.tableView.dataSuccess = NO;
        
    }];
    
}

-(void)reloadData
{
    
    [self.info requestCardStudentWithGym:self.gym andIsEdit:self.isEdit success:^{
        
        if (self.isEdit) {
            
            for (Student *stu in self.card.users) {
                
                BOOL contains = NO;
                
                for (Student *localStu in self.info.students) {
                    
                    if (stu.stuId == localStu.stuId) {
                        
                        contains = YES;
                        
                        [self.chooseArray addObject:localStu];
                        
                        break;
                        
                    }
                    
                }
                
                if (!contains) {
                    
                    [self.otherStudentArray addObject:stu];
                    
                }
                
            }
            
        }
        
        [self.chooseView reloadData];
        
        [self.tableView reloadData];
        
        [self checkFunc];
        
    } Failure:^{
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.isEdit?@"修改绑定会员":self.chooseArray.count?[NSString stringWithFormat:@"添加会员（%ld）",(unsigned long)self.chooseArray.count]:@"添加会员";
    
    
    if (self.isEdit) {
        self.leftType = MONaviLeftTypeTitle;
        self.leftTitle = @"取消";
        self.leftColor = [UIColor whiteColor];
    }
    
    self.rightTitle = self.isEdit?@"完成":@"下一步";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
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
    
    self.tableView.tag = 101;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.allowsSelection = YES;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(110), 0, 0);
    
    [self.tableView registerClass:[StudentChooseCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.funcView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height320(40))];
    
    self.funcView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.funcView.layer.borderWidth = OnePX;
    
    [self.view addSubview:self.funcView];
    
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(118), Height320(10), Width320(20), Height320(20))];
    
    self.numLabel.backgroundColor = kMainColor;
    
    self.numLabel.layer.cornerRadius = self.numLabel.width/2;
    
    self.numLabel.layer.masksToBounds = YES;
    
    self.numLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    
    self.numLabel.font = AllFont(12);
    
    [self.funcView addSubview:self.numLabel];
    
    UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(self.numLabel.right, 0, Width320(60), Height320(40))];
    
    [self.funcView addSubview:showButton];
    
    [showButton addTarget:self action:@selector(showChoose) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(4), 0, Width320(40), Height320(40))];
    
    showLabel.text = @"已选择";
    
    showLabel.textColor = UIColorFromRGB(0x333333);
    
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    showLabel.font = AllFont(12);
    
    [showButton addSubview:showLabel];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(showLabel.right+Width320(3), Height320(17), Width320(12), Height320(7))];
    
    arrowImg.image = [UIImage imageNamed:@"down_arrow"];
    
    arrowImg.transform = CGAffineTransformMakeRotation(M_PI);
    
    [showButton addSubview:arrowImg];
    
    self.chooseView = [[UserChooseView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    self.chooseView.datasource = self;
    
    self.chooseView.hidden = YES;
    
    self.chooseView.tag = 102;
    
    [self.view addSubview:self.chooseView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)addStudent
{
    
    StudentEditController *svc = [[StudentEditController alloc]init];
    
    svc.isAdd = YES;
    
    svc.gym = self.gym;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)showChoose
{
    
    [self.chooseView show];
    
}

-(void)checkFunc
{
    
    if (self.chooseArray.count) {
        
        if (self.chooseArray.count<=99) {
            
            self.numLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.chooseArray.count];
            
        }else{
            
            self.numLabel.text = @"...";
            
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.funcView changeTop:MSH-Height320(40)];
            
        } completion:^(BOOL finished) {
            
            [self.tableView changeHeight:MSH-64-Height320(52)-Height320(40)];
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.funcView changeTop:MSH];
            
        } completion:^(BOOL finished) {
            
            [self.tableView changeHeight:MSH-64-Height320(52)];
            
        }];
        
    }
    
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
    
    if (tableView.tag == 101) {
        
        return self.info.showArray.count;
        
    }else{
        
        return 1;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        return  self.info.showArray.count?[[self.info.showArray[section] valueForKey:@"data"]count]:0;
        
    }else{
        
        return self.chooseArray.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101){
        
        StudentChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        Student *stu = self.info.showArray[indexPath.section][@"data"][indexPath.row];
        
        cell.phone = stu.phone;
        
        cell.name = stu.name;
        
        cell.select = NO;
        
        cell.iconURL = stu.avatar;
        
        for (Student *student in self.chooseArray) {
            
            if (stu.stuId == student.stuId) {
                
                cell.select = YES;
                
            }
            
        }
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }else{
    
        StudentDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:deleteIdentifier];
        
        if (!cell) {
            
            cell = [[StudentDeleteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deleteIdentifier];
            
        }
        
        Student *stu = self.chooseArray[indexPath.row];
        
        cell.phone = stu.phone;
        
        cell.name = stu.name;
        
        cell.iconURL = stu.avatar;
        
        return cell;
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(75);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
    if (tableView.tag == 101) {
        
        return Height320(20);
        
    }else{
        
        return Height320(32);
        
    }
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), header.height)];
        
        label.text = [self.info.showArray[section] valueForKey:@"head"];
        
        label.textColor = UIColorFromRGB(0xFF5252);
        
        label.font = AllFont(12);
        
        [header addSubview:label];
        
        return header;
        
    }else{
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(32))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(150), Height320(32))];
        
        numberLabel.text = [NSString stringWithFormat:@"已选择%ld名会员",(unsigned long)self.chooseArray.count];
        
        numberLabel.textColor = UIColorFromRGB(0x999999);
        
        numberLabel.font = AllFont(12);
        
        [header addSubview:numberLabel];
        
        return header;
        
    }
    
}


-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    if (tableView.tag == 101) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        [self.info.showArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [array addObject:obj[@"head"]];
            
        }];
        
        return array;
        
    }else{
        
        return nil;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        Student *stu = self.info.showArray[indexPath.section][@"data"][indexPath.row];
        
        BOOL contains = NO;
        
        for (Student *tempStu in self.chooseArray) {
            
            if (stu.stuId == tempStu.stuId) {
                
                contains = YES;
                
                [self.chooseArray removeObject:tempStu];
                
                break;
                
            }
            
        }
        
        if (!contains) {
            
            [self.chooseArray addObject:stu];
            
        }
        
        if (!self.isEdit) {
            
            self.title = self.chooseArray.count?[NSString stringWithFormat:@"添加会员（%ld）",(unsigned long)self.chooseArray.count]:@"添加会员";
            
        }
        
        [self.tableView reloadData];
        
        [self.chooseView reloadData];
    
        [self checkFunc];
        
        if (!self.chooseArray.count) {
            
            [self.chooseView close];
            
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)naviRightClick
{
    
    if (!self.isEdit) {
        
        if (!self.chooseArray.count) {
            
            [[[UIAlertView alloc]initWithTitle:@"请添加会员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        CardCreateChooseSpecController *svc = [[CardCreateChooseSpecController alloc]init];
        
        svc.cardKind = self.cardKind;
        
        svc.users = self.chooseArray;
        
        svc.gym = self.gym;
        
        [self.navigationController pushViewController:svc animated:YES];

    }else
    {
        
        if (!self.chooseArray.count&& !self.otherStudentArray.count) {
            
            [[[UIAlertView alloc]initWithTitle:@"至少绑定一个会员，如需停卡请返回进行停卡操作" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.card.users = self.chooseArray;
        
        if (self.otherStudentArray.count) {
            
            self.card.users = [self.chooseArray arrayByAddingObjectsFromArray:self.otherStudentArray];
            
        }
        
        CardDetailInfo *info = [[CardDetailInfo alloc]init];
        
        [info changeCard:self.card withGym:self.gym Result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"修改成功";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CardDetailController class]]) {
                            
                            [vc reloadData];
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                        if ([vc isKindOfClass:[CardListController class]]) {
                            
                            [vc reloadData];
                            
                        }
                        
                        if ([vc isKindOfClass:[StudentDetailController class]]) {
                            
                            [vc reloadData];
                            
                        }
                        
                        
                    }
                    
                });
                
            }else{
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)chooseStudent:(Student *)student
{
    
    [self.chooseArray addObject:student];
    
    if (!self.isEdit) {
        
        self.title = [NSString stringWithFormat:@"添加会员（%ld）",(unsigned long)self.chooseArray.count];
        
    }
    
    [self.tableView reloadData];
    
    [self checkFunc];
    
}

-(void)studentDelete:(UIButton *)button
{
    
    if (button.tag<self.chooseArray.count) {
        
        BOOL canDelete = NO;
        
        Student *stu = [self.chooseArray objectAtIndex:button.tag];
        
        for (Student *tempStu in self.info.students) {
            
            if (stu.stuId == tempStu.stuId) {
                
                canDelete = YES;
                
                break;
                
            }
            
        }
        
        if (canDelete) {
            
            [self.chooseArray removeObjectAtIndex:button.tag];
            
            [self.tableView reloadData];
            
            if (!self.isEdit) {
                
                self.title = self.chooseArray.count?[NSString stringWithFormat:@"添加会员（%ld）",(unsigned long)self.chooseArray.count]:@"添加会员";
                
            }
            
            [self.chooseView reloadData];
            
            if (!self.chooseArray.count) {
                
                [self.chooseView close];
                
            }
            
            [self checkFunc];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"您没有该会员权限，无法删除" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }
    
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

@end
