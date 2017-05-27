//
//  GymGuideController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymGuideController.h"

@interface GymGuideController ()

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation GymGuideController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    NSArray *imgArray = @[];
    
    for (NSInteger i = 0;i<imgArray.count;i++) {
        
        NSString *imgName = imgArray[i];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*MSW, 0, MSW, self.scrollView.height)];
        
        imgView.image = [UIImage imageNamed:imgName];
        
        [self.scrollView addSubview:imgView];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.scrollView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.scrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.scrollView];
    
}


@end
