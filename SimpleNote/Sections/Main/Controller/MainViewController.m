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
    
    MainView *mv = [[MainView alloc] initWithFrame:self.view.bounds];
    mv.delegate = self;
    mv.dataSource = self;
    self.view = mv;
    self.mainView  = mv;

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
    
    [self.navigationController pushViewController:[SetViewController new] animated:YES];
}

#pragma mark -- ViewProtocol --

- (void)mainViewEdit{
    [self.navigationController pushViewController:[NoteViewController new] animated:YES];
}

- (void)mainViewSoundEdit{
    [self.navigationController pushViewController:[SoundEditViewController new] animated:YES];
}

- (void)mainViewCellSelect:(NSIndexPath *)indexPath dataSource:(NSDictionary *)cellData{
    // 判断点击的行 是否加密
    if ([cellData[@"lock"] boolValue] && ![[NoteManager unLockedNoteIds] containsObject:cellData[@"noteId"]]) {
        // 弹出指纹验证
        [MHD_FingerPrintVerify mhd_fingerPrintLocalAuthenticationFallBackTitle:@"确定" localizedReason:@"解密指纹验证" callBack:^(BOOL isSuccess, NSError * _Nullable error, NSString *referenceMsg) {
            if (isSuccess) {
                [NoteManager markUnLockedOnceNoteId:cellData[@"noteId"]];
//                [self.mainView setUpDataReload:NO]; // 如果仅解锁一次，屏蔽改代码：notemodel -> fetchAllmodel
                [self.mainView changeLockedCellState:indexPath];
            }else{
                
            }
        }];
    }
}

-(id)mainViewCellData{
    NSArray <NoteModel *>*arr = [NoteModel fetchAllModel];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NoteModel* obj1, NoteModel* obj2) {
        return obj1.noteId < obj2.noteId;
    }];
    
    return [NoteModel mj_keyValuesArrayWithObjectArray:arr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
