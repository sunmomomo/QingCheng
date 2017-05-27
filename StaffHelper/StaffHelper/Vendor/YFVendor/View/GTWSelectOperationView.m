//
//  GTWOperationView.m
//  GTW
//
//  Created by FengXingTianXia on 15-3-5.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import "GTWSelectOperationView.h"
#import "Masonry.h"
#import "UIView+masonryExtesionYF.h"
#import "GTFYButton.h"
#import "YFAppConfig.h"
#define declareWeakSelf __weak typeof(self) weakSelf = self;

@interface GTWSelectOperationView ()
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) UIButton *selectedButton;
@end

@implementation GTWSelectOperationView
{
    UIButton *_lastButton;
    NSMutableArray *_buttonsArray;
    CGFloat _buttonPadding;
    //        CGFloat margin = buttonPadding * 0.5;
    
    CGFloat _widthYF ;
    CGFloat _heightYF;
    
    CGFloat _xx ;
    CGFloat _imageWidth;
    
    CGFloat _labelWidthExtra;
    CGFloat _labelImageGap;
    
    NSArray *_imageNameUpUnSelectArray;
    NSArray *_imageNameDownUnSelectArray;

}
- (instancetype) initWithDataSource:(NSArray *)dataSource sepImage:(NSString *)sepImage delegate:(id)delegate font:(UIFont *)font
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        
        
        CGFloat buttonPadding = 10;
        CGFloat margin = buttonPadding * 0.5;
        UIView *lastView;
        for (int i = 0; i < dataSource.count; i++) {
            UIButton *button = [[UIButton alloc]init];
            button.tag = 2000 + i;
            //            button.backgroundColor = [UIColor redColor];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
            [button setImage:[UIImage imageNamed:@"triangle_gray"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"triangle_yellow"] forState:UIControlStateHighlighted];
            [button setImage:[UIImage imageNamed:@"triangle_yellow"] forState:UIControlStateSelected];
            [button setTitle:dataSource[i] forState:UIControlStateNormal];
            button.titleLabel.font = font;
            [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGB(0xf98512) forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            declareWeakSelf
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_top);
                //控件之间间距
                make.left.equalTo(lastView ? lastView.mas_right : @0).offset(lastView ? buttonPadding : margin);
                make.bottom.equalTo(weakSelf.mas_bottom);
            }];
            //调整图片的位置
            [button.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(button.mas_trailing);
                make.width.equalTo(@(button.imageView.image.size.width));
                make.centerY.equalTo(button.mas_centerY);
            }];
            
            //                    [button.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //                            make.width.equalTo(button.mas_width);
            ////                            make.left.equalTo(button.mas_left).offset(0);
            ////                            make.right.equalTo(button.mas_right).offset(-button.imageView.image.size.width);
            //                            make.centerY.equalTo(button.mas_centerY);
            //                        }];
            
            lastView = button;
        }
        CGFloat buttonWith = ([UIScreen mainScreen].bounds.size.width - (self.dataSource.count - 1) * buttonPadding - margin * 2) / self.dataSource.count;
        //        lastView = self.subviews[0];
        //调整按钮宽度一样大
        for (UIView *button in self.subviews) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(buttonWith));
            }];
            //            lastView = button;
        }
        declareWeakSelf
        //在按钮之间插入分割线
        for (UIView *button in self.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                //在非最后一个按钮后面插入
                if (![lastView isEqual:button]) {
                    UIImageView *sepImageView = UIImageView.new;
                    sepImageView.image = [UIImage imageNamed:sepImage];
                    [self addSubview:sepImageView];
                    [sepImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(button.mas_centerY);
                        make.left.equalTo(button.mas_right).offset(buttonPadding * 0.5);
                        make.top.equalTo(weakSelf.mas_top);
                        make.bottom.equalTo(weakSelf.mas_bottom);
                    }];
                }
            }
        }
        
    }
    return self;
}


