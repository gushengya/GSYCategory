#import <Foundation/Foundation.h>


@interface NSString (GSYExtension)

#pragma mark- 通用

/// 字符串中的中文转为汉语拼音(不带音标)
@property (nonatomic, readonly) NSString *gsy_pinyin;
/// 字符串中的中文转为汉语拼音(带音标)
@property (nonatomic, readonly) NSString *gsy_pinyinWithSymbol;

/// 计算字符串字符长度，一个汉字算两个字符 -- 字符串不能为nil(因为emoji表情及外文字符的原因很可能不准)
@property (nonatomic, readonly) NSUInteger gsy_unicodeLength;

/// 字符串中是否包含中文
@property (nonatomic, readonly) BOOL gsy_containChineseWord;

/// 按字符集分割字符串
/// - Parameter chars: 字符组成的集合如@"简6"
- (NSArray *)gsy_separateStringByChars:(NSString *)chars;

/// 字符串逆向输出(中文跳过) 如: @"123456" --> @"654321"
- (NSString *)gsy_reversalChars;

@end
