//
//  UIViewController+Extension.m
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/22.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import "UIViewController+Extension.h"

#import "UIStoryboard+Extension.h"

@implementation UIViewController (Extension)

+ (UIStoryboard *)storyboard
{
    return [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil];
}

+ (UIViewController *)controllerMatchInStoryboard
{
    return [UIStoryboard controllerMatchInStoryboardWithID:NSStringFromClass([self class])];
}

@end
