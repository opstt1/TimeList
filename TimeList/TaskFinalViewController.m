//
//  TaskFinalViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "TaskFinalViewController.h"
#import "TaskCardView.h"
#import "Constants.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface TaskFinalViewController ()<TasckCardViewDelegate>

@property (nonatomic, readwrite, assign) TaskCardStatusDirection cardStatusDirection;
@property (nonatomic, readwrite, strong) UIViewController *dislpayViewController;

@end

@implementation TaskFinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TaskCardView *cardView = [[TaskCardView alloc] init];
    cardView.taskCardViewDelegate = self;
    [self.view addSubview:cardView];
    
    _cardStatusDirection = TaskCardInTheCenter;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.backgroundColor = [UIColor blueColor];
    barImageView.alpha = 0.0f;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 1.0f;
}

#pragma mark - TasckCardViewDelegate

- (void)taskCardView:(TaskCardView *)taskCardView changeCenter:(CGPoint)center
{
    if ( UISCREEN_WIDTH/2 == center.x && UISCREEN_HEIGHT/2 == center.y){
        _cardStatusDirection = TaskCardInTheCenter;
        [self changChildViewController];
        NSLog(@"在中央");
    }
    else if ( UISCREEN_HEIGHT/2 == center.y ){
        if ( center.x > UISCREEN_WIDTH/2 &&  _cardStatusDirection != TaskCardInTheRight ){
            _cardStatusDirection = TaskCardInTheRight;
            [self changChildViewController];
            NSLog(@"左边的盆友，出来");
        }else if ( center.x < UISCREEN_WIDTH/2 && _cardStatusDirection != TaskCardInTheLeft ){
            _cardStatusDirection = TaskCardInTheLeft;
            [self changChildViewController];
            NSLog(@"右边的朋友！");
        }
        return;
    }else if ( UISCREEN_WIDTH / 2 == center.x ){
        if ( center.y > UISCREEN_HEIGHT / 2 && _cardStatusDirection != TaskCardInTheDowm ){
            _cardStatusDirection = TaskCardInTheDowm;
            [self changChildViewController];
            NSLog(@"上边的盆友");
        }else if ( center.y < UISCREEN_HEIGHT / 2 && _cardStatusDirection != TaskCardInTheUp ){
            _cardStatusDirection = TaskCardInTheUp;
            [self changChildViewController];
            NSLog(@"下边的兄弟～！");
        }
    }
    
}


- (void)changChildViewController
{
    if ( _dislpayViewController != nil ){
        [_dislpayViewController willMoveToParentViewController:nil];
        [_dislpayViewController.view removeFromSuperview];
        [_dislpayViewController removeFromParentViewController];
        [_dislpayViewController didMoveToParentViewController:nil];
        _dislpayViewController = nil;
    }
    
    if ( _cardStatusDirection == TaskCardInTheCenter ){
        return;
    }
    
    if ( _cardStatusDirection == TaskCardInTheRight ){
        SecondViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondViewController"];
        _dislpayViewController = vc;
    }
    
    if ( _cardStatusDirection == TaskCardInTheUp ){
        FirstViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FirstViewController"];
        _dislpayViewController = vc;
    }
    
    if ( _dislpayViewController == nil ){
        return;
    }
    
    [_dislpayViewController willMoveToParentViewController:self];
    [self.view insertSubview:_dislpayViewController.view atIndex:0];
    [self addChildViewController:_dislpayViewController];
    [_dislpayViewController didMoveToParentViewController:self];
    
    
}


- (void)addViewController:(UIViewController *)addViewController removeViewController:(UIViewController *)removeViewController
{
    
}
@end
