#import "UIView+GSYExtension.h"

@implementation UIView (GSYExtension)

- (UIViewController *)gsy_viewController {
    // 取出当前响应者的下一响应者
    id nextResponder = [self nextResponder];
    
    while (nextResponder) {
        // 循环判断下一响应者是否是控制器
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        nextResponder = [nextResponder nextResponder];
    }
    
    return nil;
}

///从子控件中找到指定类型的控件
- (NSArray *)gsy_findSubviewWithClassName:(NSString *)className {
    if (!className || ![className isKindOfClass:NSString.class] || className.length <= 0) {
        NSAssert(NO, @"[UIView+GSYExtension]--className参数有问题");
        return nil;
    }
    
    Class tmpClass = NSClassFromString(className);
    if (!tmpClass) {
        NSAssert(NO, @"[UIView+GSYExtension]--className参数有问题");
        return nil;
    }
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (UIView *tmpView in self.subviews) {
        if ([tmpView isKindOfClass:tmpClass]) {
            [tmpArray addObject:tmpView];
        }else {
            [tmpArray addObjectsFromArray:[tmpView gsy_findSubviewWithClassName:className]]; // 当addObjectsFromArray: 参数为nil时不会崩溃
        }
    }
    
    return tmpArray;
}

@end
