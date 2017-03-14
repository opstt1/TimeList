//
//  TaskImportaceView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/14.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "TaskImportaceView.h"
#import "Constants.h"

@interface TaskImportaceView()

@property (nonatomic, readwrite, copy) NSArray *starArray;
@end

@implementation TaskImportaceView

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame content:(NSString *)content actionHandler:(TaskTitleViewHandler)handler
{
    TaskImportaceView *view = [[TaskImportaceView alloc] initWithFrame:frame];
    view.handler = handler;
    return view;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( !self ){
        return nil;
    }
    [self p_initView];
    return self;
}


- (void)p_initView
{
    CGFloat pointX = 15.0f;
    NSMutableArray *starsList = [NSMutableArray array];
    for ( int  i = 0; i < 5; ++i ){
        UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(pointX, 8, 14, 14)];
        starView.layer.contents = (id)[UIImage imageNamed:@"star-gray-big"].CGImage;
        starView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:starView];
        [starsList addObject:starView];
        pointX += 18 + 0.5;
    }
    
    _starArray = [NSArray arrayWithArray:starsList];
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.frame];
    button.y = 0.0f;
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

}

- (void)didTapButton:(id)sender
{
    if ( self.handler ){
        self.handler(nil);
    }
}

- (void)setupImportance:(NSString *)importance
{
    NSInteger impportanceInt = [importance integerValue];
    NSInteger fullStarCount = impportanceInt / 2;
    NSInteger hasHalfStar = impportanceInt % 2;
    
    [_starArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *starView = (UIView *)obj;
        if ( idx + 1 <= fullStarCount ){
            starView.layer.contents = (id)[UIImage imageNamed:@"star-yellow-big"].CGImage;
            return;
        }
        if ( idx  == fullStarCount && hasHalfStar ){
            starView.layer.contents = (id)[UIImage imageNamed:@"star-half-yellow"].CGImage;
            return;
        }
        starView.layer.contents = (id)[UIImage imageNamed:@"star-gray-big"].CGImage;
    }];

}
@end
