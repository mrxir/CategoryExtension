//
//  UIViewController+Extension.h
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/22.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

+ (UIStoryboard *)storyboard;

+ (__kindof UIViewController *)controllerMatchInStoryboard;

@end
