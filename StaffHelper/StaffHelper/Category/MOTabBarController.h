//
//  MOTabBarController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@class MOTabBar;

@interface MOTabBarController : MOViewController

@property(nonatomic,strong)UIView *tabbarShadeView;

@property(nonatomic,strong)NSArray *viewControllers;

@property(nonatomic,strong)UIColor *selectedTitleColor;

@property(nonatomic,strong)UIColor *unselectTitleColor;

@property(nonatomic,assign)NSInteger selectIndex;

-(void)setHaveNew:(BOOL)haveNew atIndex:(NSInteger)index;

-(void)setNewNumber:(NSInteger)number atIndex:(NSInteger)index;

-(void)didSelectIndex:(NSInteger)index;

-(void)selectTheIndex:(NSInteger)index;

@end
