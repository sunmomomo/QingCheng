
//
//  ChatNameController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatNameController.h"

@interface ChatNameController ()

@property(nonatomic,strong)UITextField *nameTF;

@property(nonatomic,copy)NSString *name;

@end

@implementation ChatNameController


-(instancetype)initWithName:(NSString *)name andNameFinishBlock:(void (^)(NSString *))finishBlock
{
    
    self = [super init];
    
    if (self) {
        
        self.nameChange = finishBlock;
        
        self.name = name;
        
    }
    
    return self;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    
    
}

-(void)createUI
{
    
    self.title = @"群聊名称";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(0, Height(15)+64, MSW, Height(50))];
    
    self.nameTF.text = self.name;
    
    self.nameTF.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.nameTF.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.nameTF.layer.borderWidth = OnePX;
    
    self.nameTF.font = AllFont(14);
    
    self.nameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width(15), Height(50))];
    
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:self.nameTF];
    
}

-(void)naviRightClick
{
    
    if (self.nameTF.text.length) {
        
        if (self.nameChange) {
            
            self.nameChange(self.nameTF.text);
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请填写群聊名称" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}


@end
