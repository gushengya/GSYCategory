#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GSYExtension)

/// 最上层显示的页面
+ (UIViewController*)gsy_topViewController;

@end

NS_ASSUME_NONNULL_END
