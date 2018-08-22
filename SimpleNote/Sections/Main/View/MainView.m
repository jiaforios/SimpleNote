//
//  MainView.m
//  SimpleNote
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 com. All rights reserved.
//

#import "MainView.h"
#import "TextCell.h"
#import "ImgCell.h"
#import "SoundCell.h"

static NSString *textCellIdentifier = @"textCell";
static NSString *imgCellIdentifier = @"imgCell";
static NSString *soundCellIdentifier = @"soundCell";

@interface MainView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *noteButton;
// 段头展示数据
@property(nonatomic, strong)NSMutableArray *sectionArr;
// 段内展示数据
@property(nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation MainView
#pragma mark -- property or view  set   --
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
        [self addSubview:self.noteButton];
    }
    return self;
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, MZHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"TextCell" bundle:nil] forCellReuseIdentifier:textCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"ImgCell" bundle:nil] forCellReuseIdentifier:imgCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"SoundCell" bundle:nil] forCellReuseIdentifier:soundCellIdentifier];
        
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, 1)];
        head.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = head;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

-(UIButton *)noteButton{
    if (!_noteButton) {
        _noteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _noteButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        _noteButton.center = CGPointMake(self.center.x, CGRectGetHeight(self.frame) - CGRectGetWidth(_noteButton.frame)/2.0 - 30);
        _noteButton.layer.cornerRadius = CGRectGetWidth(_noteButton.frame)/2.0;
        _noteButton.clipsToBounds = YES;
        [_noteButton setImage:[UIImage imageNamed:@"note"] forState:UIControlStateNormal];
        [_noteButton addTarget:self action:@selector(noteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteButton;
}

- (void)setUpData{
    if ([self.dataSource respondsToSelector:@selector(mainViewSectionData)] && [self.dataSource conformsToProtocol:@protocol(MainViewDataSource)]) {
        self.sectionArr = [[self.dataSource mainViewSectionData] copy];
    }else{
        NSLog(@"%@ 未处理 mainViewSectionData ",self.dataSource);
    }
    
    if ([self.dataSource respondsToSelector:@selector(mainViewCellData)] && [self.dataSource conformsToProtocol:@protocol(MainViewDataSource)]) {
        self.dataArr = [[self.dataSource mainViewCellData] copy];
    }else{
        NSLog(@"%@ 未处理 mainViewData ",self.dataSource);
    }
}

- (NSMutableArray *)sectionArr{
    if (!_sectionArr) {
        _sectionArr = [NSMutableArray new];
    }
    return _sectionArr;
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}


/*
 编辑新增
 */
- (void)noteAction{
    
    if ([self.delegate respondsToSelector:@selector(mainViewEdit)] && [self.delegate conformsToProtocol:@protocol(MainViewDelegate)]) {
        [self.delegate mainViewEdit];
    }
}


#pragma mark --  UITableViewDelegate UITableViewDataSource--

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return  arr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sect = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, 50)];
    sect.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, 50)];
    [sect addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.sectionArr[section];
    label.font = [UIFont systemFontOfSize:16];
    return sect;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TextCell *textCell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier forIndexPath:indexPath];
    
    NSArray *arr = self.dataArr[indexPath.section];
    textCell.contentLabel.numberOfLines = 0;
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:arr[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSKernAttributeName:@3,NSParagraphStyleAttributeName:[self paraStyle]}];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    textCell.contentLabel.attributedText = strM;
    
    return  textCell;
    
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

@end
