//
//  KPShowController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/15.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPShowController.h"
#import "KPShowTopView.h"

@interface KPShowController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) KPShowTopView *showTopView;
@end

@implementation KPShowController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
    [self configElements];
    //进入主控制器手动加载第一个页面
    [self scrollViewDidEndScrollingAnimation:_scrollView];
}

- (void)setup {
    
    [self dataList];
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = @[@"关注", @"热门", @"附近"];
    }
    return _dataList;
}

#pragma mark - Config Elements
- (void)configElements {
 
    [self configNavigationBar];
    [self configScrollView];
    [self configChildControllers];
}

- (KPShowTopView *)showTopView {
    
    if (!_showTopView) {
        _showTopView = ({
            
            CGRect topViewRect = CGRectMake(0, 0, 200, 50);
            KPShowTopView *showTopView = [[KPShowTopView alloc] initWithFrame:topViewRect
                                                                   tilteNames:_dataList];
            @weakify(self)
            showTopView.showTopBlock = ^(NSInteger tag) {
                
                @strongify(self);
                CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.scrollView.contentOffset.y);
                [self.scrollView setContentOffset:point animated:YES];
            };
            showTopView;
        });
    }
    return _showTopView;
}

- (void)configNavigationBar {

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:nil
                                                                 action:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.titleView = [self showTopView];
}

- (UIScrollView *)configScrollView {

    if (!_scrollView) {
        _scrollView = ({
            
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
            scrollView.delegate = self;
            scrollView.pagingEnabled = YES;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _dataList.count, 0);
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
            [self.view addSubview:scrollView];
            scrollView;
        });
    }
    return _scrollView;
}

- (void)configChildControllers {

    NSArray *childControllers = @[@"KPFocusController",@"KPHotController",@"KPNearController"];
    for (NSInteger i = 0; i < childControllers.count; i++) {
        
        NSString *controllerName = childControllers[i];
        UIViewController *childController = [[NSClassFromString(controllerName) alloc] init];
        childController.title = _dataList[i];
        //当执行这句代码的时候，不会加载controller的viewDidLoad方法,不会浪费内存
        [self addChildViewController:childController];
    }
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    NSInteger offsetX = scrollView.contentOffset.x;
    NSInteger pageIndex = offsetX / SCREEN_WIDTH;
    [_showTopView scrolling:pageIndex];//与顶部视图联动
    UIViewController *childController = self.childViewControllers[pageIndex];
    //判断childController是否执行过viewDidLoad方法，若执行直接返回
    if ([childController isViewLoaded]) { return; }
    //若没有设置子控制器view的frame
    childController.view.frame = CGRectMake(offsetX, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //将子控制器添加到scrollView
    [_scrollView addSubview:childController.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
