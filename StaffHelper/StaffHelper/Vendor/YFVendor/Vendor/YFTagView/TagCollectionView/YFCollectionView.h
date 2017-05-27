//
//  YFCollectionView.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFTagColloectionViewCell.h"

@interface YFCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSMutableArray *allSectionArray;


@property(nonatomic, strong)NSMutableArray *modelArray;

@property(nonatomic, strong)NSMutableArray *footerModelArray;


- (UICollectionViewFlowLayout *)flowOutYF;

@end
