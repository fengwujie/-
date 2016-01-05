//
//  WJSysTool.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/5.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJSysTool.h"

@implementation WJSysTool

+ (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //[UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:window cache:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}

+ (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
    
}

@end