- (instancetype) initWithDataSourceFY:(NSArray *)dataSource sepImage:(NSString *)sepImage delegate:(id)delegate font:(UIFont *)font
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        
        _buttonsArray = [NSMutableArray array];
        _buttonPadding = 0;
        
        _widthYF = (long)((MSW - _buttonPadding * 4 ) / dataSource.count);
        _heightYF = GTWSelectOperationViewHeight;

        _xx = (long)_buttonPadding * 0.5;
        _imageWidth = 10.0;

        _labelWidthExtra  = 1;
        _labelImageGap  = 3.0;

        if (dataSource.count == 2)
        {
            _labelWidthExtra = 14;
        }

        
        for (int i = 0; i < dataSource.count; i++) {
            
            NSString *title = dataSource[i];
            
            CGSize size =  YF_MULTILINE_TEXTSIZE(title, font, CGSizeMake(100, 30), 0);
            
            CGFloat labelWidth = (long)size.width + _labelWidthExtra;
            
            CGFloat xxlabel = (_widthYF - labelWidth - _imageWidth - _labelImageGap) / 2.0 ;
            CGFloat xxImage = xxlabel + labelWidth + _labelImageGap;


            
            GTFYButton *button = [[GTFYButton alloc]initWithFrame:CGRectMake(_xx + i *(_buttonPadding + _widthYF), 0, _widthYF, _heightYF) imageFrame:CGRectMake(xxImage, _heightYF / 2 - 3, 10, 6) titleFrame:CGRectMake(xxlabel, 0, labelWidth, _heightYF)];
            button.tag = 2000 + i;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
           
            button.isSelectStateYF = NO;
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = font;
            
            
            [button setImage:[UIImage imageNamed:@"buttonUnSelectedDown"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"buttonUnSelectedUp"] forState:UIControlStateSelected];
            [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateSelected];

            
            [_buttonsArray addObject:button];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];

            
            if (i > 0)
            {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((MSW / dataSource.count) * i - 1, (_heightYF - 19.0)/2.0, OnePX, 19.0)];
                lineView.backgroundColor = YFLineViewColor;
                [self addSubview:lineView];
            }
        }
    
        UIView *lineView = UIView.new;
        lineView.backgroundColor = YFLineViewColor;
        [self addSubview:lineView];
        [lineView setBottomLine];
        
    }
    return self;
}


- (instancetype)initWithDataSourceFY:(NSArray *)dataSource sepImageArray:(NSArray *)sepImageArray downImageArray:(NSArray *)sepImageDownArray delegate:(id)delegate font:(UIFont *)font
{
    
    self = [self initWithDataSourceFY:dataSource sepImageArray:sepImageArray downImageArray:sepImageDownArray delegate:delegate font:font allWidth:MSW];
    
    return self;
}


