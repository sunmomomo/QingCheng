//
//  ChooseView.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/13.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "ChooseView.h"

#import "UIImage+Category.h"

#import "MOTableView.h"

@interface ChooseViewButton : UIButton

{
    
    UILabel *_textLabel;
    
    UIView *_point;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,assign)BOOL haveNew;

@end

@implementation ChooseViewButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _textLabel.font = AllFont(13);
        
        [self addSubview:_textLabel];
        
        _point = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height/2-Height320(2), Width320(6), Height320(6))];
        
        _point.backgroundColor = kDeleteColor;
        
        _point.layer.cornerRadius = _point.width/2;
        
        _point.layer.masksToBounds = YES;
        
        [self addSubview:_point];
        
        _point.hidden = YES;
        
    }
    return self;
}

-(void)setTitleColor:(UIColor *)titleColor
{
    
    _titleColor = titleColor;
    
    _textLabel.textColor = _titleColor;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
    [_textLabel autoWidth];
    
    [_textLabel changeLeft:self.width/2-_textLabel.width/2];
    
    [_point changeLeft:_textLabel.left-Width320(10)];
    
}

-(void)setHaveNew:(BOOL)haveNew
{
    
    _haveNew = haveNew;
    
    _point.hidden = !_haveNew;
    
}

@end

@interface ChooseView ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *rowsArray;

@property(nonatomic,assign)NSInteger num;

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)UIScrollView *contentView;

@end

@implementation ChooseView

-(void)setDatasource:(id<ChooseViewDatasource>)datasource
{
    _datasource = datasource;
    
    _rowsArray = [NSMutableArray array];
    
    [self load];
    
}

-(void)setRowHeight:(float)rowHeight
{
    
    _rowHeight = rowHeight;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, rowHeight-1, MSW, 1)];
    
    line.backgroundColor = UIColorFromRGB(0xe0e0e0);
    
    [self addSubview:line];
    
}

-(void)setLineHeight:(float)lineHeight
{
    
    _lineHeight = lineHeight;
    
}

