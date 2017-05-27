//
//  ChestAreaSearchView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestAreaSearchView.h"

#import "ChestSearchCell.h"

@interface ChestSearchAllButton : UIButton

{
    
    UILabel *_textLabel;
    
    UIImageView *_checkImg;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL choosed;

@end

@implementation ChestSearchAllButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, self.frame.size.width-Width320(36), self.frame.size.height)];
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(13);
        
        [self addSubview:_textLabel];
        
        _checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(_textLabel.right+Width320(6), Height320(9), Width320(12), Height320(12))];
        
        _checkImg.image = [UIImage imageNamed:@"green_check"];
        
        [self addSubview:_checkImg];
        
        _checkImg.hidden = YES;
        
    }
    
    return self;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _textLabel.textColor = _choosed?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0x333333);
    
    _checkImg.hidden = !_choosed;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(self.frame.size.width-Width320(24), Height320(15)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    [_textLabel changeWidth:size.width];
    
    [_checkImg changeLeft:_textLabel.right+Width320(6)];
    
    _textLabel.text = _title;
    
}

@end

@interface ChestAreaSearchLabel : UIButton

{
    
    UILabel *_textLabel;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL choosed;

@end

@implementation ChestAreaSearchLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        _textLabel.textColor = UIColorFromRGB(0x999999);
        
        _textLabel.font = AllFont(14);
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_textLabel];
        
    }
    
    return self;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _textLabel.textColor = _choosed?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0x333333);
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
}

@end

@interface ChestAreaSearchView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,DZNEmptyDataSetSource>
{
    
    UIScrollView *_areaView;
    
    UIView *_allAreaView;
    
    UIImageView *_arrowImg;
    
    UIView *_allAreaLabelView;
    
    UIView *_lineView;
    
    BOOL _rocate;
    
    UIView *_areaBackView;
    
    ChestArea *_area;
    
    UIScrollView *_contentView;
    
}

@property(nonatomic,strong)UIView *chooseAreaView;

@property(nonatomic,strong)UILabel *chooseAreaLabel;

@property(nonatomic,assign)NSInteger currentRow;

@end

@implementation ChestAreaSearchView

+(instancetype)defaultAreaView
{
    
    ChestAreaSearchView *view = [[ChestAreaSearchView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    return view;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _rocate = NO;
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
        
        topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        topView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:topView];
        
        _areaView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW-Width320(40), Height320(40))];
        
        _areaView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _areaView.showsHorizontalScrollIndicator = NO;
        
        [topView addSubview:_areaView];
        
        _allAreaLabelView = [[UIView alloc]initWithFrame:_areaView.frame];
        
        _allAreaLabelView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [topView addSubview:_allAreaLabelView];
        
        _allAreaLabelView.hidden = YES;
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _areaView.height-Height320(2), Width320(40), Height320(2))];
        
        _lineView.backgroundColor = UIColorFromRGB(0x0DB14B);
        
        [_areaView addSubview:_lineView];
        
        UILabel *allLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(100), Height320(40))];
        
        allLabel.text = @"所有区域";
        
        allLabel.textColor = UIColorFromRGB(0x999999);
        
        allLabel.font = AllFont(13);
        
        [_allAreaLabelView addSubview:allLabel];
        
        UIButton *showAllButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(40), 0, Width320(40), Height320(40))];
        
        showAllButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        showAllButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        showAllButton.layer.shadowOffset = CGSizeMake(-1, 0);
        
        showAllButton.layer.shadowOpacity = 0.1;
        
        [topView addSubview:showAllButton];

        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(12), Height320(7))];
        
        _arrowImg.image = [UIImage imageNamed:@"down_arrow"];
        
        _arrowImg.center = CGPointMake(showAllButton.width/2, showAllButton.height/2);
        
        [showAllButton addSubview:_arrowImg];
        
        [showAllButton addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
        
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, self.height-topView.bottom)];
        
        _contentView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _contentView.delegate = self;
        
        _contentView.pagingEnabled = YES;
        
        _contentView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_contentView];
        
        _areaBackView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, self.height-topView.bottom)];
        
        [self addSubview:_areaBackView];
        
        _areaBackView.hidden = YES;
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _areaBackView.width, _areaBackView.height)];
        
        backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
        
        [_areaBackView addSubview:backView];
        
        _allAreaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 0)];
        
        _allAreaView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _allAreaView.layer.masksToBounds = YES;
        
        [_areaBackView addSubview:_allAreaView];
        
    }
    
    return self;
    
}

