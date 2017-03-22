//
//  KPFocusController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPFocusController.h"
#import "KPHotLiveCell.h"
#import "KPHotLiveModel.h"
#import "KPShowPlayerController.h"

@interface KPFocusController ()

@property (nonatomic,strong) NSArray *dataList;
@end

static NSString * const kIndentifier = @"focus";

@implementation KPFocusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configDataList];
    [self.tableView registerClass:[KPHotLiveCell class] forCellReuseIdentifier:kIndentifier];
}

- (void)configDataList {
    
    KPHotLiveModel *liveModel = [[KPHotLiveModel alloc] init];
    liveModel.city = @"郑州市";
    liveModel.streamAddr = Live_Kunpeng;
    KPCreator *creator = [[KPCreator alloc] init];
    liveModel.creator = creator;
    creator.nick = @"刘坤鹏";
    creator.portrait = @"kunpeng.JPG";
    _dataList = @[liveModel];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KPHotLiveCell *focusCell = [tableView dequeueReusableCellWithIdentifier:kIndentifier forIndexPath:indexPath];
    focusCell.hotLiveModel = _dataList[indexPath.row];
    return focusCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return  70 + SCREEN_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KPHotLiveModel *hotLiveModel = _dataList[indexPath.row];
    KPShowPlayerController *player = [[KPShowPlayerController alloc] init];
    player.hotLiveModel = hotLiveModel;
    [self.navigationController showViewController:player sender:nil];
}

@end
