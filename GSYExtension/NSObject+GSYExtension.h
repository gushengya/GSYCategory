#import <Foundation/Foundation.h>

@interface NSObject (GSYExtension)

/**
 * 通过系统方法把字典/数组等转化为JSON字符串方便上传服务器
 * 
 * @param isPretty 是否漂亮易看 -- YES表示易看(拼接成的字段中间有" "和"\n"分割), NO表示不易查看(中间没有空格和回车)所有字段自然分割拼接连成一串
 * 
 * @return 对应的JSON字符串
 */
- (NSString *)gsy_jsonSerialWithWritingPrettyPrinted:(BOOL)isPretty;

/// 是NSString吗
- (BOOL)gsy_isString;

/// 是非空NSString吗
- (BOOL)gsy_isNotEmptyString;

/// 是NSArray吗
- (BOOL)gsy_isArray;

/// 是非空NSArray吗
- (BOOL)gsy_isNotEmptyArray;

/// 是NSDictionary吗
- (BOOL)gsy_isDictionary;

/// 是非空NSDictionary吗
- (BOOL)gsy_isNotEmptyDictionary;

@end
