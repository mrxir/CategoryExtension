//
//  UIControl+Extension.h
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/19.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ControlEventsHandler)(__kindof UIControl *control);

@interface UIControl (Extension)

/**
 添加事件并在触发时执行 ControlEventHandler

 @param events 事件类型
 @param completion 事件block
 */
- (void)handleWithEvents:(UIControlEvents)events completion:(ControlEventsHandler)completion;

@end
