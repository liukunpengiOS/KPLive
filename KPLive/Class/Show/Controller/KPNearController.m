//
//  KPNearController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/20.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPNearController.h"
#import "KPShowHandler.h"
#import "KPNearCollectionCell.h"
#import "KPShowPlayerController.h"

#define kMargin 5
#define kItemWidth 100
static NSString * const kNearCell = @"NearCell";
@interface KPNearController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *nearCollectionView;
@property (nonatomic,strong) NSArray *nearLiveDataList;
@end

@implementation KPNearController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self configElements];
    [self requestNearLiveData];
}

- (void)setup {

    [_nearCollectionView registerNib:[UINib nibWithNibName:@"KPNearCollectionCell" bundle:nil]
          forCellWithReuseIdentifier:kNearCell];
}

- (void)configElements {
    
}

- (void)requestNearLiveData {

    [KPShowHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        
        _nearLiveDataList = obj;
        [_nearCollectionView reloadData];
    } failure:^(id obj) {
        
        NSLog(@"%@", obj);
    }];
}

#pragma mark - UICollectionViewFlowlayout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
                  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = _nearCollectionView.width / kItemWidth;
    CGFloat extraWidth = (_nearCollectionView.width - kMargin * (count + 1)) / count;
    return CGSizeMake(extraWidth, extraWidth + 20);
}

#pragma mark - UIColletionView Delegate
//Cell将要调用
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KPNearCollectionCell *nearCell = (KPNearCollectionCell *)cell;
    [nearCell showAnimation];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView
             numberOfItemsInSection:(NSInteger)section {
    
    return  _nearLiveDataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KPNearCollectionCell *nearCell = [collectionView dequeueReusableCellWithReuseIdentifier:kNearCell
                                                                               forIndexPath:indexPath];
    nearCell.hotLiveModel = _nearLiveDataList[indexPath.row];
    return nearCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    KPHotLiveModel *hotLiveModel = _nearLiveDataList[indexPath.row];
    KPShowPlayerController *player = [[KPShowPlayerController alloc] init];
    player.hotLiveModel = hotLiveModel;
    [self.navigationController showViewController:player sender:nil];
}

@end
