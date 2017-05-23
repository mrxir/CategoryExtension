//
//  NSString+Extension.m
//  CategoryExtensionDemo
//
//  Created by 🍉 on 2017/5/19.
//  Copyright © 2017年 🍉. All rights reserved.
//

#import "NSString+Extension.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (NSString *)md5Hash
{
    CC_MD5_CTX md5HashContext;
    CC_MD5_Init (&md5HashContext);
    CC_MD5_Update (&md5HashContext, [self UTF8String], (CC_LONG) [self length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5HashContext);
    NSString *md5HashString = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                               digest[0],  digest[1],
                               digest[2],  digest[3],
                               digest[4],  digest[5],
                               digest[6],  digest[7],
                               digest[8],  digest[9],
                               digest[10], digest[11],
                               digest[12], digest[13],
                               digest[14], digest[15]];
    
    return md5HashString;
}

+ (NSString *)md5HashWithFile:(NSString *)filePath
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (handle == nil) return nil;
    
    CC_MD5_CTX md5HashContext;
    CC_MD5_Init (&md5HashContext);
    
    BOOL done = NO;
    
    while (!done) {
        
        NSData *fileData = [[NSData alloc] initWithData:[handle readDataOfLength:4096]];
        CC_MD5_Update (&md5HashContext, [fileData bytes], (CC_LONG) [fileData length]);
        
        if ([fileData length] == 0) {
            done = YES;
        }
        
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5HashContext);
    NSString *md5HashString = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                               digest[0],  digest[1],
                               digest[2],  digest[3],
                               digest[4],  digest[5],
                               digest[6],  digest[7],
                               digest[8],  digest[9],
                               digest[10], digest[11],
                               digest[12], digest[13],
                               digest[14], digest[15]];
    
    return md5HashString;
}

- (CGRect)boundingRectWithFont:(UIFont *)font frame:(CGRect)frame CalculateOption:(CalculateOption)option
{
    if (!self.length) {
        return [@"|" boundingRectWithFont:font frame:frame CalculateOption:option];
    } else {
        
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{NSFontAttributeName: font,
                                     NSParagraphStyleAttributeName: style};
        
        CGSize maxSize = CGSizeZero;
        
        CGRect boundingRect = CGRectZero;
        
        if (option == CalculateOptionWidth) {
            maxSize = CGSizeMake(CGFLOAT_MAX, frame.size.height);
            boundingRect = [self boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
            boundingRect.size.width += ceilf(boundingRect.size.width);
            
        } else {
            maxSize = CGSizeMake(frame.size.width, CGFLOAT_MAX);
            boundingRect = [self boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
            boundingRect.size.height = ceilf(boundingRect.size.height);
        }
        
        return boundingRect;
        
    }
    
}

@end
