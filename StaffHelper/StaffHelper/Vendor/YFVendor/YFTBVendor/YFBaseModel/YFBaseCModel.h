//
//  YFBaseCModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseModel.h"

#import "YFBaseCell.h"

#import "YFBaseCViewCell.h"

#import "YFBaseVC.h"

@interface YFBaseCModel : YFBaseModel

@property(nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic,weak)YFBaseCell *weakCell;

@property(nonatomic,strong)Class cellClass;

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,copy)NSString *cellIdentifier;

@property(nonatomic,copy)NSString *cellNibName;

@property(nonatomic,assign)UIEdgeInsets edgeInsets;

// CollectionView
@property(nonatomic,assign)CGSize cellSize;
@property(nonatomic,copy)NSString *cvCellIdentifier;


//跳转页面
@property(nonatomic,copy)void(^pushVC)(UIViewController*);


-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object;

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath*)indexPath;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC;

-(YFBaseCell *)cellWithWeakVC:(YFBaseVC *)weakVC;

// collectionViewCell
-(void)bindCollVCell:(YFBaseCViewCell *)baseCell indexPath:(NSIndexPath *)indexPath;

-(void)bindCollVFooterOrHeader:(UICollectionReusableView *)headerFooterView indexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@property(nonatomic, copy)void(^selectBlock)(id);

+ (instancetype)defaultWithYYModelDic:(NSDictionary *)dic selectBlock:(void(^)(id))selectBlock;

+ (UIImage *)sexImageWithGender:(NSString *)gender;
- (void)setScaleHeight;

// 默认图
+ (UIImage *)placeHolderImageWithGender:(NSString *)gender;

@end
