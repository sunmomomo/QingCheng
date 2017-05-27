//
//  MOTabBarController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOTabBarController.h"

@interface MOTabBarButton : UIButton

{
    
    UIView *_point;
    
    UILabel *_numberLabel;
    
}

@property(nonatomic,strong)UILabel *label;

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,assign)BOOL haveNew;

@property(nonatomic,assign)NSInteger number;

@end

@implementation MOTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height-16, self.width, 12)];
        
        _label.textAlignment = NSTextAlignmentCenter;
        
        _label.font = STFont(11);
        
        _label.userInteractionEnabled = NO;
        
        [self addSubview:_label];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2-12, 6, 24, 24)];
        
        _imgView.userInteractionEnabled = NO;
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imgView];
        
        _point = [[UIView alloc]initWithFrame:CGRectMake(_imgView.right+2, 7, 7, 7)];
        
        _point.layer.cornerRadius = _point.width/2;
        
        _point.layer.masksToBounds = YES;
        
        _point.backgroundColor = kDeleteColor;
        
        [self addSubview:_point];
        
        _point.hidden = YES;
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right-6, 3, 20, 20)];
        
        _numberLabel.backgroundColor = kDeleteColor;
        
        _numberLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _numberLabel.layer.borderWidth = 1;
        
        _numberLabel.layer.cornerRadius = _numberLabel.width/2;
        
        _numberLabel.layer.masksToBounds = YES;
        
        _numberLabel.font = STFont(10);
        
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        _numberLabel.textColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:_numberLabel];
        
        _numberLabel.hidden = YES;
        
    }
    return self;
}

-(void)setHaveNew:(BOOL)haveNew
{
    
    _haveNew = haveNew;
    
    _point.hidden = !_haveNew;
    
}

-(void)setNumber:(NSInteger)number
{
    
    _number = number;
    
    _numberLabel.text = [NSString stringWithFormat:@"%ld",(long)MIN(_number, 99)];
    
    _numberLabel.hidden = !_number;
    
}

@end

@protocol MOTabBarDatasource <NSObject>

@required

-(NSInteger)numberOfTabBar;

-(NSString *)titleOfIndex:(NSInteger)index;

-(UIImage *)imageOfUnselectTabAtIndex:(NSInteger)index;

@optional

-(UIImage*)imageOfSelectedTabAtIndex:(NSInteger)index;

@end

@protocol MOTabBarDelegate <NSObject>

-(void)tabBarSelectedIndex:(NSInteger)index;

@end

@interface MOTabBar : UIView

@property(nonatomic,assign)id<MOTabBarDelegate> delegate;

@property(nonatomic,assign)id<MOTabBarDatasource> datasource;

@property(nonatomic,strong)NSMutableArray *buttonArray;

@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *unselectColor;

@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,assign)BOOL haveNew;

-(void)setHaveNew:(BOOL)haveNew atIndex:(NSInteger)index;

+(instancetype)defaultTabBar;

@end

@implementation MOTabBar

+(instancetype)defaultTabBar
{
    
    MOTabBar *tabBar = [[[self class]alloc]initWithFrame:CGRectMake(0, MSH-49, MSW, 49)];
    
    tabBar.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    tabBar.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    tabBar.backgroundColor = UIColorFromRGB(0xffffff);
    
    tabBar.selectedColor = UIColorFromRGB(0xffffff);
    
    tabBar.unselectColor = UIColorFromRGB(0x000000);
    
    return tabBar;
    
}

-(void)setDatasource:(id<MOTabBarDatasource>)datasource
{
    
    _datasource = datasource;
    
    [self load];
    
}

-(void)load
{
    
    [self removeAllView];
    
    self.buttonArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i<[_datasource numberOfTabBar]; i++) {
        
        float width = MSW/[_datasource numberOfTabBar];
        
        MOTabBarButton *button = [[MOTabBarButton alloc]initWithFrame:CGRectMake(i*width, 0, width, self.height)];
        
        button.label.text = [_datasource titleOfIndex:i];
        
        button.imgView.image = [_datasource imageOfUnselectTabAtIndex:i];
        
        button.tag = i;
        
        [self addSubview:button];
        
        [self.buttonArray addObject:button];
        
        [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self setCurrentIndex:_currentIndex];
    
}

-(void)tabBarButtonClick:(MOTabBarButton*)button
{
    
    self.currentIndex = button.tag;
    
    if ([self.delegate respondsToSelector:@selector(tabBarSelectedIndex:)]) {
        
        [self.delegate tabBarSelectedIndex:button.tag];
        
    }
    
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    
    _currentIndex = currentIndex;
    
    for (NSInteger i = 0; i<self.buttonArray.count; i++) {
        
        MOTabBarButton *button = self.buttonArray[i];
        
        if (_currentIndex == i) {
            
            button.imgView.image = [_datasource respondsToSelector:@selector(imageOfSelectedTabAtIndex:)]?[_datasource imageOfSelectedTabAtIndex:i]:[_datasource imageOfUnselectTabAtIndex:i];
            
            button.label.textColor = _selectedColor;
            
        }else
        {
            
            button.imgView.image = [_datasource imageOfUnselectTabAtIndex:i];
            
            button.label.textColor = _unselectColor;
            
        }
        
    }
    
}

-(void)setHaveNew:(BOOL)haveNew atIndex:(NSInteger)index
{
    
    _haveNew = haveNew;
    
    for (MOTabBarButton *button in self.buttonArray) {
        
        if ([self.buttonArray indexOfObject:button] == index) {
            
            button.haveNew = _haveNew;
            
        }
        
    }
    
}

