//
//  UIStoryboard+Extension.h
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/22.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Extension)

/**
 在所有的 storyboard 中匹配该 ID 所对应的控制器, 当有多个相同的ID时, 返回找到的第一个对象.

 @param identifier 控制器ID
 @return UIViewController
 */
+ (__kindof UIViewController *)controllerMatchInStoryboardWithID:(NSString *)identifier;

/**
 返回 Main.storyboard

 @return UIStoryboard
 */
+ (instancetype)mainStoryboard;

/**
 返回当前 storyboard 名称

 @return NSString
 */
- (NSString *)storyboardName;

/**
 返回当前 storyboard 中的 identifier 列表

 @return NSArray
 */
- (NSArray *)identifierList;

/**
 返回当前 storyboard 中的 入口控制器

 @return UIViewController
 */
- (__kindof UIViewController *)entryController;

/**
 返回当前 storyboard 中匹配该 ID 所对应的控制器.

 @param identifier 控制器ID
 @return UIViewController
 */
- (__kindof UIViewController *)controllerWithID:(NSString *)identifier;

@end

@interface UIStoryboardManager : NSObject

@property (nonatomic, strong) NSArray<__kindof NSString *> *storyboardNames;

@property (nonatomic, strong, readonly) NSSet<__kindof NSDictionary *> *storyboards;

+ (instancetype)defaultManager;

@end
