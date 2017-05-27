//
//  CoursePictureShowController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePictureShowController.h"

#import "MOActionSheet.h"

@interface CoursePictureShowController ()<UIScrollViewDelegate>

{
    
    UIScrollView *_mainView;
    
}

@end

@implementation CoursePictureShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)createUI
{
    
    self.title = @"查看大图";
    
    self.view.backgroundColor = UIColorFromRGB(0x555555);
    
    _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    _mainView.backgroundColor = UIColorFromRGB(0x555555);
    
    _mainView.delegate = self;
    
    _mainView.pagingEnabled = YES;
    
    _mainView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_mainView];
    
    if (self.coursePictures.count) {
        
        for (NSInteger i = 0 ; i<self.coursePictures.count; i++) {
            
            CoursePicture *picture = self.coursePictures[i];
            
            UIView *imageBack = [[UIView alloc]initWithFrame:CGRectMake(i*MSW, 0, MSW, MSH-64)];
            
            [_mainView addSubview:imageBack];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            [imageView sd_setImageWithURL:picture.imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                imageView.frame = CGRectMake(0, 0, MSW, image.size.height/image.size.width*MSW);
                
                imageView.center = CGPointMake(MSW/2, (MSH-64)/2);
                
            }];
            
            [imageBack addSubview:imageView];
            
            if (picture.canSeeUserName.length) {
                
                UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(115), imageBack.height-Height320(50), Width320(12), Height320(9))];
                
                icon.image = [UIImage imageNamed:@"eye"];
                
                [imageBack addSubview:icon];
                
                UILabel *canSeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(icon.right+Width320(6), imageBack.height-Height320(52), MSW-Width320(22)-icon.right, Height320(16))];
                
                canSeeLabel.text = [NSString stringWithFormat:@"仅%@可见",picture.canSeeUserName];
                
                canSeeLabel.textColor = UIColorFromRGB(0xffffff);
                
                canSeeLabel.font = AllFont(12);
                
                [imageBack addSubview:canSeeLabel];
                
            }
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageBack.height-Height320(34), MSW, Height320(16))];
            
            label.text = [NSString stringWithFormat:@"由%@上传  %@",picture.uploadStaffName,picture.uploadTime];
            
            label.textColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.7];
            
            label.textAlignment = NSTextAlignmentCenter;
            
            label.font = AllFont(12);
            
            [imageBack addSubview:label];
            
        }
        
    }
    
    _mainView.contentSize = CGSizeMake(MSW*self.coursePictures.count, 0);
    
    _mainView.contentOffset = CGPointMake(MSW*self.selectNumber, 0);
    
}

@end
