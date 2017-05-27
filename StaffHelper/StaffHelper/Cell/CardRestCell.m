//
//  CardRestCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRestCell.h"

@interface CardRestCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_receiveLabel;
    
    UILabel *_remarkLabel;
    
    UILabel *_staffLabel;
    
    UILabel *_cancelLabel;
    
    UILabel *_stateLabel;
    
    UIButton *_cancelButton;
    
    UIButton *_backOfLeaveButton;
}

@end

@implementation CardRestCell
{
    UIView *_bottomView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(130))];
        
        view.backgroundColor = UIColorFromRGB(0xffffff);
        
        _bottomView = view;
        
        [self.contentView addSubview:view];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(225), Height320(16))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [view addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), MSW-Width320(24), Height320(14))];
        
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _timeLabel.font = AllFont(13);
        
        [view addSubview:_timeLabel];
        
        _receiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.left, _timeLabel.bottom+Height320(6), _timeLabel.width, _timeLabel.height)];
        
        _receiveLabel.textColor = UIColorFromRGB(0x666666);
        
        _receiveLabel.font = AllFont(13);
        
        [view addSubview:_receiveLabel];
        
        _remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.left, _receiveLabel.bottom+Height320(6), _timeLabel.width, Height320(14))];
        
        _remarkLabel.textColor = UIColorFromRGB(0x666666);
        
        _remarkLabel.font = AllFont(13);
        
        _remarkLabel.numberOfLines = 0;
        
        [view addSubview:_remarkLabel];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.left, _remarkLabel.bottom+Height320(6), _timeLabel.width, Height320(14))];
        
        _stateLabel.textColor = UIColorFromRGB(0x666666);
        
        _stateLabel.font = AllFont(13);
        
        _stateLabel.numberOfLines = 0;
        
        [view addSubview:_stateLabel];

        
        _staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(_remarkLabel.left, _stateLabel.bottom + Height320(6), _remarkLabel.width, _remarkLabel.height)];
        
        _staffLabel.textColor = UIColorFromRGB(0x999999);
        
        _staffLabel.font = AllFont(13);
        
        [view addSubview:_staffLabel];
        
        _cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(72), Height320(6), Width320(60), Height320(24))];
        
        _cancelLabel.font = AllFont(13);
        
        _cancelLabel.text = @"已取消";
        
        _cancelLabel.textColor = UIColorFromRGB(0x999999);
        
        _cancelLabel.textAlignment = NSTextAlignmentRight;
        
        [view addSubview:_cancelLabel];
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, view.bottom+1, MSW / 2.0, Height320(45))];
        
        _cancelButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [_cancelButton setTitle:@"删除请假" forState:UIControlStateNormal];
        
        [_cancelButton setTitleColor:UIColorFromRGB(0xF9944E) forState:UIControlStateNormal];
        
        _cancelButton.titleLabel.font = AllFont(17);
        
        [self.contentView addSubview:_cancelButton];
        
        [_cancelButton addTarget:self.delegate action:@selector(deleteRest:) forControlEvents:UIControlEventTouchUpInside];
        
        _backOfLeaveButton = [[UIButton alloc]initWithFrame:CGRectMake(0, view.bottom+1, MSW / 2.0, Height320(45))];
        
        _backOfLeaveButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [_backOfLeaveButton setTitle:@"提前销假" forState:UIControlStateNormal];
        
        [_backOfLeaveButton setTitleColor:YFThreeChartDeColor forState:UIControlStateNormal];
        
        _backOfLeaveButton.titleLabel.font = AllFont(17);
        
        [self.contentView addSubview:_backOfLeaveButton];
        
        [_backOfLeaveButton addTarget:self.delegate action:@selector(backOfLeaveAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return self;
    
}

- (CGFloat)getCellHeight
{
    if (self.restStatus == CardRestStatusNormal)
    {
    return _cancelButton.bottom + 10;
    }
    else
    {
        return _bottomView.bottom + 15;
    }
    
}

-(void)setTag:(NSInteger)tag
{
    
    _cancelButton.tag = tag;
    
    _backOfLeaveButton.tag = tag;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    
}

-(void)setStartTime:(NSString *)startTime
{
    
    _startTime = startTime;
    
    if (_startTime.length && _endTime.length) {
        
        _timeLabel.text = [NSString stringWithFormat:@"时间：%@ 至 %@",_startTime,_endTime];
        
    }
    
}

-(void)setEndTime:(NSString *)endTime
{
    
    _endTime = endTime;
    
    if (_startTime.length && _endTime.length) {
        
        _timeLabel.text = [NSString stringWithFormat:@"时间：%@ 至 %@",_startTime,_endTime];
        
    }
    
}

-(void)setReceive:(NSInteger)receive
{
    
    _receive = receive;
    
    _receiveLabel.text = [NSString stringWithFormat:@"收费：%ld元",(long)_receive];
    
}

-(void)setRemark:(NSString *)remark
{
    _remark = remark;
    
    _remarkLabel.text = [NSString stringWithFormat:@"备注：%@",_remark.length?_remark:@""];
}

-(void)setRestStatus:(CardRestStatus)restStatus
{
    _restStatus = restStatus;
    
    if (_restStatus == CardRestStatusNormal) {
        
        _cancelLabel.hidden = YES;
        
        _backOfLeaveButton.hidden = NO;
        
        _cancelButton.hidden = NO;
        
        _staffLabel.hidden = NO;
        
        _stateLabel.text = [NSString stringWithFormat:@"状态：%@",@"进行中"];
    }
    else
    {
        _staffLabel.hidden = YES;
     
        if (_restStatus == CardRestStatusStop)
        {
        _stateLabel.text = [NSString stringWithFormat:@"状态：%@",@"已删除"];
        }
        else if (_restStatus == CardRestStatusAreadyBackFromLeave)
        {
            _stateLabel.text = [NSString stringWithFormat:@"状态：%@",@"已提前销假"];
        }
        else
        {
            _stateLabel.text = [NSString stringWithFormat:@"状态：%@",@"请假已结束"];
        }
        _cancelLabel.hidden = YES;
        
        _cancelButton.hidden = YES;
        
        _backOfLeaveButton.hidden = YES;
    }
}
- (void)setStateStr:(NSString *)stateStr
{
    _stateStr = stateStr;
}

-(void)setOperateTime:(NSString *)operateTime
{
    
    _operateTime = operateTime;
    
    _staffLabel.text = [NSString stringWithFormat:@"%@  操作人：%@",_operateTime,_staffName];
    
}

-(void)setStaffName:(NSString *)staffName
{
    
    _staffName = staffName;
    
    _staffLabel.text = [NSString stringWithFormat:@"%@  操作人：%@",_operateTime,_staffName.length?_staffName:@""];
    
}

- (void)setRemarkHeight:(CGFloat)remarkHeight
{
    _remarkHeight = remarkHeight;
    
    [_remarkLabel changeHeight:remarkHeight];
    
    _stateLabel.frame = CGRectMake(_timeLabel.left, _remarkLabel.bottom+Height320(6), _timeLabel.width, Height320(14));

    _staffLabel.frame = CGRectMake(_remarkLabel.left, _stateLabel.bottom + Height320(6), _remarkLabel.width, Height320(28));

    if (_staffLabel.hidden == NO)
    {
        [_bottomView changeHeight:_staffLabel.bottom];
    }
    else
    {
        [_bottomView changeHeight:_stateLabel.bottom + 10];
    }
    
    _cancelLabel.frame = CGRectMake(MSW-Width320(72), Height320(6), Width320(60), Height320(24));
    
    if (_backOfLeaveButton.hidden == YES)
    {
        _cancelButton.frame = CGRectMake(0, _bottomView.bottom+1, MSW, Height320(40));

    }else
    {
        _cancelButton.frame = CGRectMake(0, _bottomView.bottom+1, MSW / 2.0, Height320(40));
    }
    
    _backOfLeaveButton.frame = CGRectMake(MSW / 2.0, _bottomView.bottom+1, MSW / 2.0, Height320(40));

}

@end
