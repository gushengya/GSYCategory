#import <UIKit/UIKit.h>


@interface UIImage (GSYExtension)

/// 图片内存占用大小(单位byte)
@property (nonatomic, assign, readonly) NSUInteger gsy_imageUseMemorySize;

/// 通过传入颜色组、图片尺寸、渐变区组及是否水平方向渐变得到一个渐变色图片
/// - Parameters:
///   - colors: UIColor数组，传入一个UIColor时默认返回单色值图片
///   - size: 图片尺寸
///   - locations: 由NSNumber组成的数组, NSNumber值范围为0~1，且升序，数组数量与colors一直，为nil时自动分区渐变
///   - horizontal: 是否水平方向渐变，YES水平方向渐变，NO竖直方向渐变
+ (UIImage *)gsy_imageWithColors:(NSArray *)colors size:(CGSize)size locations:(NSArray *)locations horizontal:(BOOL)horizontal;

/// 通过传入颜色值及图片尺寸得到一个纯色图片
/// - Parameters:
///   - color: UIColor对象
///   - size: 图片尺寸
+ (UIImage *)gsy_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 将图片转变为指定尺寸，同时可设置转变后的图片的圆角位置及圆角半径
/// - Parameters:
///   - size: 指定尺寸
///   - rectCorner: 圆角位置 （左上、左下、右下、右上、全部位置）
///   - cornerRadius: 圆角半径
- (UIImage *)gsy_convertImageToSize:(CGSize)size rectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius;

/// 将图片转变为指定尺寸，同时可设置转变后的图片的圆角半径（默认全部位置圆角）
/// - Parameters:
///   - size: 指定尺寸
///   - cornerRadius: 圆角半径
- (UIImage *)gsy_convertImageToSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/// 根据颜色获取尺寸为{1, 1}的纯色图片
/// - Parameter color: 传入的颜色
+ (UIImage *)gsy_imageWithColor:(UIColor *)color;

/// 根据图片上给定的某一点获得该像素点的颜色
/// @param point 指定的图片上的一点
- (UIColor *)gsy_imageColorAtPoint:(CGPoint)point;

/// 获得当前已使用的launchImage
+ (UIImage *)gsy_launchImage;

/// 将图片变形为指定尺寸且指定渲染模式, 需传入背景颜色(不传默认白色)
/// - Parameters:
///   - size: 指定尺寸
///   - contentMode: 指定渲染模式
///   - backgroundColor: 背景颜色
- (UIImage *)gsy_covertImageToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor;

/// 通过目标视图生成图片
/// - Parameter targetView: 目标视图
+ (UIImage *)gsy_imageFromView:(UIView *)targetView;
@end
