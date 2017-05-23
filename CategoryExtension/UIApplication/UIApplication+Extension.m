//
//  UIApplication+Extension.m
//  MRRequestDemo
//
//  Created by 🍉 on 2017/5/16.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import "UIApplication+Extension.h"

@implementation UIApplication (Extension)

- (UIViewController *)topViewController
{
    UIViewController *controller = [self topParentViewController:[self.keyWindow rootViewController]];
    
    while (controller.presentedViewController) {
        
        controller = [self topParentViewController:controller.presentedViewController];
        
    }
    
    return controller;
}

- (UIViewController *)topParentViewController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        
        return [self topParentViewController:[(UINavigationController *)controller topViewController]];
        
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        
        return [self topParentViewController:[(UITabBarController *)controller selectedViewController]];
        
    } else {
        
        return controller;
        
    }
}


@end
