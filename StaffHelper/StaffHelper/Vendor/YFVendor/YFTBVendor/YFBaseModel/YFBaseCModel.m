//
//  YFBaseCModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseCModel.h"
#import "YFAppConfig.h"

@implementation YFBaseCModel


-(void)bindCollVCell:(YFBaseCViewCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    
}

- (void)bindCollVFooterOrHeader:(UICollectionReusableView *)headerFooterView indexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    
}

-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock(self);
    }
}

-(NSString *)cellNibName
{
    if (_cellNibName.length == 0)
    {
        return _cellIdentifier;
    }
    return _cellNibName;
}




-(YFBaseCell *)cellWithWeakVC:(YFBaseVC *)weakVC
{
    YFBaseCell *cell;
    
    DebugLogYF(@"%@%@",self.cellNibName,[self class]);
    
    if (self.cellClass)
    {
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:self.cellNibName owner:nil options:nil] firstObject];
    }
    cell.currentVC = weakVC;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    [self setCell:cell toObjectFY:weakVC];
    
    return cell;
}

+ (instancetype)defaultWithYYModelDic:(NSDictionary *)dic selectBlock:(void(^)(id))selectBlock
{
    YFBaseCModel *model =  [super defaultWithYYModelDic:dic];
    
    model.selectBlock = selectBlock;
    
    return model;
}

- (void)setScaleHeight
{
    
}
+ (UIImage *)sexImageWithGender:(NSString *)gender
{
    BOOL ismale = gender.integerValue == 0;

    if (ismale)
    {
        return [UIImage imageNamed:@"sex_male"];
    }else
    {
        return [UIImage imageNamed:@"sex_female"];
    }
}

+ (UIImage *)placeHolderImageWithGender:(NSString *)gender
{
    BOOL ismale = gender.integerValue == 0;
    
    if (ismale)
    {
        return [UIImage imageNamed:@"img_default_student_male"];
    }else
    {
        return [UIImage imageNamed:@"img_default_student_female"];
    }
}


@end
