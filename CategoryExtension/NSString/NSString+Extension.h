//
//  NSString+Extension.h
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/19.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 返回该字符串的MD5Hash值

 @return NSString
 */
- (NSString *)md5Hash;

/**
 返回该文件的MD5Hash值

 @param filePath 文件路径
 @return NSString
 */
+ (NSString *)md5HashWithFile:(NSString *)filePath;

typedef NS_ENUM(NSUInteger, CalculateOption) {
    CalculateOptionWidth,
    CalculateOptionHeight,
};

/**
 返回字符串的边界

 @param font 当前字符串使用的字体
 @param frame 当前字符串的显示范围
 @param option 计算宽度或者高度选项
 @return CGRect
 */
- (CGRect)boundingRectWithFont:(UIFont *)font frame:(CGRect)frame CalculateOption:(CalculateOption)option;

@end
