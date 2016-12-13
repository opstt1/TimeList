//
//  TastListTableViewCell.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/13.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TastListTableViewCell.h"
#import "Constants.h"
#import "Toolkit.h"

#define OPSSideslipCellLeftLimitScrollMargin 30
#define OPSSideslipCellRightLimitScrollMargin 60

@interface TastListTableViewCell()

@property (nonatomic, readwrite, strong) UILabel *timeLabel;
@property (nonatomic, readwrite, strong) UILabel *titleLabe1;
@property (nonatomic, readwrite, strong) NSArray *starsList;
@property (nonatomic, readwrite, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, readwrite, strong) UIView *containView;
@property (nonatomic, readwrite, strong) UIButton *cancelButton;
@end

@implementation TastListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    _containView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, UISCREEN_WIDTH-10, 60)];
    _containView.backgroundColor = [UIColor redColor];
    _containView.layer.cornerRadius = 10.0f;
    _cancelButton = [UIButton new];
    [_cancelButton addTarget:self action:@selector(canccelButtonTap:) forControlEvents:UIControlEventTouchUpInside];

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( !self ) return nil;
    
    CGFloat width =  UISCREEN_WIDTH - 5 - 5 - 15 - 15;
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, width, 10)];
    _timeLabel.textColor = COLOR_666666;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    
    _titleLabe1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, width, 20)];
    _titleLabe1.textColor = COLOR_333333;
    _titleLabe1.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [_containView addSubview:_timeLabel];
    [_containView addSubview:_titleLabe1];
    
    CGFloat pointX = 15.0f;
    NSMutableArray *starsList = [NSMutableArray array];
    for ( int  i = 0; i < 5; ++i ){
        UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(pointX, 15+30, 18, 18)];
        starView.layer.contents = (id)[UIImage imageNamed:@"star_gray"].CGImage;
        [_containView addSubview:starView];
        [starsList addObject:starView];
        pointX += 18 + 0.5;
    }
    _starsList = [NSArray arrayWithArray:starsList];
    
    _titleLabe1.text = @"学习";
    _timeLabel.text = @"9:00- 11:00";
    
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(containViewPan:)];
    _panGesture.delegate = self;
    [_containView addGestureRecognizer:_panGesture];
    
    [self addSubview:_containView];
    
    return self;
}

- (void)containViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];

    [pan setTranslation:CGPointZero inView:pan.view];
    CGRect frame = _containView.frame;
    frame.origin.x += point.x;
    if ( pan.state == UIGestureRecognizerStateChanged ){
        if ( frame.origin.x > OPSSideslipCellLeftLimitScrollMargin ){
            frame.origin.x = OPSSideslipCellLeftLimitScrollMargin;
        }
        if( frame.origin.x < -OPSSideslipCellRightLimitScrollMargin){
            frame.origin.x = -OPSSideslipCellRightLimitScrollMargin;
        }
        
        _containView.frame = frame;
    }
    if ( pan.state == UIGestureRecognizerStateEnded ){
        NSLog(@"enadddd~~~~~~~~~~");
        if ( frame.origin.x < OPSSideslipCellLeftLimitScrollMargin && frame.origin.x > 5 ){
            frame.origin.x = OPSSideslipCellLeftLimitScrollMargin;
        }
        
        if ( frame.origin.x < 0 ){
            frame.origin.x = -OPSSideslipCellRightLimitScrollMargin;
        }
        [self containViewAnimationWithFrame:frame];
        [self prohibitAction];
    }
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"2333");
    
    CGRect frame = CGRectMake(5, 5, UISCREEN_WIDTH-10, 60);
    if ( ![_containView isEquelToFrame:frame] ){
        [self containViewAnimationWithFrame:frame];
        return NO;
    }
    if ( gestureRecognizer == _panGesture ){
        UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [gesture translationInView:gesture.view];
        return fabs(translation.y) <= fabs(translation.x);
    }
    return YES;
}


- (void)containViewAnimationWithFrame:(CGRect)frame;
{
    //设置速度，以后在弄
    CGFloat length = fabs(_containView.origin.x - frame.origin.x);
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _containView.frame = frame;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        _containView.frame = frame;
    }];
    
    
    
}
         
- (void)prohibitAction
{
    for ( UIView *next = [self superview]; next; next = next.superview ){
        UIResponder *nextResponder = [next nextResponder];
        if ( [nextResponder isKindOfClass:[UIViewController class]] ){
            _cancelButton.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
            UIViewController *vc = (UIViewController *)nextResponder;
            [vc.view addSubview:_cancelButton];
            break;
        }
    }
}

- (void)canccelButtonTap:(id)sender
{
    [_cancelButton removeFromSuperview];
    _cancelButton.frame = CGRectMake(0, 0, 0, 0);
    
    [self containViewAnimationWithFrame:CGRectMake(5, 5, UISCREEN_WIDTH-10, 60)];
}
@end
