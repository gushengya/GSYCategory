#import "UIColor+GSYExtension.h"

@implementation UIColor (GSYExtension)

- (CGFloat)gsy_redValue {
    CGFloat r = 0;
    [self getRed:&r green:nil blue:nil alpha:nil];
    return r;
}

- (CGFloat)gsy_greenValue {
    CGFloat g = 0;
    [self getRed:nil green:&g blue:nil alpha:nil];
    return g;
}

- (CGFloat)gsy_blueValue {
    CGFloat b = 0;
    [self getRed:nil green:nil blue:&b alpha:nil];
    return b;
}

- (CGFloat)gsy_alphaValue {
    CGFloat a = 0;
    [self getRed:nil green:nil blue:nil alpha:&a];
    return a;
}

- (NSString *)gsy_hexString {
    CGFloat r, g, b, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    NSString *hexStr = [NSString stringWithFormat:@"0x%02x%02x%02x%02x", (int)(r * 255), (int)(g * 255), (int)(b * 255), (int)(a * 255)];
    return hexStr;
}

+ (UIColor *)gsy_colorWithRed:(int)red green:(int)green blue:(int)blue alpha:(int)alpha {
    CGFloat r = red / 255.f;
    CGFloat g = green / 255.f;
    CGFloat b = blue / 255.f;
    CGFloat a = alpha / 255.f;
    r = MIN(1, MAX(r, 0));
    g = MIN(1, MAX(g, 0));
    b = MIN(1, MAX(b, 0));
    a = MIN(1, MAX(a, 0));
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+ (UIColor *)gsy_colorWithRGBHexNumber:(NSUInteger)hexNumber {
    return [UIColor gsy_colorWithRed:(hexNumber & 0xFF0000) >> 16 green:(hexNumber & 0x00FF00) >> 8 blue:(hexNumber & 0x0000FF) alpha:255];
}

+ (UIColor *)gsy_colorWithRGBAHexNumber:(NSUInteger)hexNumber {
    return [UIColor gsy_colorWithRed:(hexNumber & 0xFF000000) >> 24 green:(hexNumber & 0x00FF0000) >> 16 blue:(hexNumber & 0x0000FF00) >> 8 alpha:(hexNumber & 0x000000FF)];
}

+ (int)gsy_integerFromHexString:(NSString *)hexString {
    if (!hexString || ![hexString isKindOfClass:NSString.class]) return 0;
    NSUInteger tmpNumber = 0;
    sscanf([hexString UTF8String], "%lx", &tmpNumber);
    return (int)tmpNumber;
}

+ (UIColor *)gsy_colorWithRGBHexString:(NSString *)hexString {
    if (!hexString || ![hexString isKindOfClass:NSString.class]) return nil;
    
    // 去除空格
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    if (hexString.length <= 0) return nil;
    
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }else if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }else {
        return nil;
    }
    
    if (hexString.length != 6 && hexString.length != 8) return nil;
    
    int red = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(0, 2)]];
    int green = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(2, 2)]];
    int blue = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(4, 2)]];
    
    if (hexString.length == 8) {
        int alpha = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(6, 2)]];
        return [UIColor gsy_colorWithRed:red green:green blue:blue alpha:alpha];
    }
    
    return [UIColor gsy_colorWithRed:red green:green blue:blue alpha:255];
}

+ (UIColor *)gsy_colorWithRGBAHexString:(NSString *)hexString {
    if (!hexString || ![hexString isKindOfClass:NSString.class]) return nil;
    
    // 去除空格
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    if (hexString.length <= 0) return nil;
    
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }else if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }else {
        return nil;
    }
    
    if (hexString.length != 8) return nil;
    
    int red = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(0, 2)]];
    int green = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(2, 2)]];
    int blue = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(4, 2)]];
    int alpha = [UIColor gsy_integerFromHexString:[hexString substringWithRange:NSMakeRange(6, 2)]];
    
    return [UIColor gsy_colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)gsy_colorWithRandomRGB {
    return [UIColor gsy_colorWithRed:(arc4random() % 256) green:(arc4random() % 256) blue:(arc4random() % 256) alpha:255];
}

+ (UIColor *)gsy_colorWithRandomRGBA {
    return [UIColor gsy_colorWithRed:(arc4random() % 256) green:(arc4random() % 256) blue:(arc4random() % 256) alpha:(arc4random() % 256)];
}



@end