-(void)setAllArray:(NSArray *)allArray
{
    
    _allArray = allArray;
    
    [_areaView removeAllView];
    
    CGFloat width = 0;
    
    for (ChestArea *area in _allArray) {
        
        CGSize size = [area.areaName boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
        
        width += size.width+Width320(16);
        
    }
    
    _areaView.contentSize = CGSizeMake(width, 0);
    
    CGFloat left = 0;
    
    if (width<_areaView.width) {
        
        left = (_areaView.width-width)/2;
        
    }
    
    for (NSInteger i = 0; i<_allArray.count; i++) {
        
        ChestArea *area = _allArray[i];
        
        CGSize size = [area.areaName boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
        
        ChestAreaSearchLabel *label = [[ChestAreaSearchLabel alloc]initWithFrame:CGRectMake(left, 0, size.width+Width320(16), Height320(40))];
        
        label.title = area.areaName;
        
        label.choosed = i == _currentRow;
        
        label.tag = i;
        
        [label addTarget:self action:@selector(showAreaClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            [_lineView changeLeft:left];
            
            [_areaView addSubview:_lineView];
            
            [_lineView changeWidth:label.width];
            
            [_areaView bringSubviewToFront:_lineView];
            
        }
        
        [_areaView addSubview:label];
        
        [_areaView sendSubviewToBack:label];
        
        left += size.width+Width320(16);
        
    }
    
    _contentView.contentSize = CGSizeMake(MSW*_allArray.count, 0);
    
    for (NSInteger i = 0 ; i < _allArray.count; i++) {
        
        UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(MSW*i, 0, MSW, Height320(40))];
        
        emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [_contentView addSubview:emptyView];
        
        UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, MSW-Width320(24), Height320(40))];
        
        emptyLabel.textColor = UIColorFromRGB(0x999999);
        
        emptyLabel.font = AllFont(14);
        
        ChestArea *area = self.allArray[i];
        
        NSInteger empty = 0;
        
        for (Chest  *chest in area.chests) {
            
            if (!chest.isUsed) {
                
                empty++;
                
            }
            
        }
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"空闲更衣柜：%ld",(long)empty]];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(6, astr.length-6)];
        
        emptyLabel.attributedText = astr;
        
        [emptyView addSubview:emptyLabel];
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(MSW*i, Height320(40), MSW, _contentView.height-Height320(40)) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        
        collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        collectionView.dataSource = self;
        
        collectionView.delegate = self;
        
        collectionView.emptyDataSetSource = self;
        
        collectionView.tag = i;
        
        [collectionView registerClass:[ChestSearchCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"Cell%ld",(long)i]];
        
        [_contentView addSubview:collectionView];
        
    }
    
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.height-Height320(80))];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(73), Height320(112), Width320(174), Height320(146))];
    
    emptyImg.image = [UIImage imageNamed:@"chest_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(15), MSW, Height320(15))];
    
    emptyLabel.text = @"暂无更衣柜";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = AllFont(13);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    ChestArea *area = self.allArray[collectionView.tag];
    
    return area.chests.count%2?area.chests.count+1:area.chests.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(MSW/2, Height320(90));
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
      
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
      
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0,0, 0, 0);
     
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"Cell%ld",(long)collectionView.tag] forIndexPath:indexPath];
    
    ChestArea *area = self.allArray[collectionView.tag];
    
    cell.haveRightLine = indexPath.row%2==0;
    
    cell.haveBottomLine = area.chests.count%2?indexPath.row >= area.chests.count-1:indexPath.row>=area.chests.count-2;
    
    if (indexPath.row<area.chests.count) {
        
        Chest *chest = area.chests[indexPath.row];
        
        cell.title = chest.name;
        
        cell.canSelected = !chest.isUsed;
        
        cell.choosed = chest.chestId == self.chest.chestId && chest.area.areaId == self.chest.area.areaId;
        
    }else{
        
        cell.title = @"";
        
        cell.canSelected = NO;
        
        cell.choosed = NO;
        
    }
    
    return cell;
    
}

