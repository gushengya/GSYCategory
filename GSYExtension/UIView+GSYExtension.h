#import <UIKit/UIKit.h>

@interface UIView (GSYExtension)

/// 持有该view的控制器(可能返回为空)
@property (nonatomic, strong, readonly) UIViewController *gsy_viewController;

///从子控件中找到指定类型的控件
- (NSArray *)gsy_findSubviewWithClassName:(NSString *)className;

@end