- (instancetype)initWithDataSourceFY:(NSArray *)dataSource sepImageArray:(NSArray *)sepImageArray downImageArray:(NSArray *)sepImageDownArray delegate:(id)delegate font:(UIFont *)font allWidth:(CGFloat)allWidth
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        _imageNameUpUnSelectArray = sepImageArray;
        _imageNameDownUnSelectArray = sepImageDownArray;
        _buttonsArray = [NSMutableArray array];
        _buttonPadding = 0;
        
        _widthYF = (long)((allWidth - _buttonPadding * 4 ) / dataSource.count);
        _heightYF = GTWSelectOperationViewHeight;
        
        _xx = (long)_buttonPadding * 0.5;
        _imageWidth = 10.0;
        
        _labelWidthExtra  = 1;
        _labelImageGap  = 3.0;
        
        if (dataSource.count == 2)
        {
            _labelWidthExtra = 14;
        }
        
        
        for (int i = 0; i < dataSource.count; i++) {
            
            NSString *title = dataSource[i];
            
            CGSize size =  YF_MULTILINE_TEXTSIZE(title, font, CGSizeMake(100, 30), 0);
            
            CGFloat labelWidth = (long)size.width + _labelWidthExtra;
            
            CGFloat xxlabel = (_widthYF - labelWidth - _imageWidth - _labelImageGap) / 2.0 ;
            CGFloat xxImage = xxlabel + labelWidth + _labelImageGap;
            
            NSString *imageUpStr;
            
            if (_imageNameUpUnSelectArray.count > i) {
                imageUpStr = _imageNameUpUnSelectArray[i];
            }else
            {
                imageUpStr = _imageNameUpUnSelectArray.firstObject;
            }
            
            UIImage *imageupButton = [UIImage imageNamed:imageUpStr];
            
            NSString *imageDownStr;
            
            if (_imageNameDownUnSelectArray.count > i) {
                imageDownStr = _imageNameDownUnSelectArray[i];
            }else
            {
                imageDownStr = _imageNameDownUnSelectArray.firstObject;
            }
            
            UIImage *imageDownButton = [UIImage imageNamed:imageDownStr];
            
            CGFloat imageWidth = XFrom5To6YF(imageupButton.size.width);
            CGFloat imageHeight = XFrom5To6YF(imageupButton.size.height);
            
            GTFYButton *button = [[GTFYButton alloc]initWithFrame:CGRectMake(_xx + i *(_buttonPadding + _widthYF), 0, _widthYF, _heightYF) imageFrame:CGRectMake(xxImage, _heightYF / 2 - (imageHeight / 2.0), imageWidth, imageHeight) titleFrame:CGRectMake(xxlabel, 0, labelWidth, _heightYF)];
            button.tag = 2000 + i;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            button.isSelectStateYF = NO;
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = font;
            
            //            [button setImage:[UIImage imageNamed:@"buttonUnSelectedDown"] forState:UIControlStateNormal];
            //            [button setImage:[UIImage imageNamed:@"buttonUnSelectedUp"] forState:UIControlStateSelected];
            
            [button setImage:imageDownButton forState:UIControlStateNormal];
            [button setImage:imageupButton forState:UIControlStateSelected];
            [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateSelected];
            
            
            [_buttonsArray addObject:button];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            
            if (i > 0)
            {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((allWidth / dataSource.count) * i - 1, (_heightYF - 19.0)/2.0, OnePX, 19.0)];
                lineView.backgroundColor = YFLineViewColor;
                [self addSubview:lineView];
            }
        }
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = YFLineViewColor;
        [self addSubview:lineView];
        [lineView setBottomLine];
        
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
}

- (void)layoutUI
{
    
}

- (void)buttonClick:(UIButton *)sender
{
    if (self.selectedButton != sender) {
        self.selectedButton.selected = NO;
        sender.selected = YES;
        self.selectedButton = sender;
    }else{
        sender.selected = !sender.selected;
    }
    if ([self.delegate respondsToSelector:@selector(operationViewDidSelectedIndex:selectedState:button:)]) {
        [self.delegate operationViewDidSelectedIndex:sender.tag - 2000 selectedState:sender.selected button:sender];
    }
}
-(void)setUnselectButtonFY
{
    _lastButton = self.selectedButton;
    self.selectedButton.selected = NO;
    self.selectedButton = nil;
}

-(void)setSelectButtonWithIndex:(NSUInteger)index
{
    if (_buttonsArray.count > index)
    {
    GTFYButton *button = _buttonsArray[index];
    button.isSelectStateYF = YES;
        
    [button setImage:[UIImage imageNamed:[self downSelectImageNameWithIndex:index]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[self upSelectImageNameWithIndex:index]] forState:UIControlStateSelected];
    [button setTitleColor:YFSelectedButtonColor forState:UIControlStateNormal];
    [button setTitleColor:YFSelectedButtonColor forState:UIControlStateSelected];
    }
    
}
- (NSString *)upSelectImageNameWithIndex:(NSInteger)index
{
    NSString *imageUpStr;
    if (_upSeleImageArray) {
        if (_upSeleImageArray.count > index) {
            imageUpStr = _upSeleImageArray[index];
        }else
        {
            imageUpStr = _upSeleImageArray.firstObject;
        }
    }else
    {
        imageUpStr = @"buttonSelectedUp";
    }
    return imageUpStr;
}
- (NSString *)downSelectImageNameWithIndex:(NSInteger)index
{
    NSString *imageDownStr;
    if (_downSeleImageArray) {
        if (_downSeleImageArray.count > index) {
            imageDownStr = _downSeleImageArray[index];
        }else
        {
            imageDownStr = _downSeleImageArray.firstObject;
        }
    }else
    {
        imageDownStr  = @"buttonSelectedDown";
    }
    return imageDownStr;
}