-(void)close
{
    
    [self showAll:nil];
    
}

-(void)showAll:(UIButton*)button
{
    
    _rocate = !_rocate;
    
    if (_rocate) {
        
        _arrowImg.transform = CGAffineTransformMakeRotation(_rocate*M_PI);
        
        _areaBackView.hidden = !_rocate;
        
        _allAreaLabelView.hidden = !_rocate;
        
        [self loadAllView];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [ _allAreaView changeHeight:(_allArray.count%2 == 0?_allArray.count/2:(_allArray.count+1)/2)*Height320(30)+Height320(30)];
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        
        _arrowImg.transform = CGAffineTransformMakeRotation(_rocate*M_PI);
        
        _areaBackView.hidden = !_rocate;
        
        _allAreaLabelView.hidden = !_rocate;
        
        [_allAreaView changeHeight:0];
        
    }
    
}

-(void)loadAllView
{
    
    [_allAreaView removeAllView];
    
    for (NSInteger i = 0; i<_allArray.count; i++) {
        
        ChestSearchAllButton *label = [[ChestSearchAllButton alloc]initWithFrame:CGRectMake(i%2*MSW/2, Height320(15)+((long)i/2*Height320(30)), MSW/2-Width320(30), Height320(30))];
        
        ChestArea *area = _allArray[i];
        
        label.title = area.areaName;
        
        if (_area) {
            
            label.choosed = area.areaId == _area.areaId;
            
        }else{
            
            label.choosed = i == 0;
            
        }
        
        label.tag = i;
        
        [_allAreaView addSubview:label];
        
        [label addTarget:self action:@selector(allLabelClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)allLabelClick:(ChestSearchAllButton*)button
{
    
    ChestArea *area = _allArray[button.tag];
    
    _area = area;
    
    self.currentRow = button.tag;
    
    _contentView.contentOffset = CGPointMake(MSW*button.tag, 0);
    
    [self showAll:nil];
    
}

-(void)showAreaClick:(ChestAreaSearchLabel*)label
{
    
    _contentView.contentOffset = CGPointMake(MSW*label.tag, 0);
    
    self.currentRow = label.tag;
    
}

-(void)setCurrentRow:(NSInteger)currentRow
{
    
    _currentRow = currentRow;
    
    ChestAreaSearchLabel *label = nil;
    
    for (ChestAreaSearchLabel *tempLabel in _areaView.subviews) {
        
        if ([tempLabel isKindOfClass:[ChestAreaSearchLabel class]]) {
            
            tempLabel.choosed = NO;
            
            if (tempLabel.tag == currentRow) {
                
                label = tempLabel;
                
                tempLabel.choosed = YES;
                
            }
            
        }
        
    }
    
    CGFloat width = 0;
    
    for (ChestArea *area in _allArray) {
        
        CGSize size = [area.areaName boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
        
        width += size.width+Width320(16);
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_lineView changeLeft:label.left];
        
        [_lineView changeWidth:label.width];
        
        if (width<_areaView.width) {
            
            _areaView.contentOffset = CGPointMake(0, 0);
            
        }else if (label.left>=_areaView.width/2 && width-label.right>=_areaView.width/2) {
            
            _areaView.contentOffset = CGPointMake(label.center.x-_areaView.width/2, 0);
            
        }else if (label.left>=_areaView.width/2){
            
            _areaView.contentOffset = CGPointMake(_areaView.contentSize.width-_areaView.width, 0);
            
        }else if (width-label.right>=_areaView.width/2){
            
            _areaView.contentOffset = CGPointMake(0, 0);
            
        }
        
    }];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView == _contentView) {
        
        self.currentRow = scrollView.contentOffset.x/MSW;
        
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestArea *area = self.allArray[collectionView.tag];
 
    if (indexPath.row<area.chests.count) {
        
        Chest *chest = area.chests[indexPath.row];
        
        if (!chest.isUsed) {
            
            [self.delegate areaViewChooseChest:chest];
            
        }
        
    }
    
}

-(void)setChest:(Chest *)chest
{
    
    _chest = chest;
    
    if (chest) {
        
        [_contentView changeHeight:self.height-Height320(84)];
        
        for (UIView *subView in _contentView.subviews) {
            
            if ([subView isKindOfClass:[UICollectionView class]]) {
                
                [subView changeHeight:_contentView.height-Height320(40)];
                
            }
            
        }
        
        self.chooseAreaView = [[UIView alloc]initWithFrame:CGRectMake(0, _contentView.bottom, MSW, Height320(44))];
        
        self.chooseAreaView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.chooseAreaView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.chooseAreaView.layer.borderWidth = OnePX;
        
        [self addSubview:self.chooseAreaView];
        
        UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(70), Height320(44))];
        
        chooseLabel.text = @"已选更衣柜：";
        
        chooseLabel.font = AllFont(13);
        
        chooseLabel.textColor = UIColorFromRGB(0x666666);
        
        [chooseLabel autoWidth];
        
        [self.chooseAreaView addSubview:chooseLabel];
        
        self.chooseAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake(chooseLabel.right+Width320(2), Height320(8), MSW-Width320(34)-chooseLabel.right, Height320(28))];
        
        self.chooseAreaLabel.backgroundColor = UIColorFromRGB(0xE6F7ED);
        
        self.chooseAreaLabel.layer.borderWidth = OnePX;
        
        self.chooseAreaLabel.layer.borderColor = UIColorFromRGB(0x8FDBAC).CGColor;
        
        self.chooseAreaLabel.layer.cornerRadius = 2;
        
        self.chooseAreaLabel.layer.masksToBounds = YES;
        
        self.chooseAreaLabel.textColor = kMainColor;
        
        self.chooseAreaLabel.textAlignment = NSTextAlignmentCenter;
        
        self.chooseAreaLabel.text = [NSString stringWithFormat:@"%@（%@）",self.chest.name,self.chest.area.areaName];
        
        self.chooseAreaLabel.font = AllFont(13);
        
        [self.chooseAreaView addSubview:self.chooseAreaLabel];
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(self.chooseAreaLabel.right, 0, MSW-self.chooseAreaLabel.right, Height320(44))];
        
        [self.chooseAreaView addSubview:deleteButton];
        
        UIImageView *deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(8), Height320(14), Width320(16), Height320(16))];
        
        deleteImg.image = [UIImage imageNamed:@"btn_delete"];
        
        [deleteButton addSubview:deleteImg];
        
        [deleteButton addTarget:self action:@selector(deleteChest:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        [self.chooseAreaView removeFromSuperview];
        
        self.chooseAreaView = nil;
        
        [_contentView changeHeight:self.height-Height320(40)];
        
        for (UIView *subView in _contentView.subviews) {
            
            if ([subView isKindOfClass:[UICollectionView class]]) {
                
                [subView changeHeight:_contentView.height-Height320(40)];
                
            }
            
        }
        
    }
    
}

-(void)deleteChest:(UIButton*)button
{
    
    self.chest = nil;
    
}

@end
