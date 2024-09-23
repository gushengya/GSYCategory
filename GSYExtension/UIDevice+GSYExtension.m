#import "UIDevice+GSYExtension.h"

@implementation UIDevice (GSYExtension)

#pragma mark - 类属性
+ (NSString *)gsy_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)gsy_deviceModel {
    return [UIDevice currentDevice].model;
}

+ (NSString *)gsy_systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)gsy_deviceUserName {
    return [UIDevice currentDevice].name;
}

+ (NSString *)gsy_bundleId {
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return bundleId;
}

+ (NSString *)gsy_systemName {
    NSString *systemName = [UIDevice currentDevice].systemName;
    return systemName;
}

+ (NSString *)gsy_uuid {
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString.uppercaseString;
    return uuid;
}

#pragma mark - classMethod
+ (CGFloat)gsy_safeAreaTopHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

+ (CGFloat)gsy_safeAreaBottomHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}

+ (void)gsy_forbidAutoLockedScreen:(BOOL)forbid {
    [UIApplication sharedApplication].idleTimerDisabled = forbid;
}

+ (void)gsy_replaceStatusBarBackgroundColorToColor:(UIColor *)color {
    if (!color || ![color isKindOfClass:UIColor.class]) return;
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

@end
