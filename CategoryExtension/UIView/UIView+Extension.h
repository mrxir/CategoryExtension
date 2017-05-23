//
//  UIView+Extension.h
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/23.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GestureOption) {
    GestureOptionSingleTap = 1,
    GestureOptionDoubleTap = 2,
    GestureOptionTripleTap = 3,
    GestureOptionLongPress = 9,
};

typedef void(^ViewGestureHandler)(__kindof UIView *view);

@interface UIView (Extension)

/**
 为该视图添加手势并在触发时执行 ViewGestureHandler

 @param option 手势选项
 @param completion 事件block
 */
- (void)handleWithGestureOption:(GestureOption)option completion:(ViewGestureHandler)completion;

@end
