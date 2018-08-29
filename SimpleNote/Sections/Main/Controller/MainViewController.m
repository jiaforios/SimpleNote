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
#import "NoteModel.h"
#import "MHD_FingerPrintVerify.h"
#import "NoteManager.h"
#import "SoundEditViewController.h"

#import "TextCell.h"
#import "ImgCell.h"
#import "SoundCell.h"

#import "MainView.h"
#import <LEEAlert.h>
#import <objc/runtime.h>

static NSString *textCellIdentifier = @"textCell";
static NSString *imgCellIdentifier = @"imgCell";
static NSString *soundCellIdentifier = @"soundCell";

@interface MainViewController ()<MainViewDelegate,MainViewDataSource>
@property(nonatomic, strong)UIButton *setButton;
@property(nonatomic, strong)MainView *mainView;
@property(nonatomic, strong)UIButton *clearButton;

@end

@implementation MainViewController


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mainView setUpDataReload:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithCustomView:self.setButton];
    self.navigationItem.rightBarButtonItem = set;
    
//    UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithCustomView:self.clearButton];
//    self.navigationItem.leftBarButtonItem = clear;
    
    
//    迷你简硬笔楷书 ：Jyinbikai,少女： DFGirl-W6-WIN-BF，FZKaTong-M19S：FZKATJW--GB1-0，Li Xuke Comic Font：Li-Xuke-Comic-Font
    
    MainView *mv = [[MainView alloc] initWithFrame:self.view.bounds];
    mv.delegate = self;
    mv.dataSource = self;
    self.view = mv;
    self.mainView  = mv;
    [self appLockViewShow];
}
- (UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc] init];
        _clearButton.frame = CGRectMake(0, 0, 44,44);
        [_clearButton setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
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

/*
 设置
 */

- (void)setAction{
    
    SetViewController *set = [SetViewController new];
    set.clearClourse = ^{
        [self.mainView setUpDataReload:YES];
    };
    [self.navigationController pushViewController:set animated:YES];
}

- (void)appLockViewShow{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:APPLOCKKEY];
    if (dic != nil) {
        // 弹出解密
        UIView *lockView = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 118, 83)];
        [btn setImage:[UIImage imageNamed:@"lock_app"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"lock_app"] forState:UIControlStateHighlighted];

        [btn addTarget:self action:@selector(unlockSender:) forControlEvents:UIControlEventTouchUpInside];
        btn.center = lockView.center;
        [lockView addSubview:btn];
        lockView.backgroundColor = [UIColor whiteColor];
        [self.navigationController.view addSubview:lockView];
        [self.navigationController.view bringSubviewToFront:lockView];
        
        objc_setAssociatedObject(btn, "dic", dic, OBJC_ASSOCIATION_COPY);
        void(^resBlock)(void) = ^{
            [UIView animateWithDuration:0.25 animations:^{
                lockView.alpha = 0 ;
            } completion:^(BOOL finished) {
                [lockView removeFromSuperview];
            }];
        };
        objc_setAssociatedObject(btn, "block", resBlock, OBJC_ASSOCIATION_COPY);

        [self unlockSender:btn];
    }
}

- (void)unlockSender:(UIButton *)sender{
    
    id dic = objc_getAssociatedObject(sender, "dic");
    NSString *type = dic[@"lockType"];
    void(^resBlock)(void) = objc_getAssociatedObject(sender, "block");
    if ([type isEqualToString: FingureEntryptType]) {
        [MHD_FingerPrintVerify mhd_fingerPrintLocalAuthenticationFallBackTitle:LocalizedString(@"sure") localizedReason:@"解密指纹验证" callBack:^(BOOL isSuccess, NSError * _Nullable error, NSString *referenceMsg) {
            if (isSuccess) {
                resBlock?resBlock():nil;
            }
        }];
    }

    if ([type isEqualToString: PwdEntryptType]) {
        [self showTextAlertTitle:LocalizedString(@"inputPwd") message:nil sureBlock:^(NSString *content) {
            if ([content isEqualToString:dic[@"pwd"]]) {
                resBlock?resBlock():nil;
                return YES;
            }else{
                // 验证失败
                [[ZAlertViewManager shareManager] showContent:LocalizedString(@"pwdError") type:AlertViewTypeSuccess];
                return NO;
            }
        }];
    }
}

- (void)clearAction{

}

#pragma mark -- ViewProtocol --

- (void)mainViewEdit{
    [self.navigationController pushViewController:[NoteViewController new] animated:YES];
}

- (void)mainViewSoundEdit{
    [self.navigationController pushViewController:[SoundEditViewController new] animated:YES];
}

- (void)mainViewCellSelect:(NSIndexPath *)indexPath dataSource:(NSDictionary *)cellData{
    if ([cellData[@"lock"] boolValue] && ![[NoteManager unLockedNoteIds] containsObject:cellData[@"noteId"]]) {
        
        if ([cellData[@"lockType"] isEqualToString: FingureEntryptType]) {
            [MHD_FingerPrintVerify mhd_fingerPrintLocalAuthenticationFallBackTitle:LocalizedString(@"sure") localizedReason:@"解密指纹验证" callBack:^(BOOL isSuccess, NSError * _Nullable error, NSString *referenceMsg) {
                if (isSuccess) {
                    [NoteManager markUnLockedOnceNoteId:cellData[@"noteId"]];
                    [self.mainView setUpDataReload:NO]; // 如果仅解锁一次，屏蔽改代码：notemodel -> fetchAllmodel
                    [self.mainView changeLockedCellState:indexPath];
                }
            }];
        }
        
        if ([cellData[@"lockType"] isEqualToString: PwdEntryptType]) {
            [self showTextAlertTitle:LocalizedString(@"inputPwd") message:nil sureBlock:^(NSString *content) {
                if ([content isEqualToString:cellData[@"lockPwd"]]) {
                    [NoteManager markUnLockedOnceNoteId:cellData[@"noteId"]];
                    [self.mainView setUpDataReload:NO]; // 如果仅解锁一次，屏蔽改代码：Notemodel -> fetchAllmodel
                    [self.mainView changeLockedCellState:indexPath];
                    return YES;
                }else{
                    // 验证失败
                    [[ZAlertViewManager shareManager] showContent:LocalizedString(@"pwdError") type:AlertViewTypeSuccess];
                    return NO;
                }
            }];
        }
    }
}

-(id)mainViewCellData{
    NSArray <NoteModel *>*arr = [NoteModel fetchAllModel];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NoteModel* obj1, NoteModel* obj2) {
        return obj1.noteId < obj2.noteId;
    }];
    return [NoteModel mj_keyValuesArrayWithObjectArray:arr];
}

- (void)mainViewCellDelete:(NSIndexPath *)indexPath dataSource:(NSDictionary *)cellData{
    
    NoteModel *model = [NoteModel mj_objectWithKeyValues:cellData];
    [model deleteWithId];
    [Utils cancelLocalNotificationWithDate:model.remindDateStr]; //清除提醒
}

-(void)mainViewCellEdit:(NSIndexPath *)indexPath dataSource:(NSDictionary *)cellData{
//    NoteModel *model = [NoteModel mj_objectWithKeyValues:cellData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