-(void)setNewNumber:(NSInteger)number atIndex:(NSInteger)index
{
    
    for (MOTabBarButton *button in self.buttonArray) {
        
        if ([self.buttonArray indexOfObject:button] == index) {
            
            button.number = number;
            
        }
        
    }
    
}

-(void)setSelectedColor:(UIColor *)selectedColor
{
    
    _selectedColor = selectedColor;
    
    if (_buttonArray.count>_currentIndex) {
        
        MOTabBarButton *button = _buttonArray[_currentIndex];
        
        button.label.textColor = _selectedColor;
        
    }
    
}

-(void)setUnselectColor:(UIColor *)unselectColor
{
    
    _unselectColor = unselectColor;
    
    if (_buttonArray.count) {
        
        for (MOTabBarButton *button in _buttonArray) {
            
            if ([_buttonArray indexOfObject:button] != _currentIndex) {
                
                button.label.textColor = _unselectColor;
                
            }
            
        }
        
    }
    
}

@end

@interface MOTabBarController ()<MOTabBarDatasource,MOTabBarDelegate>

{
    
    UIView *_mainContentView;
    
    CGFloat _changedHeight;
    
}

@property(nonatomic,strong)MOTabBar *tabBar;

@property(nonatomic,strong)UIViewController *mainVC;

@end

@implementation MOTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:_mainContentView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self setMainContentViewController:_viewControllers[_selectIndex]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        self.navigationBarHidden = YES;
        
        self.tabBar = [MOTabBar defaultTabBar];
        
        self.tabbarShadeView = [[UIView alloc]initWithFrame:self.tabBar.frame];
        
        _mainContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, MSH-49)];
        
    }
    return self;
}

-(void)setViewControllers:(NSArray *)viewControllers
{
    
    _viewControllers = viewControllers;
    
    if (self.tabBar.superview) {
        
        [self.tabBar removeFromSuperview];
        
    }
    
    self.tabBar.datasource = self;
    
    self.tabBar.delegate = self;
    
    [self.view addSubview:self.tabBar];
    
    [self.view addSubview:self.tabbarShadeView];
    
    self.tabbarShadeView.hidden = YES;
    
    [self setMainContentViewController:[_viewControllers firstObject]];
    
}

-(void)setMainContentViewController:(UIViewController *)mainVc
{
    
    if (![mainVc isEqual:_mainVC])
    {
        if (_mainVC.view.superview)
        {
            [_mainVC.view removeFromSuperview];
        }
        
        _mainVC = mainVc;
        
        [self addChildViewController:mainVc];
        
        [_mainContentView addSubview:_mainVC.view];
        
    }
    
}

-(void)tabBarSelectedIndex:(NSInteger)index
{
    
    [self setMainContentViewController:_viewControllers[index]];
    
    _selectIndex = index;
    
    [self didSelectIndex:index];
    
}

-(NSInteger)numberOfTabBar
{
    
    return _viewControllers.count;
    
}

-(UIImage *)imageOfUnselectTabAtIndex:(NSInteger)index
{
    
    MOViewController *vc = _viewControllers[index];
    
    return vc.unselectImg;
    
}

-(UIImage *)imageOfSelectedTabAtIndex:(NSInteger)index
{
    
    MOViewController *vc = _viewControllers[index];
    
    return vc.selectedImg;
    
}

-(NSString *)titleOfIndex:(NSInteger)index
{
    
    MOViewController *vc = _viewControllers[index];
    
    return vc.tabTitle;
    
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    
    _selectedTitleColor = selectedTitleColor;
    
    self.tabBar.selectedColor = _selectedTitleColor;
    
}

-(void)selectTheIndex:(NSInteger)index
{
    
    for (MOTabBarButton *button in self.tabBar.buttonArray) {
        
        if (button.tag == index) {
            
            [self.tabBar tabBarButtonClick:button];
            
        }
        
    }
    
}

-(void)setUnselectTitleColor:(UIColor *)unselectTitleColor
{
    
    _unselectTitleColor = unselectTitleColor;
    
    self.tabBar.unselectColor = _unselectTitleColor;
    
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    
    _selectIndex = selectIndex;
    
    self.tabBar.currentIndex = _selectIndex;
    
    [self didSelectIndex:selectIndex];
    
}

-(void)viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    
    if (self.view.frame.size.height != MSH) {
        
        _changedHeight = MSH-self.view.frame.size.height;
        
        [self.tabBar changeTop:self.view.frame.size.height-49];
        
        for (MOViewController *vc in self.viewControllers) {
            
            for (UIView *subView in vc.view.subviews) {
                
                if ([subView isKindOfClass:[UIScrollView class]]) {
                    
                    [subView changeHeight:self.view.frame.size.height-64-49];
                    
                }
                
            }
            
        }
        
    }else if(self.view.frame.size.height == MSH){
        
        if (_changedHeight) {
            
            [self.tabBar changeTop:MSH-49];
            
            for (MOViewController *vc in self.viewControllers) {
                
                [vc.view changeTop:0];
                
                for (UIView *subView in vc.view.subviews) {
                    
                    if ([subView isKindOfClass:[UIScrollView class]]) {
                        
                        [subView changeHeight:MSH-64-49];
                        
                    }
                    
                }
                
            }
            
            _changedHeight = 0;
            
        }
        
    }
    
}

-(void)setHaveNew:(BOOL)haveNew atIndex:(NSInteger)index
{
    
    [_tabBar setHaveNew:haveNew atIndex:index];
    
}

-(void)setNewNumber:(NSInteger)number atIndex:(NSInteger)index
{
    
    [_tabBar setNewNumber:number atIndex:index];
    
}

-(void)didSelectIndex:(NSInteger)index
{
    
}


@end
