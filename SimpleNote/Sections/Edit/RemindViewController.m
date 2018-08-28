//
//  RemindViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/25.
//  Copyright © 2018年 com. All rights reserved.
//

#import "RemindViewController.h"
#import <LYSDatePicker.h>


@interface RemindViewController ()<LYSDatePickerDataSource>
{
    NSDate *_currentSelectDate;
}
@property(nonatomic, strong)LYSDatePicker *pickerView;
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UIButton *saveButton;

@end

@implementation RemindViewController
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(self.label.frame)+15, MZWIDTH-64, 50)];
        if (self.content.length >0) {
            _textField.placeholder = self.content;
        }else{
            _textField.placeholder = LocalizedString(@"remindPlaceholder");
        }
        _textField.textColor = AppColor;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.background = [UIImage imageNamed:@"input_line"];
    }
    return _textField;
}

- (LYSDatePicker *)pickerView{
    if (!_pickerView) {
        _pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(15, 50, CGRectGetWidth(self.view.frame)-30, 256) type:LYSDatePickerTypeCustom];
        _pickerView.datePickerMode = LYSDatePickerModeYearAndDateAndTime;
        _pickerView.date = [NSDate date];
        _pickerView.layer.cornerRadius = 10;
        _pickerView.clipsToBounds = YES;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(self.pickerView.frame)+20, 10, 30)];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = TextColor;
        _label.text = LocalizedString(@"remindTips");
        [_label sizeToFit];
    }
    return _label;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField.frame)+25, MZWIDTH-60, 44)];
        _saveButton.layer.cornerRadius = 10;
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_saveButton setTitleColor:AppColor forState:UIControlStateNormal];
        _saveButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        [_saveButton setTitle:LocalizedString(@"saveOver") forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveRemindAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加提醒";
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.saveButton];
}
- (void)saveRemindAction{
    NSString *dateStr0 = [Utils strFromDate:_currentSelectDate];
    NSString *dateStr1 = [Utils strFromDate:[NSDate date]];
    if ([dateStr0 compare:dateStr1] == NSOrderedSame || [dateStr0 compare:dateStr1] == NSOrderedAscending ) {
        [[ZAlertViewManager shareManager] showContent:LocalizedString(@"dateErrorTips") type:AlertViewTypeError];
        return;
    }
    if (self.eventClourse) {
        self.textField.text = self.textField.text.length > 0? self.textField.text:self.textField.placeholder;
        self.eventClourse(self.textField.text, _currentSelectDate);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)datePicker:(LYSDatePicker *)pickerView didSelectDate:(NSDate *)date{
    _currentSelectDate = date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
