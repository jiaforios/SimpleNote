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
    
    MainView *mv = [[MainView alloc] initWithFrame:self.view.bounds];
    mv.delegate = self;
    mv.dataSource = self;
    self.view = mv;
    self.mainView  = mv;
    
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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:LocalizedString(@"inputPwd") message:cellData[@"lockTitle"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:nil];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:LocalizedString(@"cancel") style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:LocalizedString(@"sure") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([alert.textFields[0].text isEqualToString:cellData[@"lockPwd"]]) {
                    [NoteManager markUnLockedOnceNoteId:cellData[@"noteId"]];
                    [self.mainView setUpDataReload:NO]; // 如果仅解锁一次，屏蔽改代码：Notemodel -> fetchAllmodel
                    [self.mainView changeLockedCellState:indexPath];
                }else{
                    // 验证失败
                    [[ZAlertViewManager shareManager] showContent:LocalizedString(@"pwdError") type:AlertViewTypeSuccess];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }];
            
            [alert addAction:cancel];
            [alert addAction:sure];
            [self presentViewController:alert animated:YES completion:nil];
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
