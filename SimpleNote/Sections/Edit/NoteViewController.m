//
//  NoteViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteModel.h"
#import "EncryptViewController.h"
#import "RemindViewController.h"
#import "PhotosViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";
#define kRowHeight 60

@interface NoteViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
     NSString *lockType;
     NSString *lockPwd;
     NSString *lockTips;

}
@property(nonatomic, strong)UITextView *noteTextView;
@property(nonatomic, strong)UIButton *saveButton;
@property(nonatomic, strong)UIButton *lockButton;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong)NoteModel *noteModel;

@end

@implementation NoteViewController

- (NoteModel *)noteModel{
    if (!_noteModel) {
        _noteModel = [NoteModel new];
    }
    return _noteModel;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
        [_dataSource addObject:LocalizedString(@"encryptSet")];
        [_dataSource addObject:LocalizedString(@"remindSet")];
//        [_dataSource addObject:LocalizedString(@"imgSet")];
    }
    return _dataSource;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.noteTextView.frame), CGRectGetMaxY(self.noteTextView.frame)+30, CGRectGetWidth(self.noteTextView.frame), kRowHeight*self.dataSource.count) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        _saveButton.frame = CGRectMake(0, 0, 44,44);
        [_saveButton setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
        [_saveButton setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (UIButton *)lockButton{
    if (!_lockButton) {
        _lockButton = [[UIButton alloc] init];
        _lockButton.frame = CGRectMake((MZWIDTH-100)/2.0, CGRectGetMaxY(self.noteTextView.frame)+30, 100,44);
        [_lockButton setTitle:@"lock" forState:UIControlStateNormal];
        [_lockButton setTitle:@"locked" forState:UIControlStateSelected];
        
        [_lockButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_lockButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _lockButton.backgroundColor = [UIColor whiteColor];
        [_lockButton addTarget:self action:@selector(lockAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lockButton;
}

- (UITextView *)noteTextView{
    if (!_noteTextView) {
        _noteTextView = [[UITextView alloc] initWithFrame: CGRectMake(15, 15, MZWIDTH-30, MZHEIGHT*0.3)];
        _noteTextView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _noteTextView.font = [UIFont systemFontOfSize:14];
        _noteTextView.layer.cornerRadius = 6;
        _noteTextView.clipsToBounds = YES;
        _noteTextView.delegate = self;
        _noteTextView.textColor = TextColor;
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"在这里输入内容";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor =RGB(210, 210, 210);
        [placeHolderLabel sizeToFit];
        [_noteTextView addSubview:placeHolderLabel];
        _noteTextView.font = [UIFont systemFontOfSize:14.f];
        placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
        [_noteTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
  return _noteTextView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增";

    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    self.navigationItem.rightBarButtonItem = set;
    [self.view addSubview:self.noteTextView];
    
    NoteModel *model = (NoteModel *)self.noteDataModel;
    self.noteTextView.text = model.content;
    self.noteModel = model;
    
    [self.view addSubview:self.tableView];
}



- (void)lockAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)saveAction{
    [self.view resignFirstResponder];
    
    
    if (_noteTextView.text.length == 0) {
        [self showTips:LocalizedString(@"contentNull") type:AlertViewTypeError];
        return;
    }
    self.noteModel.content = _noteTextView.text;
    
    if (self.noteDataModel != nil) {
        // 更新note
        [self.noteModel update];
    }else{
        // 插入note
        [self.noteModel save];
    }
    if (self.noteModel.isRemind) { // 触发之后应该设置过期，或者remind 设置no，删除note 同时要删除 通知
        [Utils localNotification:self.noteModel.remindTips notiDate:self.noteModel.remindDateStr];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- delegate --

-(void)textViewDidChange:(UITextView *)textView{
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:textView.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSKernAttributeName:@3,NSParagraphStyleAttributeName:[Utils paraStyle]}];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    textView.attributedText  = strM;
    
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
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = TextColor;
    cell.detailTextLabel.textColor = DetailTextColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        if ([self.noteModel.lockType isEqualToString: FingureEntryptType]) {
            cell.detailTextLabel.text = LocalizedString(@"fingureEncrypt");
        }
        if ([self.noteModel.lockType isEqualToString: PwdEntryptType]) {
            cell.detailTextLabel.text = LocalizedString(@"pwdEncrypt");
        }
    }else if (indexPath.row == 1){
       
        cell.detailTextLabel.text =  self.noteModel.remindDateStr;
    }
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row == 0){
        EncryptViewController *entry = [EncryptViewController new];
        entry.locktype = lockType;
        entry.pwd = lockPwd;
        entry.lockTips = lockTips;

        entry.eventClourse = ^(NSString* pwd,NSString *entryptTypeStr,NSString *noteTips){
            if (entryptTypeStr != EntryptTypeNone) {
                self.noteModel.lockType = entryptTypeStr;
                lockType = entryptTypeStr;
                lockPwd = pwd;
                lockTips = noteTips;
                
                self.noteModel.lock = YES;
                self.noteModel.lockTitle = noteTips;
                if ([entryptTypeStr isEqualToString: FingureEntryptType]) {
                    cell.detailTextLabel.text = LocalizedString(@"fingureEncrypt");
                }
                if ([entryptTypeStr isEqualToString: PwdEntryptType]) {
                    cell.detailTextLabel.text = LocalizedString(@"pwdEncrypt");
                    self.noteModel.lockPwd = pwd;
                }
                
            }else{
                self.noteModel.lock = NO;
            }
        };
        [self.navigationController showViewController:entry sender:nil];
    }
    
    if (indexPath.row == 1) {
        RemindViewController *remind = [RemindViewController new];
        remind.content = self.noteTextView.text;
        remind.eventClourse = ^(NSString *tipContent, NSDate *remindDate) {
          
            self.noteModel.remind = YES;
            self.noteModel.remindDateStr = [Utils strFromDate:remindDate];
            self.noteModel.remindTips = tipContent;
            cell.detailTextLabel.text = self.noteModel.remindDateStr;
        };
        
        [self.navigationController showViewController:remind sender:nil];
    }
    
    if (indexPath.row == 2) {
        [self.navigationController showViewController:[PhotosViewController new] sender:nil];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
