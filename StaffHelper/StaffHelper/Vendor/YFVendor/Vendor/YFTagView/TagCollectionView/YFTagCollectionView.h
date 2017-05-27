//
//  YFTagCollectionView.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFCollectionView.h"

#import "YFTextView.h"

#import "YFTagFooterModel.h"

#import "YFAddTagModel.h"

// 改天这个 空格的值，需要改变宏
#define YFSpaceTextLength 26

@interface YFTagCollectionView : YFCollectionView

@property(nonatomic, strong)YFAddTagModel * addModel;

// 删除标签 Block
@property(nonatomic, copy)void(^deleteBlock)(id);

@property(nonatomic, strong)YFTagFooterModel *footerModel;

@property(nonatomic, strong)UITextView *textView;

@property(nonatomic, copy)void(^addTagBlock)(id);

@property(nonatomic, copy)void(^moreTagBlock)(id);


-(void)addTagModelsArray:(NSMutableArray *)array;


- (NSMutableArray *)getTagModelsArray;

- (BOOL)isHaveTagData;
@end
