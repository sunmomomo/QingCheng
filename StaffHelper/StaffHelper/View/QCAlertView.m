//
//  QCAlertView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "QCAlertView.h"

@interface QCAlertView ()

@property(nonatomic,strong)NSArray *titles;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *message;

@property(nonatomic,copy)NSString *cancelButtonTitle;

@end

@implementation QCAlertView

+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    QCAlertView *alert = [[QCAlertView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    NSMutableArray *titles = [NSMutableArray array];
    
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
    {
        
        [titles addObject:arg];
        
    }
    
    alert.title = title;
    
    alert.message = message;
    
    alert.delegate = delegate;
    
    alert.cancelButtonTitle = cancelButtonTitle;
    
    alert.titles = titles;
    
    return alert;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        
    }
    
    return self;
    
}

-(void)show
{
    
    
    
}

-(void)load
{
    
    
    
}

-(void)close
{
    
    [self removeFromSuperview];
    
}

@end
