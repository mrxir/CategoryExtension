//
//  UIControl+Extension.m
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/19.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import "UIControl+Extension.h"

#import <objc/runtime.h>

@implementation UIControl (Extension)

- (void)setControlEventsHandler:(ControlEventsHandler)controlEventsHandler
{
    objc_setAssociatedObject(self, @"controlEventHandler", controlEventsHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ControlEventsHandler)controlEventsHandler
{
    return objc_getAssociatedObject(self, @"controlEventHandler");
}

- (void)performControlEventsHandler
{
    if (self.controlEventsHandler) self.controlEventsHandler(self);
}

- (void)handleWithEvents:(UIControlEvents)Events completion:(ControlEventsHandler)completion
{
    if (completion) {
        
        [self setControlEventsHandler:completion];
        
        if ([[self actionsForTarget:self forControlEvent:Events] count] > 0) {
            
            [self removeTarget:self action:@selector(performControlEventsHandler) forControlEvents:Events];
        }
        
        [self addTarget:self action:@selector(performControlEventsHandler) forControlEvents:Events];

    }
    
}


@end
