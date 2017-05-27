//
//  MOLableView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOLableView.h"

@implementation MOLableView

-(void)setDataArray:(NSArray *)dataArray
{
    
    _dataArray = dataArray;

    [self load];
    
}

-(void)load
{
    
    [self removeAllView];
    
    if (!_labelGap) {
        
        _labelGap = Width320(3);
        
    }
    
    if (!_labelHeight) {
        
        _labelHeight = Height320(17);
        
    }
    
    if (!_font) {
        
        _font = STFont(14);
        
    }
    
    if (!_textColor) {
        
        _textColor = UIColorFromRGB(0x666666);
        
    }
    
    if (!_rowGap) {
        
        _rowGap = Height320(8);
        
    }
    
    CGFloat top = 0;
    
    CGFloat left = 0;
    
    for (NSInteger i = 0; i<_dataArray.count; i++) {
        
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(left, top, Width320(200), _labelHeight+Height320(2))];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), Height320(1), Width320(200), _labelHeight)];
        
        label.textColor = _textColor;
        
        label.font = _font;
        
        label.layer.borderWidth = 1;
        
        label.layer.borderColor = UIColorFromRGB(0xbbbbbb).CGColor;
        
        NSString *text;
        
        if (_key2) {
            
            if (_highLight&&i<_highNum) {
                
                label.layer.borderColor = UIColorFromRGB(0xEDA640).CGColor;
                
                label.textColor = UIColorFromRGB(0xEDA640);
                
            }
            
            text = [NSString stringWithFormat:@"%@(%@)",_dataArray[i][_key1],_dataArray[i][_key2]];
            
        }else
        {
            
            text = _dataArray[i][_key1];
            
        }
                
        label.text = [NSString stringWithFormat:@"  %@  ",text];
        
        [label autoWidth];
        
        if (_haveArrow) {
            
            label.layer.borderWidth = 0;
            
            UIImageView* backgrdView = [[UIImageView alloc] initWithFrame:CGRectMake(label.left-Width320(8), label.top-Height320(1), label.width+Width320(8), label.height+Height320(2))];
            
            backgrdView.contentMode = UIViewContentModeScaleToFill;
            
            backgrdView.image = [[UIImage imageNamed:@"tag.9.png"]stretchableImageWithLeftCapWidth:11 topCapHeight:label.frame.size.height];
            
            [tempView addSubview:backgrdView];
            
        }
        
        [tempView addSubview:label];
        
        [tempView changeWidth:label.width+Width320(20)];
        
        if (left+tempView.width>self.width) {
            
            top += _rowGap+_labelHeight;
            
            left = 0;
            
            [tempView changeTop:top];
            
            [tempView changeLeft:0];
            
        }
        
        left += tempView.width+_labelGap;
        
        [self addSubview:tempView];
        
    }
    
    [self changeHeight:top+_labelHeight];
    
}

@end
