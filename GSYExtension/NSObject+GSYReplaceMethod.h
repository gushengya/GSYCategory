#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GSYReplaceMethod)

#pragma mark- 替换类或实例的方法
/// 替换实例的两个方法
+ (void)gsy_replaceInstanceMethod:(SEL)originalSelector toMethod:(SEL)swizzledSelector;

/// 替换类的两个方法
+ (void)gsy_replaceClassMethod:(SEL)originalSelector toMethod:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
