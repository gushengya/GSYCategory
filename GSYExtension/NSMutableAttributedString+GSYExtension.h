#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (GSYExtension)


#pragma mark- <-----------  富文本字符串垂直居中  ----------->
/**
 *  富文本水平排列情况下, 将文字由默认的底部对齐方式更改为居中对齐
 *  当设置了lineBreakMode的时候该方法有可能失效,NSMutableAttributedString设置属性时最好按照先整体设置setAttributes:  然后对个别字符通过addAttribute: 方法进行设置， 否则可能失效
 *  @param maxWidth 需要明确知道该富文本在控件中的size的最大宽度
 *
 *  @return 转变后的居中对齐富文本
 */
- (NSMutableAttributedString *)gsy_setTextAlignmentFromBottomToCenterWithMaxWidth:(CGFloat)maxWidth;

/// 根据限制尺寸得到富文本真正的尺寸
/// 当设置了lineBreakMode的时候该方法有可能失效,NSMutableAttributedString设置属性时最好按照先整体设置setAttributes:  然后对个别字符通过addAttribute: 方法进行设置， 否则可能失效
/// @param maxSize 限制尺寸
/// @param numberOfLines 富文本最大行数
- (CGSize)gsy_textSizeWithMaxSize:(CGSize)maxSize numberOfLines:(NSUInteger)numberOfLines;

/// 拼接可变富文本字符串
/// @param string 被拼接的字符串
/// @param font 该字符串的font
/// @param color 该字符串的color
/// @param lineSpacing 该字符串的行间距
- (NSMutableAttributedString *)gsy_appendString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing;

/// 修改指定字符串(所有)的颜色及字体
/// @param textStr 被修改的字符串
/// @param color 该字符串的颜色
/// @param font 该字符串的字体
- (NSMutableAttributedString *)gsy_modifyString:(NSString *)textStr toColor:(UIColor *)color toFont:(UIFont *)font;

/// 替换富文本字符串中指定字符为其他富文本字符串
/// @param string 查找的字符
/// @param attributedString 替换后的富文本字符
- (NSMutableAttributedString *)gsy_modifyString:(NSString *)string toAttributedString:(NSAttributedString *)attributedString;

/// 富文本拼接图片(废弃掉吧。由于未知的原因导致富文本拼接多个不同尺寸的图片时仍旧显示为相同尺寸，很奇怪。。。)
/// @param image 被拼接的图片
/// @param bounds 图片的尺寸位置
- (NSMutableAttributedString *)gsy_appendImage:(UIImage *)image imageBounds:(CGRect)bounds;

@end
