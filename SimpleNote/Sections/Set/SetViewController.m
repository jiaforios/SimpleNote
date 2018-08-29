//
//  SetViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import "SetViewController.h"
#import "DBManager.h"
#import "ColorViewController.h"
#import "FontViewController.h"
#import "APPentryptViewController.h"
#import "OptionsViewController.h"
#import "HelpsViewController.h"
#import "VersionViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *sourceArr;
@end

@implementation SetViewController

- (NSMutableArray *)sourceArr{
    if (!_sourceArr) {
        _sourceArr = [NSMutableArray new];
        NSArray *section0 = @[LocalizedString(@"colorSet"),LocalizedString(@"fontSet"),LocalizedString(@"appEntrypt"),LocalizedString(@"clearAll")];
        NSArray *section1 = @[LocalizedString(@"options"),LocalizedString(@"versionInfo")];
        [_sourceArr addObject:section0];
        [_sourceArr addObject:section1];
    }
    
    return _sourceArr;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MZWIDTH, MZHEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.sourceArr[section];;
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = TextColor;
        cell.detailTextLabel.textColor = DetailTextColor;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *arr = self.sourceArr[indexPath.section];;
    cell.textLabel.text = arr[indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.detailTextLabel.text = [self fetchLockStatus];
    }
    return cell;
}


- (NSString *)fetchLockStatus{
   NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:APPLOCKKEY];
    if (dic != nil) {
        if ([dic[@"lockType"] isEqualToString:FingureEntryptType]) {
            return LocalizedString(@"fingureEncrypt");
        }else if([dic[@"lockType"] isEqualToString:PwdEntryptType]) {
            return LocalizedString(@"pwdEncrypt");
        }
    }
    return @"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController showViewController:[ColorViewController new] sender:nil];
                break;
            case 1:
                NSLog(@"111");
                NSLog(@"111");
                NSLog(@"111");

                [self.navigationController showViewController:[FontViewController new] sender:nil];
                break;
            case 2:{
                APPentryptViewController *app = [APPentryptViewController new];
                app.eventClourse = ^(NSString *pwd, NSString *type) {
                   cell.detailTextLabel.text = [self fetchLockStatus];
                };
                [self.navigationController showViewController:app sender:nil];
            }
                break;
            case 3:
                [self clearAll];
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController showViewController:[OptionsViewController new] sender:nil];

                break;
            case 1:
                [self.navigationController showViewController:[VersionViewController new] sender:nil];
                break;
                break;
            default:
                break;
        }
    }
   
}


- (void)clearAll{
    [self showAlertViewTitle:LocalizedString(@"clearAll") message:LocalizedString(@"deleteTips") sureBlock:^{
        [[DBManager shareManager] clearAllNotes];
        [Utils cancelAllLocalnotifications];
        if (self.clearClourse) {
            self.clearClourse();
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
