//
//  NSObject+Extension.m
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/19.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import "NSObject+Extension.h"

#import <objc/runtime.h>

@implementation NSObject (Extension)

@dynamic objectIndexPath;

- (NSIndexPath *)objectIndexPath
{
    return objc_getAssociatedObject(self, @"objectIndexPath");
}

- (void)setObjectIndexPath:(NSIndexPath *)objectIndexPath
{
    objc_setAssociatedObject(self, @"objectIndexPath", objectIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isValidString
{
    BOOL validString = NO;
    
    NSString *someString = (NSString *)self;
    
    if ([someString respondsToSelector:@selector(isEqualToString:)]) {
        
        if (![someString isEqualToString:@"(null)"] &&
            ![someString isEqualToString:@"<null>"] &&
            ![someString isEqualToString:@"null"])
        {
            validString = YES;
        }
        
    }
    
    return validString;
}

- (NSString *)stringWithJSON
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
    
}

- (NSString *)stringWithUTF8
{
    
    BOOL isString = [self isKindOfClass:[NSString class]];
    
    BOOL isArray = [self isKindOfClass:[NSArray class]];
    
    BOOL isDictionary = [self isKindOfClass:[NSDictionary class]];
    
    BOOL isSet = [self isKindOfClass:[NSSet class]];
    
    BOOL isData = [self isKindOfClass:[NSData class]];
    
    if (isString || isArray || isDictionary || isSet) {
        
        if ([self respondsToSelector:@selector(length)]) {
            if (![self performSelector:@selector(length)]) return self.description;
        }
        
        if ([self respondsToSelector:@selector(count)]) {
            if (![self performSelector:@selector(count)]) return self.description;
        }
        
        NSString *tempString0 = self.description;
        
        NSString *tempString1 = [tempString0 stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
        NSString *tempString2 = [tempString1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSString *tempString3 = [[@"\"" stringByAppendingString:tempString2] stringByAppendingString:@"\""];
        NSData *tempData = [tempString3 dataUsingEncoding:NSUTF8StringEncoding];
        
        return [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:nil error:nil];
        
    } else if (isData) {
        
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
        
    } else {
        
        return self.description.stringWithUTF8;
        
    }
    
}

+ (NSDictionary *)propertyWithObject:(__kindof NSObject *)object
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList([object class], &propertyCount);
    
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self getObjectInternalValue:[object valueForKey:propertyName]];
        dictionary[propertyName] = value;
    }
    
    free(properties);
    return dictionary;
}

- (id)getObjectInternalValue:(id)obj
{
    if (!obj
        || [obj isKindOfClass:[NSNull class]]
        || [obj isKindOfClass:[NSNumber class]]
        || [obj isKindOfClass:[NSString class]]) {
        
        return obj;
    }
    
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *arrayObj = obj;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:arrayObj.count];
        for (int i=0; i<arrayObj.count; i++) {
            [array setObject:[self getObjectInternalValue:[arrayObj objectAtIndex:i]] atIndexedSubscript:i];
        }
        
        return array;
    }
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionaryObj = obj;
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:[dictionaryObj count]];
        for (NSString *key in dictionaryObj.allKeys) {
            [dictionary setObject:[self getObjectInternalValue:[dictionaryObj objectForKey:key]] forKey:key];
        }
        
        return dictionary;
    }
    
    return obj;
    
}

@end
