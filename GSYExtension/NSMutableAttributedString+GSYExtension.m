#import "NSMutableAttributedString+GSYExtension.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (GSYExtension)

- (NSMutableAttributedString *)gsy_setTextAlignmentFromBottomToCenterWithMaxWidth:(CGFloat)maxWidth {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGMutablePathRef paths = CGPathCreateMutable();
    CGPathAddRect(paths, NULL, CGRectMake(0, 0, maxWidth, MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), paths, NULL);
    
    // 获取CTLineRef数组
    CFArrayRef lines = CTFrameGetLines(frame);
    // CTLineRef的数量 行数
    CFIndex rowcount = [(__bridge NSArray *)lines count]; // CFArrayGetCount(lines);
    // 每行的origins
    CGPoint lineOrigins[rowcount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    
    for (NSInteger i = 0; i < rowcount; i++) {
        // 获取指定索引的CTLineRef
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        // 一行内CTRunRef的数组
        CFArrayRef runList = CTLineGetGlyphRuns(lineRef);
        // 一行内CTRunRef的数量
        CFIndex runCount = [(__bridge NSArray *)runList count]; //CTLineGetGlyphCount(lineRef);
        
        CGFloat asc, des, lead; // 上行高、下行高、行距 整行高为三者相加
        CGFloat lineWidth = CTLineGetTypographicBounds(lineRef, &asc, &des, &lead); // 行宽
        
        CGFloat lineHeight = asc + des + lead; // 行高
        NSLog(@"第%02ld行: w = %.2f, h = %.2f", i + 1, lineWidth, lineHeight);
        
        // 单独开出一个数组来保存需要更新baseline的数据
        CGFloat maxHeight = 0;
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        for (NSInteger j = 0; j < runCount; j++) {
            // 指定索引的CTRunRef
            CTRunRef runRef = CFArrayGetValueAtIndex(runList, j);
            
            // run处于字符串的位置信息
            CFRange runRange = CTRunGetStringRange(runRef);
            
            // 取得该range的文字, 如果是空格的话就不判定高低了
            NSString *word = [self.string substringWithRange:NSMakeRange(runRange.location, runRange.length)];
            if ([word containsString:@" "]) continue;
            
            // 位置信息
            CGRect runFrame; CGFloat ascent, descent, leading;
            
            runFrame.size.width = CTRunGetTypographicBounds(runRef, CFRangeMake(0, 0), &ascent, &descent, &leading);
            runFrame.size.height = ascent;
            
            // 将range信息作为origin保存到frame中
            runFrame.origin.x = runRange.location;
            runFrame.origin.y = runRange.length;
            [tmpArray addObject:NSStringFromCGRect(runFrame)];
            
            if (runFrame.size.height > maxHeight) {
                maxHeight = runFrame.size.height;
            }
        }
        
        for (NSString *str in tmpArray) {
            CGRect tmp = CGRectFromString(str);
            if (maxHeight - tmp.size.height > 0) {
                [self addAttribute:NSBaselineOffsetAttributeName value:@((maxHeight - tmp.size.height) / 2) range:NSMakeRange((int)(tmp.origin.x), (int)(tmp.origin.y))];
            }
        }
    }
    
    CFRelease(paths);
    CFRelease(framesetter);
    CFRelease(frame);
    
    return self;
}

- (CGSize)gsy_textSizeWithMaxSize:(CGSize)maxSize numberOfLines:(NSUInteger)numberOfLines {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGMutablePathRef paths = CGPathCreateMutable();
    CGPathAddRect(paths, NULL, CGRectMake(0, 0, maxSize.width, maxSize.height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), paths, NULL);
    
    // 获取CTLineRef数组
    CFArrayRef lines = CTFrameGetLines(frame);
    // CTLineRef的数量 行数
    CFIndex rowcount = [(__bridge NSArray *)lines count]; // CFArrayGetCount(lines);
    // 每行的origins
    CGPoint lineOrigins[rowcount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    
    // 总高
    CGFloat maxHeight = 0;
    CGFloat maxWidth = 0;
    
    for (NSInteger i = 0; i < rowcount; i++) {
        // 获取指定索引的CTLineRef
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        // 一行内CTRunRef的数组
        CFArrayRef runList = CTLineGetGlyphRuns(lineRef);
        // 一行内CTRunRef的数量
        CFIndex runCount = [(__bridge NSArray *)runList count]; //CTLineGetGlyphCount(lineRef);
        
        CGFloat asc, des, lead; // 上行高、下行高、行距 整行高为三者相加
        CGFloat lineWidth = CTLineGetTypographicBounds(lineRef, &asc, &des, &lead); // 行宽
        maxWidth = MAX(maxWidth, lineWidth);
        
        CGFloat lineHeight = asc + des + lead; // 行高
        maxHeight += lineHeight;
        
        NSLog(@"[第%02ld行]--w = %f, h = %f", i, lineWidth, lineHeight);
        
        // 该行的行间距
        CGFloat lineSpacing = 0;
        
        if (runCount > 0) {
            // 指定索引的CTRunRef
            CTRunRef runRef = CFArrayGetValueAtIndex(runList, 0);
            
            // 取出参数
            CFDictionaryRef attributesRef = CTRunGetAttributes(runRef);
            
            // 取出段落风格对象
            NSMutableParagraphStyle *style = (__bridge id)CFDictionaryGetValue(attributesRef, @"NSParagraphStyle");
            
            if ([style isKindOfClass:NSParagraphStyle.class]) { // 取每行的第一个run的lineSpacing作为整行的行间距
                lineSpacing = style.lineSpacing;
            }
            
            // run处于字符串的位置信息
            CFRange runRange = CTRunGetStringRange(runRef);
            
            // 取得该range的文字, 如果是空格的话就不判定高低了
            NSString *word = [self.string substringWithRange:NSMakeRange(runRange.location, runRange.length)];
            
            NSLog(@"[lineSpacing]-行: %ld, 字段: %@, 区间: {%ld, %ld}, 行间距: %f", i, word, runRange.location, runRange.length, lineSpacing);
        }
        
        maxHeight += lineSpacing;
        if (numberOfLines == 0) {
            if (i == rowcount - 1) {
                maxHeight -= lineSpacing;
            }
        }else if (rowcount > numberOfLines) {
            if (i >= numberOfLines - 1) {
                maxHeight -= lineSpacing;
                break;
            }
        }else {
            if (i == rowcount - 1) {
                maxHeight -= lineSpacing;
            }
        }
    }
    
    CFRelease(paths);
    CFRelease(framesetter);
    CFRelease(frame);
    
    return CGSizeMake(maxWidth, maxHeight);
}

- (NSMutableAttributedString *)gsy_appendString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing {
    if (!self  || ![self isKindOfClass:NSMutableAttributedString.class]) {
        return nil;
    }
    
    if (!string || ![string isKindOfClass:NSString.class]) {
        return self;
    }
    
    NSMutableAttributedString *tmpAttr = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    [tmpAttr setAttributes:@{NSParagraphStyleAttributeName: style} range:NSMakeRange(0, string.length)];
    
    if (color && [color isKindOfClass:UIColor.class]) {
        [tmpAttr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    }
    
    if (font && [font isKindOfClass:UIFont.class]) {
        [tmpAttr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    }
    
    [self appendAttributedString:tmpAttr];
    
    return self;
}


- (NSMutableAttributedString *)gsy_modifyString:(NSString *)textStr toColor:(UIColor *)color toFont:(UIFont *)font
{
    if (!self || ![self isKindOfClass:NSMutableAttributedString.class]) { // 为空或者非可变富文本字符串则返回nil
        return nil;
    }
    
    if (!textStr || ![textStr isKindOfClass:NSString.class] || textStr.length <= 0) { // 防止卡死, 没内容不用计算
        return self;
    }
    
    NSMutableAttributedString *tmpAttr = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    
    for (int i = 0; i < tmpAttr.length - textStr.length; i++) {
        // 裁剪该起始位置指定长度的字符串进行对比
        if (i + textStr.length > tmpAttr.length) {
            break;
        }
        
        NSString *str = [tmpAttr.string substringWithRange:NSMakeRange(i, textStr.length)];
        if ([textStr isEqualToString:str]) {
            if (color && [color isKindOfClass:UIColor.class]) {
                [tmpAttr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(i, textStr.length)];
            }
            
            if (font && [font isKindOfClass:UIFont.class]) {
                [tmpAttr addAttribute:NSFontAttributeName value:font range:NSMakeRange(i, textStr.length)];
            }
            
            // 将指针改变位置
            i += textStr.length;
        }
    }
    
    return tmpAttr;
}

- (NSMutableAttributedString *)gsy_modifyString:(NSString *)string toAttributedString:(NSAttributedString *)attributedString
{
    if (!self || ![self isKindOfClass:NSMutableAttributedString.class]) { // 为空或者非可变富文本字符串则返回nil
        NSAssert(NO, @"被扫描字符串不合法");
        return nil;
    }
    
    if (!string || ![string isKindOfClass:NSString.class]) {
        NSAssert(NO, @"待查找字符串不合法");
        return self;
    }
    
    if (!attributedString || ![attributedString isKindOfClass:NSAttributedString.class]) {
        NSAssert(NO, @"替换字符串不合法");
        return self;
    }
    
    NSMutableAttributedString *originalString = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    
    // 从左往右开始扫描计算
    for (int i = 0; i < originalString.length - attributedString.length; i++) {
        if (i + string.length > originalString.length) {
            break;
        }
        
        // 从索引位置裁剪等长度的字符与原字符进行比较
        NSRange range = NSMakeRange(i, string.length);
        NSString *tmpString = [originalString.string substringWithRange:range];
        
        // 两者如果一致, 则替换其变成指定富文本
        if ([tmpString isEqualToString:string]) {
            [originalString replaceCharactersInRange:range withAttributedString:attributedString];
            
            // 替换完成之后原本的富文本字符串长度可能发生了变化, 则将指针指向替换完字符后的索引位置
            i += attributedString.length;
        }
    }
    
    return originalString;
}

- (NSMutableAttributedString *)gsy_appendImage:(UIImage *)image imageBounds:(CGRect)bounds {
    if (!image || ![image isKindOfClass:UIImage.class]) return self;
    if (CGRectEqualToRect(bounds, CGRectZero)) return self;
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = bounds;
    attachment.image = image;
    
    [self appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];

    return self;
}

@end
