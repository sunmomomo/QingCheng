//
//  GymBrandCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymBrandCell.h"

static NSString *identifier = @"Cell";

@interface GymBrandCellGymCell : UITableViewCell

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@end

@implementation GymBrandCellGymCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(16), Height(16), Width(48), Height(48))];
        
        self.iconView.layer.cornerRadius = self.iconView.width/2;
        
        self.iconView.layer.masksToBounds = YES;
        
        self.iconView.layer.borderWidth = OnePX;
        
        self.iconView.layer.borderColor = [UIColorFromRGB(0x333333)colorWithAlphaComponent:0.12].CGColor;
        
        [self.contentView addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width(12), Height(20), Width(240), Height(19))];
        
        self.titleLabel.textColor = UIColorFromRGB(0x333333);
        
        self.titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:self.titleLabel];
        
        self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height(4), self.titleLabel.width, Height(17))];
        
        self.subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        self.subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:self.subtitleLabel];
        
    }
    
    return self;
    
}

@end

@interface GymBrandCell ()<UITableViewDelegate,UITableViewDataSource>

{
    
    UITableView *_gymView;
    
    UIView *_brandBlackView;
    
    UIImageView *_brandBackImgView;
    
    UIImageView *_brandIconView;
    
    UILabel *_brandNameLabel;
    
}

@end

@implementation GymBrandCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _gymView = [[UITableView alloc]initWithFrame:CGRectMake(Width(12), Height(8), MSW-Width(24), Height(133)) style:UITableViewStylePlain];
        
        _gymView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _gymView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _gymView.layer.borderWidth = OnePX;
        
        _gymView.layer.masksToBounds = YES;
        
        _gymView.dataSource = self;
        
        _gymView.delegate = self;
        
        _gymView.layer.cornerRadius = Width(4);
        
        _gymView.scrollEnabled = NO;
        
        _gymView.tableFooterView = [UIView new];
        
        [_gymView registerClass:[GymBrandCellGymCell class] forCellReuseIdentifier:identifier];
        
        [self.contentView addSubview:_gymView];
        
        _brandBackImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MSW-Width(24), Height(133))];
        
        _brandBackImgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _brandBackImgView.layer.masksToBounds = YES;
        
        _brandBackImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        _brandBackImgView.userInteractionEnabled = YES;
        
        _gymView.tableHeaderView = _brandBackImgView;
        
        _brandBlackView = [[UIView alloc]initWithFrame:_brandBackImgView.frame];
        
        _brandBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.38];
        
        [_brandBackImgView addSubview:_brandBlackView];
        
        _brandIconView = [[UIImageView alloc]initWithFrame:CGRectMake(_brandBackImgView.width/2-Width(32), Height(20), Width(64), Height(64))];
        
        _brandIconView.layer.cornerRadius = _brandIconView.width/2;
        
        _brandIconView.layer.masksToBounds = YES;
        
        _brandIconView.layer.borderColor = [UIColorFromRGB(0xffffff)colorWithAlphaComponent:0.6].CGColor;
        
        _brandIconView.layer.borderWidth = OnePX;
        
        [_brandBackImgView addSubview:_brandIconView];
        
        _brandNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _brandIconView.bottom+Height(10), _brandBackImgView.width, Height(21))];
        
        _brandNameLabel.textColor = UIColorFromRGB(0xffffff);
        
        _brandNameLabel.textAlignment = NSTextAlignmentCenter;
        
        _brandNameLabel.font = AllFont(16);
        
        [_brandBackImgView addSubview:_brandNameLabel];
        
        UIButton *manageButton = [[UIButton alloc]initWithFrame:CGRectMake(_brandBackImgView.width-Width(95), Height(20), Width(77), Height(28))];
        
        manageButton.backgroundColor = [UIColor clearColor];
        
        manageButton.layer.cornerRadius = Width(2);
        
        manageButton.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        manageButton.layer.borderWidth = OnePX;
        
        [manageButton setTitle:@"管理品牌" forState:UIControlStateNormal];
        
        [manageButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        manageButton.titleLabel.font = AllFont(13);
        
        [_brandBackImgView addSubview:manageButton];
        
        [manageButton addTarget:self action:@selector(manage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)manage:(UIButton*)button
{
    
    if ([self.delegate respondsToSelector:@selector(manageBrand:)]) {
        
        [self.delegate manageBrand:self.brand];
        
    }
    
}

-(void)setBrand:(Brand *)brand
{
    
    _brand = brand;
    
    if (_brand.imgURL.absoluteString.length) {
        
        [_brandIconView sd_setImageWithURL:_brand.imgURL placeholderImage:[UIImage imageNamed:@"gymplaceholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image.size.width && image.size.height) {
                
                _brandBlackView.hidden = NO;
                
            }else{
                
                _brandBlackView.hidden = YES;
                
            }
            
        }];
        
        [_brandBackImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!gaussblur",_brand.imgURL.absoluteString]] placeholderImage:[UIImage imageNamed:@"bg_brand"]];
        
    }else{
        
        _brandIconView.image = [UIImage imageNamed:@"gymempty"];
        
        _brandBackImgView.image = [UIImage imageNamed:@"bg_brand"];
        
        _brandBlackView.hidden = YES;
        
    }
    
    _brandNameLabel.text = _brand.name;
    
}

-(void)setGyms:(NSArray *)gyms
{
    
    _gyms = gyms;
    
    [_gymView reloadData];
    
    [_gymView changeHeight:Height(133)+gyms.count*Height(80)];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _gyms.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymBrandCellGymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = _gyms[indexPath.row];
    
    [cell.iconView sd_setImageWithURL:gym.imgUrl];
    
    cell.titleLabel.text = gym.name;
    
    cell.subtitleLabel.text = gym.contact;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height(80);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Gym *gym = _gyms[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(gymBrandCellDidSelectGym:)]) {
        
        [self.delegate gymBrandCellDidSelectGym:gym];
        
    }
    
}

@end
