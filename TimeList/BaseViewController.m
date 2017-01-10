//
//  BaseViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseViewController.h"
#import "RectAnimationTransitionPop.h"

@interface BaseViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateViewController
{
    
}

- (void)addBackGestureRecognizer
{
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backHandlePan:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)backHandlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    if([gestureRecognizer translationInView:self.view].x>=0)
    {
        //手势滑动的比例
        CGFloat per = [gestureRecognizer translationInView:self.view].x / (self.view.bounds.size.width);
        per = MIN(1.0,(MAX(0.0, per)));
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            
            self.interactiveTransition=[UIPercentDrivenInteractiveTransition new];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            if([gestureRecognizer translationInView:self.view].x ==0)
            {
                [self.interactiveTransition updateInteractiveTransition:0.01];
            }
            else
            {
                [self.interactiveTransition updateInteractiveTransition:per];
                
            }
            
        }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled){
            
            if([gestureRecognizer translationInView:self.view].x ==0)
            {
                [self.interactiveTransition cancelInteractiveTransition];
                self.interactiveTransition = nil;
            }
            else if (per > 0.5) {
                
                [ self.interactiveTransition finishInteractiveTransition];
                
                
            }else{
                [ self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
            
        }
        
        
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        
        
        [self.interactiveTransition updateInteractiveTransition:0.01];
        [self.interactiveTransition cancelInteractiveTransition];
        
        
        
    }else if ((gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled))
    {
        
        self.interactiveTransition = nil;
    }
}

//为这个动画添加用户交互
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {

    return self.interactiveTransition;
}
//用来自定义转场动画
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        RectAnimationTransitionPop *pingInvert = [RectAnimationTransitionPop new];
        return pingInvert;
    }else{
        return nil;
    }
}

@end
