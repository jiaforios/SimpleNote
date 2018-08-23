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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, MZHEIGHT-kNavBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerNib:[UINib nibWithNibName:@"TextCell" bundle:nil] forCellReuseIdentifier:textCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"ImgCell" bundle:nil] forCellReuseIdentifier:imgCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"SoundCell" bundle:nil] forCellReuseIdentifier:soundCellIdentifier];
        
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, 1)];
//        head.backgroundColor = [UIColor whiteColor];
//        _tableView.tableHeaderView = head;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

-(UIButton *)noteButton{
    if (!_noteButton) {
        _noteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _noteButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        _noteButton.center = CGPointMake(self.center.x, CGRectGetHeight(self.frame) - CGRectGetWidth(_noteButton.frame)/2.0 - 30-kNavBarHeight);
        _noteButton.layer.cornerRadius = CGRectGetWidth(_noteButton.frame)/2.0;
        _noteButton.clipsToBounds = YES;
        [_noteButton setImage:[UIImage imageNamed:@"note"] forState:UIControlStateNormal];
        [_noteButton addTarget:self action:@selector(noteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteButton;
}

- (void)setUpData{
   
    if ([self.dataSource respondsToSelector:@selector(mainViewCellData)] && [self.dataSource conformsToProtocol:@protocol(MainViewDataSource)]) {
        self.dataArr = [[self.dataSource mainViewCellData] copy];
        [self.tableView reloadData];
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


- (void)changeLockedCellState:(NSIndexPath *)indexPath{
    TextCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.coverView.hidden == NO) {
        cell.coverView.alpha = 1;
        [UIView animateWithDuration:1 animations:^{
            cell.coverView.alpha = 0;
            cell.coverView.frame = CGRectMake(cell.coverView.frame.size.width+10, cell.coverView.frame.origin.y,  cell.coverView.frame.size.width,  cell.coverView.frame.size.height);
        } completion:^(BOOL finished) {
            cell.coverView.hidden = YES;
        }];
    }
}

#pragma mark --  UITableViewDelegate UITableViewDataSource--


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(mainViewCellSelect:dataSource:)] && [self.delegate conformsToProtocol:@protocol(MainViewDelegate)]) {
        [self.delegate mainViewCellSelect:indexPath dataSource:self.dataArr[indexPath.row]];
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *sect = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, 50)];
//    sect.backgroundColor = [UIColor clearColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, 50)];
//    [sect addSubview:label];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = self.dataArr[section];
//    label.font = [UIFont systemFontOfSize:16];
//    return sect;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TextCell *textCell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    [textCell showWithData:dic];
    
    return  textCell;
    
}



@end
