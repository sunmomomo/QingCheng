//
//  FunctionEditCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "FunctionEditCell.h"

#import "YFAppConfig.h"

@interface FunctionEditCell ()

{
    
    UIImageView *_imageView;
    
    UILabel *_textLabel;
    
    UIImageView *_typeImgView;
    
    UIView *_bottomLine;
    
}

@end

@implementation FunctionEditCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-OnePX, frame.size.width, OnePX)];
        
        _bottomLine.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_bottomLine];
        
        UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-OnePX, 0, OnePX, frame.size.height)];
        
        rightLine.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:rightLine];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(50), frame.size.width, Height320(14))];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(12);
        
        [self addSubview:_textLabel];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(24), Height320(24))];
        
        [self addSubview:_imageView];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-Width320(20), 0, Height320(20), Height320(20))];
        
        [self addSubview:button];
        
        _typeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(4), Height320(4), Width320(12), Height320(12))];
        
        [button addSubview:_typeImgView];
        
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
    _identifier = _title;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imageView.image = _image;
    
    _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    _imageView.center = CGPointMake(self.width/2, Height320(30));
    
}

-(void)setType:(FunctionEditCellType)type
{
    
    _type = type;
    
    switch (_type) {
            
        case FunctionEditCellTypeAdd:
            
            _typeImgView.image = [UIImage imageNamed:@"cell_add"];
            
            break;
            
        case FunctionEditCellTypeDelete:
            
            _typeImgView.image = [UIImage imageNamed:@"cell_delete"];
            
            break;
            
        case FunctionEditCellTypeChoosed:
            
            _typeImgView.image = [UIImage imageNamed:@"cell_selected"];
            
            break;
            
        default:
            
            _typeImgView.image = nil;
            
            break;
            
    }
    
}

-(void)buttonClick
{
    
    if (_type == FunctionEditCellTypeDelete) {
        
        if ([self.delegate respondsToSelector:@selector(deleteFunctionWithIndexPath:)]) {
            
            [self.delegate deleteFunctionWithIndexPath:self.indexPath];
            
        }
        
    }else if (_type == FunctionEditCellTypeAdd){
        
        if ([self.delegate respondsToSelector:@selector(addFunctionWithIndexPath:)]) {
            
            [self.delegate addFunctionWithIndexPath:self.indexPath];
            
        }
        
    }
    
}

-(void)setNoBottomLine:(BOOL)noBottomLine
{
    
    _noBottomLine = noBottomLine;
    
    _bottomLine.hidden = _noBottomLine;
    
}

@end
