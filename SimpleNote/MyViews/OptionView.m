//
//  OptionView.m
//  SimpleNote
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 com. All rights reserved.
//

#import "OptionView.h"
#import <Masonry.h>

@interface OptionView ()
{
    NSString * _titleContent;
    OptionViewType _type;
}
@property(nonatomic, strong)UIButton *checkButton;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UITextField *textField;

@end

@implementation OptionView

- (UIButton *)checkButton{
    if (!_checkButton) {
        _checkButton = [[UIButton alloc] init];
        [_checkButton setImage:[UIImage imageNamed:@"check_null"] forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage imageNamed:@"check_in"] forState:UIControlStateSelected];
        [_checkButton addTarget:self action:@selector(selecedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = TextColor;
    }
    return _titleLabel;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        [_textField setSecureTextEntry:YES];
        [_textField setBackground:[UIImage imageNamed:@"input_line"]];
        _textField.userInteractionEnabled = NO;
    }
    return _textField;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title type:(OptionViewType)type{
    if (self = [super initWithFrame:frame]) {
        _titleContent = title;
        _type = type;
        [self setupView];
        
    
    }
    return self;
}

- (void)setupView{
    [self addSubview:self.checkButton];
    [self addSubview:self.titleLabel];
    switch (_type) {
        case OptionViewTypeFingure:
        case OptionViewTypeSound:
            break;
        case OptionViewTypePwd:
            [self addSubview:self.textField];
            break;
        default:
            break;
    }
    
    self.titleLabel.text = _titleContent;
    [self.titleLabel sizeToFit];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(5);
        make.width.height.mas_equalTo(44);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.checkButton.mas_right).offset(0);
    }];
    
    if (_type == OptionViewTypePwd) {
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLabel).offset(CGRectGetWidth(self.titleLabel.frame)+5);
            make.right.equalTo(self).offset(-5);
            make.height.mas_equalTo(44);
        }];
    }
  
}

- (void)selecedAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.textField.userInteractionEnabled = YES;
        [self.textField becomeFirstResponder];
    }else{
        self.textField.userInteractionEnabled = NO;
    }
}

- (void)setSelect:(BOOL)select{
    self.checkButton.selected = select;
    if (_type == OptionViewTypePwd) {
        if (select) {
            self.textField.userInteractionEnabled = YES;
            [self.textField becomeFirstResponder];
        }else{
            self.textField.userInteractionEnabled = NO;
            [self.textField endEditing:YES];
        }
      
    }
}

-(BOOL)isSelect{
    return self.checkButton.isSelected;
}

-(NSString *)pwdContent{
    if (_type != OptionViewTypePwd) {
        NSLog(@"指纹模式下没有密码");
        return nil;
    }
    return self.textField.text;
}

- (CGFloat)widthOfContent:(NSString *)content{
    CGSize size = [content boundingRectWithSize:CGSizeMake(1000, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    NSLog(@"width = %f，heigth = %f",size.width,size.height);
    return size.width;
}

@end
