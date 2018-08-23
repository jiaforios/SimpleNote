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

#import "TextCell.h"
#import "ImgCell.h"
#import "SoundCell.h"

#import "MainView.h"

static NSString *textCellIdentifier = @"textCell";
static NSString *imgCellIdentifier = @"imgCell";
static NSString *soundCellIdentifier = @"soundCell";

@interface MainViewController ()<MainViewDelegate,MainViewDataSource>
@property(nonatomic, strong)UIButton *setButton;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithCustomView:self.setButton];
    self.navigationItem.rightBarButtonItem = set;
    
    MainView *mv = [[MainView alloc] initWithFrame:self.view.bounds];
    mv.delegate = self;
    mv.dataSource = self;
    [mv setUpData];    
    self.view = mv;

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


-(id)mainViewCellData{
    NSArray *arr = [NoteModel mj_keyValuesArrayWithObjectArray:[NoteModel fetchAllModel]];
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
