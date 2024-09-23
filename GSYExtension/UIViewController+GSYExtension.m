#import "UIViewController+GSYExtension.h"

@implementation UIViewController (GSYExtension)

+ (UIViewController*)gsy_topViewController {
    UIWindow *window = (UIWindow *)[UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    return [self gsy_findTopViewControllerByRootViewController:window.rootViewController];
}

+ (UIViewController*)gsy_findTopViewControllerByRootViewController:(UIViewController*)rootViewController {
    UIViewController* tmpTopViewController = nil;
    // 必须将该步判定放在最前方, 因为有时分页控制器直接present一个vc向下走的话就找不到该vc了
    if ([rootViewController presentedViewController]) { // 判断rootvc是否present出vc
        tmpTopViewController = [self gsy_findTopViewControllerByRootViewController:[rootViewController presentedViewController]];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) { // 判断rootvc是否属于导航控制器
        tmpTopViewController = [self gsy_findTopViewControllerByRootViewController:[(UINavigationController*)rootViewController visibleViewController]];
    }
    else if ([rootViewController isKindOfClass:[UITabBarController class]]) { // 判断rootvc是否属于分页控制器
        tmpTopViewController = [self gsy_findTopViewControllerByRootViewController:[(UITabBarController*)rootViewController selectedViewController]];
    }
    else { // 没有下一层vc的时候返回传入的vc
        tmpTopViewController = rootViewController;
    }
    
    return tmpTopViewController;
}


@end