-(void)load
{
    
    for (UIView *subView in _contentView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            if (((UIScrollView *)subView).mj_header) {
                
                ((UIScrollView *)subView).mj_header = nil;
                
            }
            
            for (UIView *subsubView in subView.subviews) {
                
                if ([subsubView isKindOfClass:[UIScrollView class]]) {
                    
                    if (((UIScrollView *)subsubView).mj_header) {
                        
                        ((UIScrollView *)subsubView).mj_header = nil;
                        
                    }
                    
                }
            }
            
        }
        
        [subView removeFromSuperview];
        
    }
    
    if (!_rowHeight) {
        _rowHeight = Height320(40);
    }
    
    _num = [_datasource numberOfRowInChooseView];
    
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _rowHeight, MSW, self.height-_rowHeight)];
    
    _contentView.pagingEnabled = YES;
    
    _contentView.delegate = self;
    
    _contentView.showsHorizontalScrollIndicator = NO;
    
    _contentView.showsVerticalScrollIndicator = NO;
    
    _contentView.contentSize = CGSizeMake(_num*self.width, 0);
    
    [self addSubview:_contentView];
    
    float left = (MSW -_num*_rowWidth -(_num-1)*_rowGap)/2;
    
    for (NSInteger i = 0; i<_num; i++) {
        
        ChooseViewButton *temp = [[ChooseViewButton alloc]initWithFrame:CGRectMake(left+i*(_rowWidth+_rowGap), 0, _rowWidth, _rowHeight)];
        
        if ([_datasource respondsToSelector:@selector(titleForButtonAtRow:)]) {
            
            [temp setTitle:[_datasource titleForButtonAtRow:i]];
            
            [temp setTitleColor:UIColorFromRGB(0x9b9b9b)];
            
            if ([_datasource respondsToSelector:@selector(newAtRow:)]) {
                
                temp.haveNew = [_datasource newAtRow:i];
                
            }
            
            if (i == 0) {
                
                [temp setTitleColor:kMainColor];
                
            }
            
        }else if ([_datasource respondsToSelector:@selector(viewForButtonAtRow:)]){
            
            UIView *buttonView = [_datasource viewForButtonAtRow:i];
            
            buttonView.userInteractionEnabled = NO;
            
            if (i == 0) {
                
                for (UIView *subview in buttonView.subviews) {
                    
                    if ([subview isKindOfClass:[UILabel class]]) {
                        
                        ((UILabel *)subview).textColor = kMainColor;
                        
                    }else if ([subview isKindOfClass:[UIImageView class]]){
                        
                        ((UIImageView*)subview).image = [((UIImageView*)subview).image imageWithTintColor:kMainColor];
                        
                    }
                    
                }
                
            }else{
                
                for (UIView *subview in buttonView.subviews) {
                    
                    if ([subview isKindOfClass:[UILabel class]]) {
                        
                        ((UILabel *)subview).textColor = UIColorFromRGB(0x9b9b9b);
                        
                    }else if ([subview isKindOfClass:[UIImageView class]]){
                        
                        ((UIImageView*)subview).image = [((UIImageView*)subview).image imageWithTintColor:UIColorFromRGB(0x9b9b9b)];
                        
                    }
                    
                }
                
            }
            
            [temp removeAllView];
            
            [temp addSubview:buttonView];
            
        }
        
        temp.tag = i;
        
        [temp addTarget:self action:@selector(rowSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:temp];
        
        [_rowsArray addObject:temp];
        
        UIView *view = [_datasource viewForRow:i];
        
        view.viewIdentifier = i;
        
        view.frame = CGRectMake(i*_contentView.width, 0, _contentView.width, _contentView.height);
        
        [_contentView addSubview:view];
        
    }
    
    if (!_lineHeight) {
        
        _lineHeight = 2;
        
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(left, _rowHeight-_lineHeight, _rowWidth, _lineHeight)];
    
    _lineView.backgroundColor = kMainColor;
    
    [self addSubview:_lineView];
    
}

-(void)reloadAtIndex:(NSInteger)index
{
    
    for (UIView *subView in _contentView.subviews) {
        
        if (subView.viewIdentifier == index) {
            
            if ([subView isKindOfClass:[UIScrollView class]]) {
                
                if (((UIScrollView *)subView).mj_header) {
                    
                    ((UIScrollView *)subView).mj_header = nil;
                    
                }
                
                for (UIView *subsubView in subView.subviews) {
                    
                    if ([subsubView isKindOfClass:[UIScrollView class]]) {
                        
                        if (((UIScrollView *)subsubView).mj_header) {
                            
                            ((UIScrollView *)subsubView).mj_header = nil;
                            
                        }
                        
                    }
                }
                
            }
            
            [subView removeFromSuperview];
            
        }
        
    }
    
    UIView *view = [_datasource viewForRow:index];
    
    view.viewIdentifier = index;
    
    view.frame = CGRectMake(index*_contentView.width, 0, _contentView.width, _contentView.height);
    
    [_contentView addSubview:view];
    
}

