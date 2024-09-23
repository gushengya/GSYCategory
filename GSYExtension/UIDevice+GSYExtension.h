#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (GSYExtension)

#pragma mark - 类属性
/// app的版本号
@property (nonatomic, copy, readonly, class) NSString *gsy_appVersion;

/// 设备的名称
@property (nonatomic, copy, readonly, class) NSString *gsy_deviceModel;

/// 系统版本号
@property (nonatomic, copy, readonly, class) NSString *gsy_systemVersion;

/// 设备用户名
@property (nonatomic, copy, readonly, class) NSString *gsy_deviceUserName;

/// app bundleID
@property (nonatomic, copy, readonly, class) NSString *gsy_bundleId;

/// 系统名称
@property (nonatomic, copy, readonly, class) NSString *gsy_systemName;

/// uuid
@property (nonatomic, copy, readonly, class) NSString *gsy_uuid;

#pragma mark - classMethod

/// 安全区上侧高度，即状态栏所在的部分高度，即不加上导航条44高度的部分
+ (CGFloat)gsy_safeAreaTopHeight;

/// 安全区下侧高度，即底部不加上49高度的tabbar部分
+ (CGFloat)gsy_safeAreaBottomHeight;

/// 防止手机屏幕自动锁屏  YES禁止锁屏   NO自动锁屏
+ (void)gsy_forbidAutoLockedScreen:(BOOL)forbid;

/// 替换状态栏背景色
/// - Parameter color: 想要换成的颜色
+ (void)gsy_replaceStatusBarBackgroundColorToColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
