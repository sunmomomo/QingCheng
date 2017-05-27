//
//  CourseSummaryView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseSummaryView.h"

#import "UIImage+Category.h"

@interface CourseSummaryView ()<UIWebViewDelegate>

{
    
    UIWebView *_webView;
    
    UIButton *_editButton;
    
    UILabel *_emptyLabel;
    
}

@end

@implementation CourseSummaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(6), Width320(3), Height320(14))];
        
        greenView.backgroundColor = UIColorFromRGB(0x0DB14B);
        
        [self addSubview:greenView];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), 0, Width320(100), Height320(26))];
        
        topLabel.text = @"课程简介";
        
        topLabel.textColor = UIColorFromRGB(0x666666);
        
        topLabel.font = AllFont(12);
        
        [self addSubview:topLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(10), Height320(26)-1/[UIScreen mainScreen].scale, MSW-Width320(20), 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:sep];
        
        _editButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(102), 0, Width320(102), Height320(26))];
        
        [self addSubview:_editButton];
        
        UIImageView *editImage = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(6), Height320(7), Width320(12), Height320(12))];
        
        editImage.image = [[UIImage imageNamed:@"navi_edit"] imageWithTintColor:UIColorFromRGB(0xcccccc)];
        
        [_editButton addSubview:editImage];
        
        UILabel *editLabel = [[UILabel alloc]initWithFrame:CGRectMake(editImage.right+Width320(6), 0, _editButton.width-editImage.right-Width320(6), _editButton.height)];
        
        editLabel.text = @"编辑简介详情";
        
        editLabel.textColor = UIColorFromRGB(0x999999);
        
        editLabel.font = AllFont(12);
        
        [_editButton addSubview:editLabel];
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, Height320(34), MSW, Height320(500))];
        
        _webView.delegate = self;
        
        _webView.scrollView.scrollEnabled = NO;
        
        [self addSubview:_webView];
      
        _emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(26), MSW, Height320(51))];
        
        _emptyLabel.text = @"暂无简介";
        
        _emptyLabel.textColor = UIColorFromRGB(0x999999);
        
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        
        _emptyLabel.font = AllFont(12);
        
        [self addSubview:_emptyLabel];
        
        _emptyLabel.hidden = YES;
        
    }
    
    return self;
    
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    
    [_editButton addTarget:target action:action forControlEvents:controlEvents];
    
}


-(void)setHtmlData:(NSString *)htmlData
{
    
    _htmlData = htmlData;
    
    if (htmlData.length) {
        
        NSString *htmlContent = [NSString stringWithFormat:@"<html><head><title>容器</title><meta name=\"viewport\" content=\"width=device-width,initial-scale=1,user-scalable=no\"><style type=\"text/css\">body{overflow-x:hidden;overflow-y:auto;}.richTxtCtn{margin:0;padding:0;}.richTxtCtn *{max-width:100%% !important;}</style></head><body><div class=\"richTxtCtn\">%@</div></body></html>",htmlData];
        
        _emptyLabel.hidden = YES;
        
        _webView.hidden = NO;
        
        @try {
            
            [_webView loadHTMLString:htmlContent baseURL:nil];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }else{
        
        [self changeHeight:Height320(77)];
        
        _emptyLabel.hidden = NO;
        
        _webView.hidden = YES;
        
        if ([self.superview isKindOfClass:[UIScrollView class]]) {
            
            ((UIScrollView*)self.superview).contentSize = CGSizeMake(0,self.bottom+Height320(10));
            
        }
        
    }
    
}

-(void)dealloc
{
    
    [_webView stopLoading];
    
    _webView.delegate = nil;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    float webViewHeight = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    [webView changeHeight:webViewHeight+Height320(8)];
    
    [self changeHeight:webView.bottom];
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        ((UIScrollView*)self.superview).contentSize = CGSizeMake(0,self.bottom+Height320(10));
        
    }
    
}

@end