-(void)reloadTableViewDataWithSuccess:(BOOL)success
{
    
    for (UIView *view in _contentView.subviews) {
        
        if ([view isKindOfClass:[MOTableView class]]) {
            
            ((MOTableView*)view).dataSuccess = success;
            
            [((MOTableView*)view) reloadData];
            
            if (((MOTableView*)view).mj_header) {
                
                [((MOTableView*)view).mj_header endRefreshing];
                
            }
            
        }else if ([view isKindOfClass:[UITableView class]]) {
            
            [((UITableView*)view) reloadData];
            
            if (((MOTableView*)view).mj_header) {
                
                [((MOTableView*)view).mj_header endRefreshing];
                
            }
            
        }
        
    }
    
    for (UIView *view in _contentView.subviews) {
        
        for (UIView *subView in view.subviews) {
            
            if ([subView isKindOfClass:[MOTableView class]]) {
                
                ((MOTableView*)subView).dataSuccess = success;
                
                [((MOTableView*)subView) reloadData];
                
                if (((MOTableView*)view).mj_header) {
                    
                    [((MOTableView*)view).mj_header endRefreshing];
                    
                }
                
            }else if ([subView isKindOfClass:[UITableView class]]) {
                
                [((UITableView*)subView) reloadData];
                
                if (((MOTableView*)view).mj_header) {
                    
                    [((MOTableView*)view).mj_header endRefreshing];
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)reloadData
{
    
    for (UIView *subView in _contentView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            if (((UIScrollView *)subView).mj_header) {
                
                ((UIScrollView *)subView).mj_header = nil;
                
            }
            
            for (UIView *subsubView in subView.subviews) {
                
                if ([subsubView isKindOfClass:[UIScrollView class]]) {
                    
                    if (((UIScrollView *)subsubView).mj_header) {
                        
                        ((UIScrollView *)subsubView).mj_header = nil;
                        
                    }
                    
                }
            }
            
        }
        
        [subView removeFromSuperview];
        
    }
    
    for (NSInteger i = 0; i<[_datasource numberOfRowInChooseView]; i++) {
        
        UIScrollView *view = [_datasource viewForRow:i];
        
        view.frame = CGRectMake(i*_contentView.width, 0, _contentView.width, _contentView.height);
        
        if (!_noRefresh) {
            
            view.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
                
                [view.mj_header endRefreshing];
                
                [self endRefresh];
                
            }];
            
        }
        
        [_contentView addSubview:view];
        
    }
    
}

-(void)endRefresh
{
    
    if ([self.datasource respondsToSelector:@selector(chooseViewEndRefresh)]) {
        
        [self.datasource chooseViewEndRefresh];
        
    }
    
}

-(void)reload
{
    
    for (ChooseViewButton *btn  in _rowsArray) {
        
        if ([_datasource respondsToSelector:@selector(titleForButtonAtRow:)]) {
            
            if ([_rowsArray indexOfObject:btn] == _selectNum) {
                
                [btn setTitleColor:kMainColor];
                
            }else{
                
                [btn setTitleColor:UIColorFromRGB(0x9b9b9b)];
                
            }
            
            if ([_datasource respondsToSelector:@selector(newAtRow:)]) {
                
                btn.haveNew = [_datasource newAtRow:[_rowsArray indexOfObject:btn]];
                
            }
            
        }else if ([_datasource respondsToSelector:@selector(viewForButtonAtRow:)]){
            
            UIView *buttonView = [_datasource viewForButtonAtRow:[_rowsArray indexOfObject:btn]];
            
            buttonView.userInteractionEnabled = NO;
            
            if ([_rowsArray indexOfObject:btn] == _selectNum) {
                
                buttonView.userInteractionEnabled = NO;
                
                for (UIView *subview in buttonView.subviews) {
                    
                    if ([subview isKindOfClass:[UILabel class]]) {
                        
                        ((UILabel *)subview).textColor = kMainColor;
                        
                    }else if ([subview isKindOfClass:[UIImageView class]]){
                        
                        ((UIImageView*)subview).image = [((UIImageView*)subview).image imageWithTintColor:kMainColor];
                        
                    }
                    
                }
                
            }else{
                
                for (UIView *subview in buttonView.subviews) {
                    
                    if ([subview isKindOfClass:[UILabel class]]) {
                        
                        ((UILabel *)subview).textColor = UIColorFromRGB(0x9b9b9b);
                        
                    }else if ([subview isKindOfClass:[UIImageView class]]){
                        
                        ((UIImageView*)subview).image = [((UIImageView*)subview).image imageWithTintColor:UIColorFromRGB(0x9b9b9b)];
                        
                    }
                    
                }
                
            }
            
            [btn removeAllView];
            
            [btn addSubview:buttonView];
            
        }
        
    }
    
    float left = (MSW -_num*_rowWidth -(_num-1)*_rowGap)/2;
    
    CGRect rect = _lineView.frame;
    
    rect.origin.x = left+_selectNum*(_rowGap+_rowWidth);
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [_lineView setFrame:rect];
        
        [_contentView setContentOffset:CGPointMake(_selectNum*_contentView.width, 0) animated:YES];
        
    }];
    
}

