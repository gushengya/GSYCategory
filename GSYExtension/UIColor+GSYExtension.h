#import <UIKit/UIKit.h>

@interface UIColor (GSYExtension)

/// 红色值  区间0~1
@property (nonatomic, assign, readonly) CGFloat gsy_redValue;

/// 绿色值  区间0~1
@property (nonatomic, assign, readonly) CGFloat gsy_greenValue;

/// 蓝色值  区间0~1
@property (nonatomic, assign, readonly) CGFloat gsy_blueValue;

/// 透明度值  区间0~1
@property (nonatomic, assign, readonly) CGFloat gsy_alphaValue;

/// 转为16进制色值字符串  例: 0x123456ff
@property (nonatomic, copy, readonly) NSString *gsy_hexString;

/// 16进制色值生成UIColor实例(默认透明度ff)
/// - Parameter hexNumber: 16进制值   例: 0x123456
+ (UIColor *)gsy_colorWithRGBHexNumber:(NSUInteger)hexNumber;

/// 16进制色值生成UIColor实例
/// - Parameter hexNumber: 16进制值   例: 0x123456ff
+ (UIColor *)gsy_colorWithRGBAHexNumber:(NSUInteger)hexNumber;

/// 16进制字符串生成UIColor实例(默认透明度ff)
/// - Parameter hexString: 16进制字符串   例：0x123456  或  #123456
+ (UIColor *)gsy_colorWithRGBHexString:(NSString *)hexString;

/// 16进制字符串生成UIColor实例
/// - Parameter hexString: 16进制字符串   例：0x123456ff  或  #123456ff
+ (UIColor *)gsy_colorWithRGBAHexString:(NSString *)hexString;

/// 随机色 (透明度固定为1)
+ (UIColor *)gsy_colorWithRandomRGB;

/// 随机色
+ (UIColor *)gsy_colorWithRandomRGBA;


@end
