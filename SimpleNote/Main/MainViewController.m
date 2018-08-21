//
//  MainViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
// 列表式 界面 ，悬空 按钮

#import "MainViewController.h"
#import "NoteViewController.h"
#import "SetViewController.h"

#import "TextCell.h"
#import "ImgCell.h"
#import "SoundCell.h"

static NSString *textCellIdentifier = @"textCell";
static NSString *imgCellIdentifier = @"imgCell";
static NSString *soundCellIdentifier = @"soundCell";

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *noteButton;
@property(nonatomic, strong)UIButton *setButton;
// 段头展示数据
@property(nonatomic, strong)NSMutableArray *sectionSource;
// 段内展示数据
@property(nonatomic, strong)NSMutableArray *dataSource;


@end

@implementation MainViewController

#pragma mark -- property or view  set   --

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
        _noteButton.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - CGRectGetWidth(_noteButton.frame)/2.0 - 30);
        _noteButton.layer.cornerRadius = CGRectGetWidth(_noteButton.frame)/2.0;
        _noteButton.clipsToBounds = YES;
        [_noteButton setImage:[UIImage imageNamed:@"note"] forState:UIControlStateNormal];
        [_noteButton addTarget:self action:@selector(noteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteButton;
}

- (UIButton *)setButton{
    if (!_setButton) {
        _setButton = [[UIButton alloc] init];
        _setButton.frame = CGRectMake(0, 0, 44,44);
        [_setButton setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
        [_setButton addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setButton;
}

- (NSMutableArray *)sectionSource{
    if (!_sectionSource) {
        _sectionSource = [NSMutableArray new];
        [_sectionSource addObject:@"2018-08"];
        [_sectionSource addObject:@"2018-07"];
        [_sectionSource addObject:@"2018-06"];
        [_sectionSource addObject:@"2018-05"];
        [_sectionSource addObject:@"2018-04"];
        [_sectionSource addObject:@"2018-03"];
    }
    return _sectionSource;
}

- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
        for (int i = 0; i<self.sectionSource.count; i++) {
            NSMutableArray *marr = [NSMutableArray new];
            for (int i = 0; i< 5; i++) {
                if (i == 0) {
                    [marr addObject:@"明天上午九点去深南花园约同学吃饭，带上手机钥匙，钱包。"];
                }else
                if (i == 2) {
                    [marr addObject:@"今天是个好日子，明天上午九点去深南花园约同学吃饭，带上手机钥匙，钱包。明天上午九点去深南花园约同学吃饭，带上手机钥匙，钱包。"];
                }else
                if (i == 3) {
                    [marr addObject:@"马上要房价了，今天是个好日子"];
                }else{
                    [marr addObject:@"马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子,马上要房价了，今天是个好日子"];
                }
            }
            [_dataSource addObject:marr];
        }
    }
    
    return _dataSource;
}

#pragma mark -- 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithCustomView:self.setButton];
    self.navigationItem.rightBarButtonItem = set;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noteButton];
    [self.view addSubview:self.setButton];

}

/*
 设置
 */
- (void)setAction{
    
    [self.navigationController pushViewController:[SetViewController new] animated:YES];
}


/*
 编辑新增
 */
- (void)noteAction{
    
    [self.navigationController pushViewController:[NoteViewController new] animated:YES];
}


#pragma mark --  UITableViewDelegate UITableViewDataSource--

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataSource[section];
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
    label.text = self.sectionSource[section];
    label.font = [UIFont systemFontOfSize:16];
    return sect;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TextCell *textCell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier forIndexPath:indexPath];

    NSArray *arr = self.dataSource[indexPath.section];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
