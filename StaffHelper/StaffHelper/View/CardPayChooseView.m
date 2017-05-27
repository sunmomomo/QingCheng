//
//  CardPayChooseView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardPayChooseView.h"

static NSString *identifier = @"Cell";

@interface CardPayChooseViewCell : UITableViewCell

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_imageView;
    
    UIImageView *_chooseImgView;
    
    UIButton *_buyButton;
    
    UIView *_line;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,assign)BOOL noCard;

@property(nonatomic,assign)CGFloat lineTop;

-(void)addTarget:(nonnull id)target action:(nonnull SEL)action;

@end

@implementation CardPayChooseViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(9), Width320(24), Height320(24))];
        
        _imageView.layer.cornerRadius = _imageView.width/2;
        
        _imageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.right+Width320(8), Height320(12), MSW-_imageView.right-Width320(24), Height320(16))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, Height320(28), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _chooseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(29), Height320(15), Width320(13), Height320(10))];
        
        _chooseImgView.image = [UIImage imageNamed:@"main_choose"];
        
        _chooseImgView.hidden = YES;
        
        [self.contentView addSubview:_chooseImgView];
        
        _buyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(102), 0, Width320(86), Height320(54))];
        
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        
        [_buyButton setTitleColor:UIColorFromRGB(0xf9944e) forState:UIControlStateNormal];
        
        _buyButton.titleLabel.font = AllFont(14);
        
        _buyButton.hidden = YES;
        
        [self.contentView addSubview:_buyButton];
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(Width320(48), 0, MSW-Width320(48), OnePX)];
        
        _line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:_line];
        
    }
    
    return self;
    
}

-(void)setLineTop:(CGFloat)lineTop
{
    
    _lineTop = lineTop;
    
    [_line changeTop:_lineTop];
    
}

-(void)addTarget:(id)target action:(SEL)action
{
    
    [_buyButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imageView.image = _image;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
    if (_subtitle.length) {
        
        [_titleLabel changeTop:Height320(9)];
        
        [_imageView changeTop:Height320(15)];
        
    }else{
        
        [_titleLabel changeTop:Height320(12)];
        
        [_imageView changeTop:Height320(9)];
        
    }
    
}

-(void)setNoCard:(BOOL)noCard
{
    
    _noCard = noCard;
    
    if (_noCard) {
        
        _chooseImgView.hidden = YES;
        
        _buyButton.hidden = NO;
        
        _titleLabel.text = @"无适用会员卡";
        
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.text = @"";
        
        [_titleLabel changeTop:Height320(19)];
        
        [_imageView changeTop:Height320(15)];
        
    }else{
        
        _buyButton.hidden = YES;
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
    }
    
}

@end

@interface CardPayChooseView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation CardPayChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.isShowCardPay = YES;
        
        self.hidden = YES;
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [self addSubview:backView];
        
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MSH, MSW, MSH-Height320(285))];
        
        self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView registerClass:[CardPayChooseViewCell class] forCellReuseIdentifier:identifier];
        
        [self addSubview:self.tableView];
        
    }
    
    return self;
    
}
- (void)setIsShowCardPay:(BOOL)isShowCardPay
{
    _isShowCardPay = isShowCardPay;
    
    [self.tableView reloadData];
}


+(instancetype)defaultView
{
    
    return [[self alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
}

-(void)show
{
    
    self.hidden = NO;
    
    [self.superview bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isShowCardPay)
        {
        [self.tableView changeTop:Height320(285)];
        }
        else
        {
            [self.tableView changeTop:Height320(320)];
        }
    }];
    
}

-(void)setCards:(NSArray *)cards
{
    
    _cards = cards;
    
    [self.tableView reloadData];
    
}

-(void)close
{
    
    self.hidden = YES;
    
    [self.tableView changeTop:MSH];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isShowCardPay)
    {
        return 2;
    }
    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardPayChooseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.noCard = NO;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                
                cell.image = [UIImage imageNamed:@"pay_cash"];
                
                cell.title = @"现金支付";
                
                break;
            case 1:
                
                cell.image = [UIImage imageNamed:@"pay_card"];
                
                cell.title = @"刷卡支付";
                
                break;
            case 2:
                
                cell.image = [UIImage imageNamed:@"pay_transfer"];
                
                cell.title = @"转账支付";
                
                break;
            case 3:
                
                cell.image = [UIImage imageNamed:@"pay_other"];
                
                cell.title = @"其他";
                
                break;
                
            default:
                break;
        }
        
        cell.subtitle = nil;
        
        cell.choosed = indexPath.row == self.indexPath.row && indexPath.section == self.indexPath.section;
        
        cell.lineTop = Height320(40)-OnePX;
        
    }else{
        
        cell.image = [UIImage imageNamed:@"card_pay_card"];
        
        if (self.cards.count) {
            
            Card *card = self.cards[indexPath.row];
            
            cell.title = card.cardKind.cardKindName;
            
            if (card.cardKind.type == CardKindTypePrepaid) {
                
                cell.subtitle = [NSString stringWithFormat:@"余额：%.0f元",card.remain];
                
            }else if (card.cardKind.type == CardKindTypeCount){
                
                cell.subtitle = [NSString stringWithFormat:@"余额：%.0f次",card.remain];
                
            }else{
                
                cell.subtitle = [NSString stringWithFormat:@"有效期至：%@",[card.end substringToIndex:10]];
                
            }
            
            cell.choosed = indexPath.row == self.indexPath.row && indexPath.section == self.indexPath.section;
            
        }else{
            
            cell.noCard = YES;
            
            [cell addTarget:self.delegate action:@selector(buyCard)];
            
        }
        
        cell.lineTop = Height320(54)-OnePX;
        
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        return Height320(40);
        
    }else{
        
        return Height320(54);
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return Height320(30);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(30))];
    
    view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(10), Width320(200), Height320(14))];
    
    label.text = section == 0?@"线下支付":@"会员卡支付";
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.font = AllFont(12);
    
    [view addSubview:label];
    
    return view;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return 4;
        
    }else{
        
        if (self.cards.count) {
            
            return self.cards.count;
            
        }else{
            
            return 1;
            
        }
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.indexPath = indexPath;
    
    [self.tableView reloadData];
    
    [self close];
    
    if (indexPath.section == 0) {
        
        [self.delegate cardPayChooseCard:nil orPayWay:indexPath.row+1];
        
    }else{
        
        if (self.cards.count) {
            
            Card *card = self.cards[indexPath.row];
            
            [self.delegate cardPayChooseCard:card orPayWay:0];
            
        }else{
            
            [self.delegate cardPayChooseCard:nil orPayWay:0];
            
        }
        
    }
    
}

@end
