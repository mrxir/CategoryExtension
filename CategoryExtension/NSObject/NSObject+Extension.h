//
//  NSObject+Extension.h
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/19.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSObject (Extension)

@property (nonatomic, strong) NSIndexPath *objectIndexPath;

- (NSIndexPath *)objectIndexPath;

- (void)setObjectIndexPath:(NSIndexPath *)objectIndexPath;

/**
 返回这个对象是否是一个有效的字符串,如果字符串等于 "(null)" 或 "<null>" 或 "null" 则判定为无效字符串.

 @return BOOL
 */
- (BOOL)isValidString;


/**
 如果是个有效的JSONObject,则把它转成JSON字符串.

 @return NSString
 */
- (NSString *)stringWithJSON;


/**
 当UTF8编码字符被放入容器中,可以使用该方法将容器的 description 能够查看编码之前的原文,例如中文和表情符号.

 @return NSString
 */
- (NSString *)stringWithUTF8;

/**
 返回该对象的属性和值的字典

 @return NSDictionary
 */

+ (NSDictionary *)propertyWithObject:(__kindof NSObject *)object;

@end
