//
//  EncryptViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 com. All rights reserved.
//

#import "EncryptViewController.h"
#import "OptionView.h"

@interface EncryptViewController ()

@property(nonatomic, strong)OptionView *optView1;
@property(nonatomic, strong)OptionView *optView2;
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UIButton *saveButton;

@end

@implementation EncryptViewController

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField.frame)+25, MZWIDTH-60, 44)];
        _saveButton.layer.cornerRadius = 10;
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_saveButton setTitleColor:AppColor forState:UIControlStateNormal];
        _saveButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        [_saveButton setTitle:LocalizedString(@"saveOver") forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (OptionView *)optView1{
    if (!_optView1) {
        _optView1 = [[OptionView alloc] initWithFrame:CGRectMake(20, 60, MZWIDTH-40, 60) title:@"指纹加密" type:OptionViewTypeFingure];
    }
    return _optView1;
}

- (OptionView *)optView2{
    if (!_optView2) {
        _optView2 = [[OptionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.optView1.frame)+20, MZWIDTH-40, 60) title:@"密码加密" type:OptionViewTypePwd];
    }
    return _optView2;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(self.label.frame)+15, MZWIDTH-40, 50)];
        _textField.placeholder = @"请输入提示词";
        _textField.textColor = TextColor;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.background = [UIImage imageNamed:@"input_line"];
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"加密设置";
    
    [self.view addSubview:self.optView1];
    [self.view addSubview:self.optView2];
    
    [self.optView1 addObserver:self forKeyPath:@"checkButton.selected" options:NSKeyValueObservingOptionNew context:@"opt1"];
    [self.optView2 addObserver:self forKeyPath:@"checkButton.selected" options:NSKeyValueObservingOptionNew context:@"opt2"];
    
    // 设置提示词
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(self.optView2.frame)+20, 10, 30)];
    self.label = label;
    [self.view addSubview:label];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = TextColor;
    label.text = LocalizedString(@"contentTips");
    [label sizeToFit];
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.saveButton];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"checkButton.selected"]) {
        if ([((__bridge NSString *)context) isEqualToString:@"opt1"]) {
            if ([change[NSKeyValueChangeNewKey] boolValue] == YES) {
                self.optView2.select = NO;
            }
        }else if ([((__bridge NSString *)context) isEqualToString:@"opt2"]){
            if ([change[NSKeyValueChangeNewKey] boolValue] == YES) {
                self.optView1.select = NO;
            }
        }
    }
    
}

- (void)saveAction{
    
    NSLog(@"keep");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end