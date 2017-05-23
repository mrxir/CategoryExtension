//
//  UIView+Extension.m
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/23.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import "UIView+Extension.h"

#import <objc/runtime.h>

@implementation UIView (Extension)

#pragma mark - private set and get option

- (void)private_setGestureOption:(GestureOption)option
{
    objc_setAssociatedObject(self, @"_gestureOption", [NSNumber numberWithUnsignedInteger:option], OBJC_ASSOCIATION_ASSIGN);
}

- (NSUInteger)private_getGestureOption
{
    return [((NSNumber *)objc_getAssociatedObject(self, @"_gestureOption")) unsignedIntegerValue];
}

- (void)setViewGestureHandler:(ViewGestureHandler)viewGestureHandler
{
    objc_setAssociatedObject(self, @"viewGestureHandler", viewGestureHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ViewGestureHandler)viewGestureHandler
{
    return objc_getAssociatedObject(self, @"viewGestureHandler");
}

- (void)performViewGestureHandler:(UIGestureRecognizer *)gestureRecognizer
{
    // 不同的手势类型, 触发的时机不同
    GestureOption option = [self private_getGestureOption];
    
    // 点击手势, 结束时触发
    if (option >= GestureOptionSingleTap && option <= GestureOptionTripleTap) {
        
        if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            
            if (self.viewGestureHandler) self.viewGestureHandler(self);
            
        }
    
    // 长按手势, 开始时触发
    } else if (option == GestureOptionLongPress) {
        
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            
            if (self.viewGestureHandler) self.viewGestureHandler(self);
            
        }
        
    }
    
    
}

- (void)handleWithGestureOption:(GestureOption)option completion:(ViewGestureHandler)completion
{
    if (completion) {
        
        [self setUserInteractionEnabled:YES];
        
        [self private_setGestureOption:option];
        
        [self setViewGestureHandler:completion];
        
        [[self gestureRecognizers] enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self removeGestureRecognizer:obj];
        }];
        
        UIGestureRecognizer *gestureRecognizer = nil;
        
        if (option >= GestureOptionSingleTap && option <= GestureOptionTripleTap) {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performViewGestureHandler:)];
            tap.numberOfTapsRequired = option;
            tap.numberOfTouchesRequired = 1;
            
            gestureRecognizer = tap;
            
            
        } else if (option == GestureOptionLongPress) {
            
            UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(performViewGestureHandler:)];
            press.numberOfTouchesRequired = 1;
            
            gestureRecognizer = press;
            
        } else {
            
            NSLog(@" | * [ERROR] 不支持该选项 GestureOption:%d , 请先阅读 API 及用法, 谢谢!", (unsigned)option);
        }
        
        [self addGestureRecognizer:gestureRecognizer];
        
    }
    
}

@end
