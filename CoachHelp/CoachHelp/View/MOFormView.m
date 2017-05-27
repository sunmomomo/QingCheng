//
//  MOFormView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOFormView.h"

@interface MOFormView ()

{
    
    NSInteger _rows;
    
    NSInteger _sections;
    
    NSMutableArray *_labels;
    
}

@end

@implementation MOFormView

-(void)setDatasource:(id<MOFormViewDatasource>)datasource
{
    
    _datasource = datasource;
    
    [self reloadData];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _labels = [NSMutableArray array];
        
    }
    return self;
}

-(void)reloadData
{
    
    if (_rows != [self.datasource numberOfRowsOfFormView:self] || _sections != [self.datasource numberOfSectionsOfFormView:self]) {
        
        _rows = [self.datasource numberOfRowsOfFormView:self];
        
        _sections = [self.datasource numberOfSectionsOfFormView:self];
        
        _labels = [NSMutableArray array];
        
        [self removeAllView];
        
        CGFloat width = self.width/_rows;
        
        CGFloat height = self.height/_sections;
        
        for (NSInteger i = 0 ; i<_rows; i++) {
            
            for (NSInteger j = 0 ; j < _sections; j++) {
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width*i, height*j, width, height)];
                
                label.textAlignment = NSTextAlignmentCenter;
                
                label.indexPath = [NSIndexPath indexPathForRow:i inSection:j];
                
                [self addSubview:label];
                
                [_labels addObject:label];
                
            }
            
        }
        
        for (NSInteger i = 1; i<_rows; i++) {
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*(long)width, 0, 1/[UIScreen mainScreen].scale, self.height)];
            
            line.backgroundColor = _lineColor;
            
            [self addSubview:line];
            
        }
        
        for (NSInteger i = 1; i<_sections; i++) {
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, i*(long)height, self.width, 1/[UIScreen mainScreen].scale)];
            
            line.backgroundColor = _lineColor;
            
            [self addSubview:line];
            
        }
        
    }
    
    for (UILabel *label in _labels) {
        
        label.text = [self.datasource formView:self titleForRowAtIndexPath:label.indexPath].length?[self.datasource formView:self titleForRowAtIndexPath:label.indexPath]:@"— —";
        
        label.font = [self.datasource fontOfRowOfFormView:self];
        
        label.textColor = [self.datasource formView:self titleForRowAtIndexPath:label.indexPath].length?[self.datasource formView:self colorForRowAtIndexPath:label.indexPath]:UIColorFromRGB(0x999999);
        
    }
    
}

@end