- (NSString *)upUnSelectImageNameWithIndex:(NSInteger)index
{
    NSString *imageUpStr;
    if (_imageNameUpUnSelectArray) {
        if (_imageNameUpUnSelectArray.count > index) {
            imageUpStr = _imageNameUpUnSelectArray[index];
        }else
        {
            imageUpStr = _imageNameUpUnSelectArray.firstObject;
        }
    }else
    {
        imageUpStr = @"buttonUnSelectedUp";
    }
    return imageUpStr;
}
- (NSString *)downUnSelectImageNameWithIndex:(NSInteger)index
{
    NSString *imageDownStr;
    if (_imageNameDownUnSelectArray) {
        if (_imageNameDownUnSelectArray.count > index) {
            imageDownStr = _imageNameDownUnSelectArray[index];
        }else
        {
            imageDownStr = _imageNameDownUnSelectArray.firstObject;
        }
    }else
    {
        imageDownStr  = @"buttonUnSelectedDown";
    }
    return imageDownStr;
}



-(UIButton *)buttonWithIndex:(NSInteger )index
{
    if (_buttonsArray.count > index)
    {
        return _buttonsArray[index];
    }
    return nil;
}

-(void)setSelectButtonTitleWithIndex:(NSUInteger)index title:(NSString *)title
{
    if (_buttonsArray.count > index)
    {
        UIButton *button = _buttonsArray[index];
        if ([title isStringValueYF] && title.length > 0)
        {
            [button setTitle:title forState:UIControlStateNormal];
        }
    }
}

-(void)setSelectButtonTitleWithIndex:(NSUInteger)index suitFrametitle:(NSString *)title
{
    [self setSelectButtonTitleWithIndex:index suitFrametitle:title maxWidth:_widthYF - 10 - 40 - _labelImageGap];
}


-(void)setSelectButtonTitleWithIndex:(NSUInteger)index suitFrametitle:(NSString *)title maxWidth:(CGFloat)maxWidth
{
    if (_buttonsArray.count > index)
    {
        GTFYButton *button = _buttonsArray[index];
        if ([title isStringValueYF] && title.length > 0)
        {
            GTFYButton *repalceButton = (GTFYButton*)[self title:title index:index font:button.titleLabel.font oldButton:button maxWidth:maxWidth];
            repalceButton.frame = button.frame;
            repalceButton.selected = button.selected;
            repalceButton.isSelectStateYF = button.isSelectStateYF;
            [_buttonsArray replaceObjectAtIndex:index withObject:repalceButton];
            if (button.selected)
            {
                self.selectedButton = repalceButton;
            }
            [button removeFromSuperview];
            [self addSubview:repalceButton];
            
            if (repalceButton.isSelectStateYF) {
                [self setSelectButtonWithIndex:index];
            }else
            {
                [self setUnSelectButtonWithIndex:index];
            }
            //            [button setTitle:title forState:UIControlStateNormal];
        }
    }
}


-(void)setUnSelectButtonTitleWithIndex:(NSUInteger)index suitFrametitle:(NSString *)title
{
    if (_buttonsArray.count > index)
    {
        GTFYButton *button = _buttonsArray[index];
        if ([title isStringValueYF] && title.length > 0)
        {
            GTFYButton *repalceButton = (GTFYButton*)[self oldLabelWidthTitle:title index:index font:button.titleLabel.font oldButton:button];
            repalceButton.frame = button.frame;
            repalceButton.selected = button.selected;
            repalceButton.isSelectStateYF = button.isSelectStateYF;
            repalceButton.selected = NO;
            [_buttonsArray replaceObjectAtIndex:index withObject:repalceButton];
            
            [button removeFromSuperview];
            [self addSubview:repalceButton];
            
            if (repalceButton.isSelectStateYF) {
                [self setSelectButtonWithIndex:index];
            }else
            {
                [self setUnSelectButtonWithIndex:index];
            }
            //            [button setTitle:title forState:UIControlStateNormal];
        }
    }
}



