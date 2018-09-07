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
        NSArray *section0 = @[LocalizedString(@"colorSet"),LocalizedString(@"appEntrypt"),LocalizedString(@"clearAll")];
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
//    [self listenRunloop];
    
}


- (void)listenRunloop{
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    
    // 给RunLoop添加监听者
    /*
     第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
     第二个参数 CFRunLoopObserverRef observer 监听者
     第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    /*
     CF的内存管理（Core Foundation）
     凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
     */
    CFRelease(observer);

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
    
            case 1:{
                APPentryptViewController *app = [APPentryptViewController new];
                app.eventClourse = ^(NSString *pwd, NSString *type) {
                   cell.detailTextLabel.text = [self fetchLockStatus];
                };
                [self.navigationController showViewController:app sender:nil];
            }
                break;
            case 2:
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
            {
//                NSLog(@"准备执行事件 ---------");
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"1" message:@"2" preferredStyle:UIAlertControllerStyleAlert];
//                [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
//
//                [self presentViewController:alert animated:YES completion:nil];
                
//                CFRunLoopWakeUp(CFRunLoopGetMain());
//                NSLog(@"事件完成 ---------");

            }
                break;
            case 1:
                [self.navigationController showViewController:[VersionViewController new] sender:nil];
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
