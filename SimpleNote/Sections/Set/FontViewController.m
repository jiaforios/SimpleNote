//
//  FontViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 com. All rights reserved.
//

#import "FontViewController.h"
#import "UIFont+FontType.h"
static NSString *cellIdentifier = @"cellIdentifier";
#define kRowHeight 60

@interface FontViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FontViewController
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
        [_dataSource addObject:@"font1"];
        [_dataSource addObject:@"font3"];
        [_dataSource addObject:@"font4"];
        [_dataSource addObject:@"font5"];

    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15,30, MZWIDTH-30, kRowHeight*self.dataSource.count) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"字体设置";
    [self.view addSubview:self.tableView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = TextColor;
    cell.detailTextLabel.textColor = DetailTextColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *type = nil;
    
    if (indexPath.row == 0) {
        type = @"Jyinbikai";
    }
    if (indexPath.row == 1) {
        type = @"FZKATJW--GB1-0";
    }
    if (indexPath.row == 2) {
        type = @"Li-Xuke-Comic-Font";
    }
    if (indexPath.row == 3) {
        type = @"STHeitiK-Light";
    }
    
    cell.textLabel.font = [UIFont fontWithName:type size:15];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *type = nil;
    
    if (indexPath.row == 0) {
        type = @"Jyinbikai";
    }
    if (indexPath.row == 1) {
        type = @"FZKATJW--GB1-0";
    }
    if (indexPath.row == 2) {
        type = @"Li-Xuke-Comic-Font";
    }
    if (indexPath.row == 3) {
        type = @"STHeitiK-Light";
    }
    
    [Utils userDefaultSet:type key:@"fontType"];
    
    [self showTips:LocalizedString(@"fontSuc") type:AlertViewTypeSuccess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
