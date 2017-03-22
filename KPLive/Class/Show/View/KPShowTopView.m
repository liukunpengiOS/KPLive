//
//  KPShowTopView.m
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPShowTopView.h"

@interface KPShowTopView ()

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSMutableArray *buttons;;
@end

@implementation KPShowTopView

- (instancetype)initWithFrame:(CGRect)frame tilteNames:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
        [self configButton:titles];
    }
    return self;
}

- (void)setup {

    [self buttons];
}

- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)configButton:(NSArray *)titles{
    
    CGFloat width = self.width / titles.count;
    CGFloat height = self.height;
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = titles[i];
        button.tag = i;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.frame = CGRectMake(i * width, 0, width, height);
        [button addTarget:self
                   action:@selector(buttonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [_buttons addObject:button];
        
        if (i == 1) { //放到中间位置
           [self configLinView:button index:i];
        }
    }
}

- (void)configLinView:(UIButton *)button index:(NSInteger)index {

    [button.titleLabel sizeToFit];//预设titleLabel的宽高值
    if (!_lineView) {
        _lineView = ({
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor whiteColor];
            lineView.height = 2;
            lineView.top = 40;
            lineView.width = button.titleLabel.width;
            lineView.centerX = button.centerX;
            [self addSubview:lineView];
            lineView;
        });
    }
}

- (void)scrolling:(NSInteger)tag {
    
    UIButton *button = _buttons[tag];
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.centerX = button.centerX;
    }];
}

- (void)buttonEvent:(UIButton *)button {

    !self.showTopBlock?:self.showTopBlock(button.tag);
    [self scrolling:button.tag];
}

@end
