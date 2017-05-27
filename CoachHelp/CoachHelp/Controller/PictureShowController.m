//
//  PictureShowController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/9.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "PictureShowController.h"

#import "MOActionSheet.h"

@interface PictureShowController ()<UIScrollViewDelegate,MOActionSheetDelegate>

{
    
    UIScrollView *_mainView;
    
    UIImageView *_imgView;
    
    UILongPressGestureRecognizer *_press;
    
    MBProgressHUD *_hud;
    
    UIActivityIndicatorView *_activityView;
    
}

@end

@implementation PictureShowController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0x000000);
    
    _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    _mainView.backgroundColor = UIColorFromRGB(0x000000);
    
    _mainView.delegate = self;
    
    _mainView.maximumZoomScale = 1.5;
    
    _mainView.minimumZoomScale = 1;
    
    [self.view addSubview:_mainView];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    _imgView.userInteractionEnabled = YES;
    
    [_mainView addSubview:_imgView];
    
    [_mainView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)]];
    
    _press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction:)];
    
    [_mainView addGestureRecognizer:_press];
    
    _hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    _hud.mode = MBProgressHUDModeText;
    
    _hud.label.text = @"成功保存到相册";
    
    [self.view addSubview:_hud];
    
    if (self.image) {
        
        _imgView.image = self.image;
        
        _imgView.frame = CGRectMake(0, 0, MSW, self.image.size.height/self.image.size.width*MSW);
        
        _imgView.center = CGPointMake(MSW/2, MSH/2);
        
    }
    
    if (self.imageURL) {
        
        _activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        [_activityView startAnimating];
        
        [self.view addSubview:_activityView];
        
        [_imgView sd_setImageWithURL:self.imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [_activityView stopAnimating];
            
            [_activityView removeFromSuperview];
            
            _imgView.frame = CGRectMake(0, 0, MSW, image.size.height/image.size.width*MSW);
            
            _imgView.center = CGPointMake(MSW/2, MSH/2);
            
        }];
        
    }
    
}

-(void)imageAction:(UILongPressGestureRecognizer*)press
{
    
    if (press.state == UIGestureRecognizerStateBegan) {
        
        MOActionSheet *sheet = [MOActionSheet actionSheetWithTitie:nil delegate:self destructiveButtonTitle:nil cancelButtonTitle:@"取消" otherButtonTitles:@"保存图片",nil];
        
        [sheet show];
        
    }
    
}

-(void)actionSheet:(MOActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    [_mainView addGestureRecognizer:_press];
    
    if (buttonIndex == 1) {
        
        UIImageWriteToSavedPhotosAlbum(_imgView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        
    }
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (!error) {
        
        [_hud showAnimated:YES];
        
        [_hud hideAnimated:YES afterDelay:1.0f];
        
    }
    
}

-(void)imageTap:(UITapGestureRecognizer*)tap
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePinch:(UIPinchGestureRecognizer*)pinch
{
    
    if (pinch.state == UIGestureRecognizerStateBegan || pinch.state == UIGestureRecognizerStateChanged) {
        
        _imgView.transform = CGAffineTransformScale(_imgView.transform, pinch.scale, pinch.scale);
        
        pinch.scale = 1;
        
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    _imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,scrollView.contentSize.height * 0.5 + offsetY);
    
}

@end