-(void)setUnSelectButtonWithIndex:(NSUInteger)index
{
    if (_buttonsArray.count > index)
    {
        GTFYButton *button = _buttonsArray[index];
        button.isSelectStateYF = NO;
        [button setImage:[UIImage imageNamed:[self downUnSelectImageNameWithIndex:index]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[self upUnSelectImageNameWithIndex:index]] forState:UIControlStateSelected];
        [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateSelected];
    }
}

- (BOOL)checkIsHaveSelect
{
    for (GTFYButton *button in _buttonsArray)
    {
        if (button.isSelectStateYF) {
            return YES;
        }
    }
    return NO;
}


-(void)setTitleValue:(NSString *)valueString
{
    if ([valueString isStringValueYF] && valueString.length > 0)
    {
    [self.selectedButton setTitle:valueString forState:UIControlStateNormal];
    }
}

-(void)setTitleValueToLastSelectButton:(NSString *)valueString
{
    if ([valueString isStringValueYF] && valueString.length > 0)
    {
        [_lastButton setTitle:valueString forState:UIControlStateNormal];
    }
}

- (GTFYButton *)oldLabelWidthTitle:(NSString *)title index:(NSInteger)i font:(UIFont *)font oldButton:(GTFYButton *)willReplaedButton
{

    
    CGSize size =  YF_MULTILINE_TEXTSIZE(title, font, CGSizeMake(_widthYF - 10 - 40 - _labelImageGap, 30), 0);
    
    CGFloat labelWidth = (long)size.width + _labelWidthExtra;
    
    CGFloat xxlabel = (_widthYF - labelWidth - _imageWidth - _labelImageGap) / 2.0 ;
    CGFloat xxImage = xxlabel + labelWidth + _labelImageGap;
    
    
    
    GTFYButton *button = [[GTFYButton alloc]initWithFrame:CGRectMake(_xx + i *(_buttonPadding + _widthYF), 0, _widthYF, _heightYF) imageFrame:CGRectMake(xxImage, (_heightYF  - willReplaedButton.imageFrame.size.height)/ 2, willReplaedButton.imageFrame.size.width, willReplaedButton.imageFrame.size.height) titleFrame:CGRectMake(xxlabel, 0, labelWidth, _heightYF)];
    button.tag = 2000 + i;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    button.isSelectStateYF = NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    
    
    [button setImage:[UIImage imageNamed:@"buttonUnSelectedDown"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"buttonUnSelectedUp"] forState:UIControlStateSelected];
    [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateSelected];
    
    
    //    [_buttonsArray addObject:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:button];
    return button;
}

- (GTFYButton *)title:(NSString *)title index:(NSInteger)i font:(UIFont *)font oldButton:(GTFYButton *)willReplaedButton maxWidth:(CGFloat)maxWidth
{
    _labelWidthExtra = 1;
    
    CGSize size =  YF_MULTILINE_TEXTSIZE(title, font, CGSizeMake(maxWidth, 30), 0);
    
    CGFloat labelWidth = (long)size.width + _labelWidthExtra;
    
    CGFloat xxlabel = (_widthYF - labelWidth - _imageWidth - _labelImageGap) / 2.0 ;
    CGFloat xxImage = xxlabel + labelWidth + _labelImageGap;
    
    
    
    GTFYButton *button = [[GTFYButton alloc]initWithFrame:CGRectMake(_xx + i *(_buttonPadding + _widthYF), 0, _widthYF, _heightYF) imageFrame:CGRectMake(xxImage, (_heightYF  - willReplaedButton.imageFrame.size.height)/ 2, willReplaedButton.imageFrame.size.width, willReplaedButton.imageFrame.size.height) titleFrame:CGRectMake(xxlabel, 0, labelWidth, _heightYF)];
    button.tag = 2000 + i;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    button.isSelectStateYF = NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    
    
    [button setImage:[UIImage imageNamed:@"buttonUnSelectedDown"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"buttonUnSelectedUp"] forState:UIControlStateSelected];
    [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x4d4d4d) forState:UIControlStateSelected];
    
    
//    [_buttonsArray addObject:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button];
    return button;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
