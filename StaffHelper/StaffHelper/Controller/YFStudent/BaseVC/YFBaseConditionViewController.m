//
//  YFBaseConditionViewController.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseConditionViewController.h"

@interface YFBaseConditionViewController ()


@end

@implementation YFBaseConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (CGRectEqualToRect(self.popViewFrame, CGRectZero))
    {
        self.popViewFrame = self.baseTableView.frame;
    }
    
    for (Class popClass in self.classsArray)
    {
        YFConditionPopView *popView = [[popClass alloc] initWithFrame:self.popViewFrame superView:self.view];
        popView.title = self.title;
        weakTypesYF
        [popView setSelectBlock:^(NSString *value, NSDictionary *param) {
            [weakS selectParam:value param:param];
        }];
        __weak typeof(popView)weakPop = popView;
        
        [popView setCancelBlock:^(id model) {
            // 如果有创建 这个 View
            
                NSInteger index = [weakS.popViewsArray indexOfObject:weakPop];
                
                UIButton *button = [[weakS getCurrnetOperationView] buttonWithIndex:index];
                button.selected = NO;
        }];
        popView.gym = self.gym;
        [self.popViewsArray addObject:popView];
    }
    self.showPopView = self.popViewsArray.firstObject;
    
    [self selectParam:nil param:nil];
}
// 调用Self. 会自动创建 ，weak 化 operationView，需要保证先存在，所以提供一个方法，在需要是 调用
- (GTWSelectOperationView *)getCurrnetOperationView
{
    return _operationView;
}


- (void)selectParam:(NSString *)value param:(NSDictionary *)param
{
    [self.showPopView hide];
    
    NSMutableDictionary *allParam = [NSMutableDictionary dictionary];
    
    for (NSUInteger i = 0; i < self.popViewsArray.count; i ++)
    {
        YFConditionPopView *popView = self.popViewsArray[i];
        if (popView.param.count) {
            if (popView.isValidParam)
            {
                [allParam setValuesForKeysWithDictionary:popView.param];
            }
            if (_operationView && popView.isToGreenTitle) {
                [self.operationView setSelectButtonWithIndex:i];
            }
        }else
        {
            [self.operationView setUnSelectButtonWithIndex:i];
        }
        
        if (_operationView) {
            if ([popView isEqual:self.showPopView])
            {
                [self.operationView setUnSelectButtonTitleWithIndex:i suitFrametitle:self.showPopView.value];
            }
        }
    }
    
    for (YFConditionPopView *popView in self.popViewsArray) {
        [popView afterSetAllConditionsParam:allParam];
    }
    if (_operationView) {
    [self.operationView setUnselectButtonFY];
    }
    
    self.allParam = allParam;
    
    [self refreshTableListDataNoPull];
}

- (void)operationViewDidSelectedIndex:(NSInteger)index selectedState:(BOOL)selectedState button:(UIButton *)button
{
    if (self.popViewsArray.count > index) {
        self.showPopView = self.popViewsArray[index];
    }else
    {
        self.showPopView = nil;
    }
    if (self.showPopView.isCanShow == NO)
    {
        [self.operationView setUnselectButtonFY];
    }
    [self.showPopView showOrHide];

}

- (GTWSelectOperationView *)operationView
{
    if (!_operationView)
    {
        _operationView = [[GTWSelectOperationView alloc]initWithDataSourceFY:self.buttonTitleArray sepImage:@"fadeline" delegate:self font:[UIFont systemFontOfSize:IPhone4_5_6_6PYF(13, 13, 14, 14)]];
        _operationView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.operationView];
        
        _operationView.frame = CGRectMake(0, 64.0, self.view.width, GTWSelectOperationViewHeight);
        
        
        
        _operationView.delegate = self;
    }
    return _operationView;
}

- (NSMutableArray *)popViewsArray
{
    if (!_popViewsArray)
    {
        _popViewsArray = [[NSMutableArray alloc] init];
    }
    return _popViewsArray;
}


- (void)setShowPopView:(YFConditionPopView *)showPopView
{
    if (_showPopView && [showPopView isEqual:_showPopView] == NO) {
        [_showPopView hideAnimate:NO];
    }
    _showPopView = showPopView;
}

@end
