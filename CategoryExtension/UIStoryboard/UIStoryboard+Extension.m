//
//  UIStoryboard+Extension.m
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/22.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import "UIStoryboard+Extension.h"

#import <objc/runtime.h>

@implementation UIStoryboard (Extension)

+ (UIViewController *)controllerMatchInStoryboardWithID:(NSString *)identifier
{
    __block UIViewController *controller = nil;
    
    NSArray<__kindof NSDictionary *> *dictionarys = [[UIStoryboardManager defaultManager] storyboards].allObjects;
    
    [dictionarys enumerateObjectsUsingBlock:^(__kindof NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj[@"keys"] containsObject:identifier]) {
            
            UIStoryboard *storyboard = obj[@"objc"];
            
            controller = [storyboard controllerWithID:identifier];
            
            *stop = YES;
            
        }
        
    }];
    
    if (!controller) NSLog(@" | * [ERROR] 所有故事板中未找到 identifier 为 \"%@\" 的控制器", identifier);
    
    return controller;
}

+ (instancetype)mainStoryboard
{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

- (NSArray *)identifierList
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    NSArray *array = nil;
    
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName isEqualToString:@"identifierToNibNameMap"]) {
            array = [[self valueForKey:propertyName] allKeys];
            break;
        }
    }
    
    free(properties);
    
    return array;
}

- (NSString *)storyboardName
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    NSString *name = nil;
    
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName isEqualToString:@"storyboardFileName"]) {
            name = [self valueForKey:propertyName];
            name = [name stringByReplacingOccurrencesOfString:@".storyboardc" withString:@".sb"];
            break;
        }
    }
    
    free(properties);
    
    return name;
}

- (UIViewController *)entryController
{
    return [self instantiateInitialViewController];
}

- (UIViewController *)controllerWithID:(NSString *)identifier
{
    if ([[self identifierList] containsObject:identifier]) {
        return [self instantiateViewControllerWithIdentifier:identifier];
    } else {
        NSLog(@" | * [ERROR] %@ %@ 中未找到 identifier 为 \"%@\" 的控制器", self, [self storyboardName], identifier);
        return nil;
    }
}

@end

@implementation UIStoryboardManager

+ (instancetype)defaultManager
{
    static UIStoryboardManager *s_story = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_story = [[UIStoryboardManager alloc] init];
    });
    return s_story;
}

- (NSSet<NSDictionary *> *)storyboards
{
    NSMutableSet *set = [NSMutableSet set];
    
    if (!self.storyboardNames.count) {
        NSLog(@" | * [ERROR] 在使用 controller match 方法前请先设置 storyboardNames");
        return nil;
    }
    
    [self.storyboardNames enumerateObjectsUsingBlock:^(__kindof NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIStoryboard *storyboard = nil;
        
        @try {
            storyboard = [UIStoryboard storyboardWithName:obj bundle:nil];
        } @catch (NSException *exception) {
            NSLog(@" | * [ERROR] bundle 中未找到 name 为 \"%@\" 的故事板", obj);
        }
        
        if (storyboard) {
            
            NSDictionary *dictionary = @{@"name": obj,
                                         @"objc": storyboard,
                                         @"keys": [storyboard identifierList]};
            
            [set addObject:dictionary];
            
        }
        
    }];
    
    return set;
}

@end
