#import "NSString+GSYExtension.h"

@implementation NSString (GSYExtension)

#pragma mark - 通用
- (NSString *)gsy_pinyin {
    if (![self isKindOfClass:NSString.class]) return nil;
    
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSString *)gsy_pinyinWithSymbol {
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSUInteger)gsy_unicodeLength {
    // 1. 创建一个正integer
    NSUInteger sum = 0;
    // 2. 遍历字符串每个字符
    for (int i = 0; i < self.length; i++) {
        // 3. 获得字符串对应索引的字符
        unichar uc = [self characterAtIndex:i];
        // 4. 判断该字符是否是asc码
        sum += isascii(uc) ? 1 : 2;
    }
    // 5. 返回最终的计数
    return sum;
    
    
//    // 方法二
//    int strlength = 0;
//    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
//    for (int i=0 ; i< [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
//    {
//        if (*p)
//        {
//            p++;
//            strlength++;
//        }
//        else
//        {
//            p++;
//        }
//        
//    }
//    return strlength;
}

- (BOOL)gsy_containChineseWord {
    for (int i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i]; // 取出每一个字符
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)gsy_separateStringByChars:(NSString *)chars {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:chars];
    return [self componentsSeparatedByCharactersInSet:set];
}

- (NSString *)gsy_reversalChars {
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:self.length];
    for (NSInteger i = self.length - 1; i >= 0 ; i --) {
        unichar ch = [self characterAtIndex:i];
        if (isascii(ch)) {
            [newString appendFormat:@"%c", ch];
        }
    }
    return newString;
}


@end
