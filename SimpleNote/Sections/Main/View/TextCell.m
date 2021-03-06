//
//  TextCell.m
//  SimpleNote
//
//  Created by admin on 2018/8/21.
//  Copyright © 2018年 com. All rights reserved.
//

#import "TextCell.h"
#import "ZJTools.h"
#import "NoteManager.h"

@interface TextCell ()
@property(nonatomic, strong)UIVisualEffectView *visView;
@end

@implementation TextCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.coverView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:APPCOLORIMAGE]]];
    self.createTimeLabel.font = [UIFont systemFontOfSize:12];
    self.remindTimeLabel.font = [UIFont systemFontOfSize:12];
    
}

-(UIVisualEffectView*)visView{
    if (_visView == nil) {
        _visView = [ZJTools effectViewWithFrame:self.coverView.bounds];
        _visView.alpha = 0.7;
    }
    return _visView;
}

- (void)showWithData:(NSDictionary *)dic{
    self.contentLabel.numberOfLines = 0;
    self.createTimeLabel.text= dic[@"dateStr"];
    self.coverView.hidden = ![dic[@"lock"] boolValue];
    self.tipLabel.text = dic[@"lockTitle"];
    if ([dic[@"lockType"] isEqualToString:FingureEntryptType]) {
        self.lockImg.hidden = NO;
        self.lockImg.image = [UIImage imageNamed:@"small_fingure"];
    }else if ([dic[@"lockType"] isEqualToString:PwdEntryptType]) {
        self.lockImg.hidden = NO;
        self.lockImg.image = [UIImage imageNamed:@"small_pwd"];
    }else{
        self.lockImg.hidden = YES;
    }
    if ([dic[@"remind"] boolValue]) {
        self.remindImg.hidden = NO;
        self.remindTimeLabel.text = dic[@"remindDateStr"];
    }else{
        self.remindImg.hidden = YES;
        self.remindTimeLabel.text = @"";
    }
    
    if([Utils compareTodaywithRemindTime:[Utils dateFromStr:dic[@"remindDateStr"]]] == 1) {
        self.contentLabel.textColor = RGB(210, 210, 210);
    }else{
        self.contentLabel.textColor = [UIColor blackColor];

    }

    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:dic[@"content"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSKernAttributeName:@3,NSParagraphStyleAttributeName:[Utils paraStyle]}];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    self.contentLabel.attributedText = strM;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
