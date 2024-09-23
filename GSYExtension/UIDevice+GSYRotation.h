

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 需配置
 1. AppDelegate.m中
 - (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
 {
     return [UIDevice gsy_orientationMaskOfCurrentOrientation];
 }
 
 2. 调用切换为横竖屏时
 [UIDevice sy_switchToOrientation:UIInterfaceOrientationLandscapeRight];
 或[UIDevice sy_switchToOrientationLandscapeRight];
 或[UIDevice sy_switchToOrientationPortrait];
 */

@interface UIDevice (GSYRotation)

/// 手动强制切换的屏幕方向
@property(nonatomic, assign, class, readonly) UIInterfaceOrientation gsy_orientation;

/// 强制转屏为横屏(画面顺时针旋转90°从竖屏转向横屏)
+ (void)gsy_switchToOrientationLandscapeRight;

/// 强制转屏为竖屏
+ (void)gsy_switchToOrientationPortrait;

/// 强制转屏为指定方向
+ (void)gsy_switchToOrientation:(UIInterfaceOrientation)interfaceOrientation;

/// AppDelegate.m中supportedInterfaceOrientationsForWindow方法中需要实现的方法
+ (UIInterfaceOrientationMask)gsy_orientationMaskOfCurrentOrientation;

@end

NS_ASSUME_NONNULL_END
