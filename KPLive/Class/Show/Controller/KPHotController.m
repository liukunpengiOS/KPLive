//
//  KPHotController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/17.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPHotController.h"
#import "KPShowHandler.h"
#import "KPHotLiveCell.h"
#import "KPShowPlayerController.h"

static  NSString *const kHotLiveCell = @"HotLiveCell";
@interface KPHotController ()

@property (nonatomic,strong) NSMutableArray *hotLiveDataList;
@end

@implementation KPHotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self loadHotliveData];
}

- (void)setup {
    
    _hotLiveDataList = [NSMutableArray array];
    [self.tableView registerClass:[KPHotLiveCell class] forCellReuseIdentifier:kHotLiveCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _hotLiveDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KPHotLiveCell *hotLiveCell = [tableView dequeueReusableCellWithIdentifier:kHotLiveCell forIndexPath:indexPath];
    hotLiveCell.hotLiveModel = _hotLiveDataList[indexPath.row];
    return hotLiveCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + SCREEN_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KPHotLiveModel *hotLiveModel = _hotLiveDataList[indexPath.row];
    KPShowPlayerController *player = [[KPShowPlayerController alloc] init];
    player.hotLiveModel = hotLiveModel;
    [self.navigationController showViewController:player sender:nil];
}

- (void)loadHotliveData {
    
    [KPShowHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        
        [_hotLiveDataList addObjectsFromArray:obj];
        [self.tableView reloadData];
    } failure:^(id obj) {
        
        NSLog(@"%@",obj);
    }];
}

@end
