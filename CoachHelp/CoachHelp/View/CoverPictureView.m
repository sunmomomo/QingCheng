//
//  CoverPictureView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoverPictureView.h"

#import "MOImageButton.h"

@interface CoverPictureView ()<UIScrollViewDelegate>

{
    
    UIPageControl *_pageControl;
    
    UIScrollView *_pictureView;
    
    UIView *_showAllView;
    
    NSMutableArray *_imageViewArray;
    
}

@end

@implementation CoverPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageViewArray = [NSMutableArray array];
        
        _pictureView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _pictureView.backgroundColor = UIColorFromRGB(0xE8E8E8);
        
        _pictureView.delegate = self;
        
        _pictureView.pagingEnabled = YES;
        
        _pictureView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_pictureView];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-Height320(22), frame.size.width, Height320(22))];
        
        [self addSubview:_pageControl];
        
        _showAllView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(52), frame.size.height)];
        
        [_pictureView addSubview:_showAllView];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(8), _pictureView.height/2-Height320(7), Width320(14), Height320(14))];
        
        arrow.image = [UIImage imageNamed:@"circle_border_arrow"];
        
        [_showAllView addSubview:arrow];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(arrow.right, 0, Width320(24), _showAllView.height)];
        
        label.numberOfLines = 0;
        
        label.text = @"滑\n动\n查\n看\n所\n有\n照\n片";
        
        label.textColor = UIColorFromRGB(0x6666666);
        
        label.font = AllFont(10);
        
        label.tag = 0;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [_showAllView addSubview:label];
        
    }
    
    return self;
    
}

-(void)setDatasource:(id<CoverPictureViewDatasource>)datasource
{
    
    _datasource = datasource;
    
    [self reload];
    
}

-(void)reload
{
    
    _pageControl.hidden = [self.datasource pictureNumberOfCoverPicutreView:self]<=1;
    
    if (_imageViewArray.count>[self.datasource pictureNumberOfCoverPicutreView:self]) {
        
        _imageViewArray = [[_imageViewArray subarrayWithRange:NSMakeRange(0, [self.datasource pictureNumberOfCoverPicutreView:self])] mutableCopy];
        
    }else if (_imageViewArray.count<[self.datasource pictureNumberOfCoverPicutreView:self]){
        
        for (NSInteger i = _imageViewArray.count; i<[self.datasource pictureNumberOfCoverPicutreView:self]; i++) {
            
            MOImageButton *imageView = [[MOImageButton alloc]initWithFrame:CGRectMake(i*_pictureView.width, 0, _pictureView.width, _pictureView.height)];
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            imageView.tag = i;
            
            imageView.layer.masksToBounds = YES;
            
            [imageView addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_imageViewArray addObject:imageView];
            
            [_pictureView addSubview:imageView];
            
        }
        
    }
    
    if (!_imageViewArray.count) {
        
        for (UIView *subView in _pictureView.subviews) {
            
            if ([subView isKindOfClass:[MOImageButton class]]) {
                
                [subView removeFromSuperview];
                
            }
            
        }
        
        UIButton *label = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _pictureView.width, _pictureView.height)];
        
        [label setTitle:@"暂无封面照片" forState:UIControlStateNormal];
        
        [label setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        label.titleLabel.font = AllFont(25);
        
        label.tag = 999;
        
        [_pictureView addSubview:label];
        
        [label addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _pictureView.contentSize = CGSizeMake(MSW, 0);
        
        [_showAllView changeLeft:MSW];
        
    }else{
        
        for (UIView *subview in _pictureView.subviews) {
            
            if (subview.tag == 999) {
                
                [subview removeFromSuperview];
                
            }
            
        }
        
        for (NSInteger i = 0; i<_imageViewArray.count; i++) {
            
            MOImageButton *imageView = _imageViewArray[i];
            
            if ([self.datasource respondsToSelector:@selector(coverPictureView:pictureInIndex:)]) {
                
                imageView.image = [self.datasource coverPictureView:self pictureInIndex:i];
                
            }else if ([self.datasource respondsToSelector:@selector(coverPictureView:pictureURLInIndex:)]){
                
                imageView.imageURL = [self.datasource coverPictureView:self pictureURLInIndex:i];
                
            }
            
        }
        
        _pictureView.contentSize = CGSizeMake([self.datasource pictureNumberOfCoverPicutreView:self]*MSW, 0);
        
        if ([self.datasource pictureNumberOfCoverPicutreView:self] == 1) {
            
            _pictureView.contentSize = CGSizeMake(MSW+_showAllView.width, 0);
            
        }
        
        [_showAllView changeLeft:[self.datasource pictureNumberOfCoverPicutreView:self]*MSW];
        
        if (_pictureView.contentOffset.x>([self.datasource pictureNumberOfCoverPicutreView:self]-1)*MSW) {
            
            [_pictureView setContentOffset:CGPointMake(([self.datasource pictureNumberOfCoverPicutreView:self]-1)*MSW, 0) animated:NO];
            
            _pageControl.currentPage = [self.datasource pictureNumberOfCoverPicutreView:self]-1;
            
        }
        
        _pageControl.numberOfPages = [self.datasource pictureNumberOfCoverPicutreView:self];
        
    }
    
}

-(void)labelClick:(UIButton*)button
{
    
    [self.datasource coverPictureView:self pictureSelectedAtIndex:button.tag];
    
}

-(void)imageClick:(UIButton*)button
{
    
    [self.datasource coverPictureView:self pictureSelectedAtIndex:button.tag];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.width;
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.width;
    
    if (scrollView.contentOffset.x>([self.datasource pictureNumberOfCoverPicutreView:self]-1)*scrollView.width+Width320(52)) {
        
        [self.datasource showAllPicture];
        
    }
    
}

@end