-(void)rowSelect:(UIButton*)btn
{
    
    _selectNum = btn.tag;
    
    [self reload];
    
    if ([self.datasource isKindOfClass:[UIViewController class]]) {
        
        [((UIViewController*)self.datasource).view endEditing:YES];
        
    }
    
    if ([self.datasource respondsToSelector:@selector(chooseButtonClick:)]) {
        
        [self.datasource chooseButtonClick:btn.tag];
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView == self.contentView) {
        
        _selectNum = scrollView.contentOffset.x/MSW;
        
        [self reload];
        
    }
    
    if ([self.datasource isKindOfClass:[UIViewController class]]) {
        
        [((UIViewController*)self.datasource).view endEditing:YES];
        
    }
    
}

-(void)reloadTitle
{
    
    for (ChooseViewButton *btn  in _rowsArray) {
        
        if ([_datasource respondsToSelector:@selector(titleForButtonAtRow:)]) {
            
            if ([_rowsArray indexOfObject:btn] == _selectNum) {
                
                [btn setTitleColor:kMainColor forState:UIControlStateNormal];
                
            }else{
                
                [btn setTitleColor:UIColorFromRGB(0x9b9b9b) forState:UIControlStateNormal];
                
            }
            
            if ([_datasource respondsToSelector:@selector(newAtRow:)]) {
                
                btn.haveNew = [_datasource newAtRow:[_rowsArray indexOfObject:btn]];
                
            }
            
        }else if ([_datasource respondsToSelector:@selector(viewForButtonAtRow:)]){
            
            UIView *buttonView = [_datasource viewForButtonAtRow:[_rowsArray indexOfObject:btn]];
            
            if ([_rowsArray indexOfObject:btn] == _selectNum) {
                
                for (UIView *subview in buttonView.subviews) {
                    
                    if ([subview isKindOfClass:[UILabel class]]) {
                        
                        ((UILabel *)subview).textColor = UIColorFromRGB(0x9b9b9b);
                        
                    }else if ([subview isKindOfClass:[UIImageView class]]){
                        
                        ((UIImageView*)subview).image = [((UIImageView*)subview).image imageWithTintColor:UIColorFromRGB(0x9b9b9b)];
                        
                    }
                    
                }
                
            }else{
                
                for (UIView *subview in buttonView.subviews) {
                    
                    if ([subview isKindOfClass:[UILabel class]]) {
                        
                        ((UILabel *)subview).textColor = kMainColor;
                        
                    }else if ([subview isKindOfClass:[UIImageView class]]){
                        
                        ((UIImageView*)subview).image = [((UIImageView*)subview).image imageWithTintColor:kMainColor];
                        
                    }
                    
                }
                
            }
            
            [btn removeAllView];
            
            [btn addSubview:buttonView];
            
        }
        
    }
    
}

-(void)selectNum:(NSInteger)num
{
    
    for (UIButton *btn in _rowsArray) {
        
        if (btn.tag == num-1) {
            
            [self rowSelect:btn];
            
        }
        
    }
    
}

-(void)dealloc
{
    
    for (UIView *subView in _contentView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            if (((UIScrollView *)subView).mj_header) {
                
                ((UIScrollView *)subView).mj_header = nil;
                
            }
            
            for (UIView *subsubView in subView.subviews) {
                
                if ([subsubView isKindOfClass:[UIScrollView class]]) {
                    
                    if (((UIScrollView *)subsubView).mj_header) {
                        
                        ((UIScrollView *)subsubView).mj_header = nil;
                        
                    }
                    
                }
            }
            
        }
        
        [subView removeFromSuperview];
        
    }
    
    [self removeAllView];
    
}


@end
