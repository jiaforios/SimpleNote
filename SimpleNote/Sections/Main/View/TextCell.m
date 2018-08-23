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
    [self.editButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5,10, 5)];
    self.coverView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lock_bg_2"]];
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
    self.timeLabel.text= dic[@"dateStr"];
    
    if ([dic[@"lock"] boolValue] && ![[NoteManager unLockedNoteIds] containsObject:dic[@"noteId"]]) {
        self.coverView.hidden = NO;
    }else{
        self.coverView.hidden = YES;
    }
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:dic[@"content"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSKernAttributeName:@3,NSParagraphStyleAttributeName:[self paraStyle]}];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    self.contentLabel.attributedText = strM;
}


- (NSMutableParagraphStyle *)paraStyle{
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 8.;// 行间距
    paragraphStyle.lineHeightMultiple = 1.3;// 行高倍数（1.5倍行高）
    paragraphStyle.firstLineHeadIndent = 30.0f;//首行缩进
    paragraphStyle.minimumLineHeight = 10;//最低行高
    paragraphStyle.alignment = NSTextAlignmentLeft;// 对齐方式
    paragraphStyle.defaultTabInterval = 144;// 默认Tab 宽度
    paragraphStyle.headIndent = 10;// 起始 x位置
    return paragraphStyle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
