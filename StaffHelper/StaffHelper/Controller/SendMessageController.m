//
//  SendMessageController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SendMessageController.h"

#import "QCTextFieldCell.h"

#import <MessageUI/MessageUI.h>

static NSString *identifier = @"Cell";

@interface SendMessageController ()<QCTextFieldCellDelegate,UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *textArray;

@end

@implementation SendMessageController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.textArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createUI
{
    
    self.title = @"群发短信";
    
    self.rightType = MONaviRightTypeAdd;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[QCTextFieldCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    UIButton *quitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(40))];
    
    quitButton.backgroundColor = kMainColor;
    
    [quitButton setTitle:@"发送" forState:UIControlStateNormal];
    
    [quitButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    quitButton.titleLabel.font = AllFont(14);
    
    [self.tableView.tableFooterView addSubview:quitButton];
    
    [quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.textArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return Height320(44);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QCTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.textField.text = self.textArray[indexPath.row];
    
    cell.delegate = self;
    
    cell.tag = indexPath.row;
    
    return cell;
    
}

-(void)cell:(QCTextFieldCell *)cell textFieldDidChanged:(NSString *)string
{
    
    [self.textArray replaceObjectAtIndex:cell.tag withObject:string];
    
}

-(void)naviRightClick
{
    
    [self.textArray addObject:@""];
    
    [self.tableView reloadData];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    
}

-(void)quit
{
    
    if (self.textArray.count) {
        
        [self showMessageView:self.textArray title:@"title" body:@"短信"];
        
    }
    
}

@end
