#import "NSObject+GSYReplaceMethod.h"
#import <objc/runtime.h>

@implementation NSObject (GSYReplaceMethod)

#pragma mark- 替换类或实例的方法
/// 替换实例的两个方法
+ (void)gsy_replaceInstanceMethod:(SEL)originalSelector toMethod:(SEL)swizzledSelector
{
    // 类名
    Class class = [self class];
    
    // 通过选择子找到对应的IMP
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 将原始方法的选择子与新方法的IMP和属性信息关联起来
    BOOL isSuccess = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    // 成功表示该类中未实现原始方法, 可能是在父类中实现的, 因此可以添加成功
    
    if (isSuccess)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/// 替换类的两个方法
+ (void)gsy_replaceClassMethod:(SEL)originalSelector toMethod:(SEL)swizzledSelector
{
    // 类名
    Class class = object_getClass((id)self);
    
    // 通过选择子找到对应的IMP
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    // 将原始方法的选择子与新方法的IMP和属性信息关联起来
    BOOL isSuccess = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    // 成功表示该类中未实现原始方法, 可能是在父类中实现的, 因此可以添加成功
    
    if (isSuccess)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
