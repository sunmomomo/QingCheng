//
//  IntroView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/11/3.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "IntroView.h"

@interface IntroView ()

{
    
    NSMutableArray *_views;
    
    NSInteger _imgNum;
    
    BOOL _dataFinish;
    
}

@property(nonatomic,assign)NSInteger currentNum;

@end

@implementation IntroView

-(void)setDataArray:(NSArray *)dataArray
{
    
    _dataArray = dataArray;
    
    if (!_dataArray.count) {
        return;
    }
    
    _imgNum = 0;
    
    _dataFinish = NO;
    
    for (NSDictionary *dict in _dataArray) {
        
        if ([dict[@"type"] isEqualToString:@"img"]) {
            
            _imgNum ++;
            
        }
        
    }
    
    [self load];
    
}

-(void)load
{
    
    _views = [NSMutableArray array];
    
    _currentNum = 0;
    
    for (NSDictionary *dict in _dataArray) {
        
        if ([dict[@"type"] isEqualToString:@"word"]) {
            
            UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(19), 0, MSW-Width320(38), Height320(300))];
            
            tempLabel.textColor = UIColorFromRGB(0x222222);
            
            tempLabel.font = AllFont(12);
            
            tempLabel.text = dict[@"content"];
            
            [tempLabel autoHeight];
            
            [_views addObject:tempLabel];
            
        }else
        {
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(19), 0, MSW-Width320(38), 5000)];
            
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            
            [_views addObject:imgView];
            
            __weak typeof(self)weakS = self;
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"content"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                weakS.currentNum ++;
                
                [imgView changeHeight:image.size.height*((MSW-Width320(38))/image.size.width)];
                
                [weakS AllFinish];
                
            }];
            
        }
        
    }
    
    _dataFinish = YES;
    
    [self AllFinish];
    
}

-(void)AllFinish
{
    
    if (_dataFinish && _currentNum == _imgNum) {
        
        CGFloat top = 0;
        
        for (UIView *view in _views) {
            
            [view changeTop:top];
            
            [self addSubview:view];
            
            top += view.height+Height320(10.5);
            
        }
        
        [self changeHeight:top];
        
        [self.delegate introViewFinishLoad];
        
    }
    
}

@end
