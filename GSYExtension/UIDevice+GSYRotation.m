//
//  UIDevice+GSYRotation.m
//  TestApp
//
//  Created by 谷胜亚 on 2024/9/20.
//  Copyright © 2024 gushengya. All rights reserved.
//

#import "UIDevice+GSYRotation.h"

@implementation UIDevice (GSYRotation)

static UIInterfaceOrientation _gsy_orientation = UIInterfaceOrientationPortrait;

+ (UIInterfaceOrientation)gsy_orientation
{
    return _gsy_orientation;
}

/// 强制转屏为横屏(右转向横屏)
+ (void)gsy_switchToOrientationLandscapeRight
{
    [self gsy_switchToOrientation:UIInterfaceOrientationLandscapeRight];
}

/// 强制转屏为竖屏
+ (void)gsy_switchToOrientationPortrait
{
    [self gsy_switchToOrientation:UIInterfaceOrientationPortrait];
}

+ (void)gsy_switchToOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    _gsy_orientation = interfaceOrientation;
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt:(int)interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

+ (UIInterfaceOrientationMask)gsy_orientationMaskOfCurrentOrientation
{
    if (self.gsy_orientation == UIInterfaceOrientationPortrait) return UIInterfaceOrientationMaskPortrait;
    if (self.gsy_orientation == UIInterfaceOrientationLandscapeLeft) return UIInterfaceOrientationMaskLandscapeLeft;
    if (self.gsy_orientation == UIInterfaceOrientationPortraitUpsideDown) return UIInterfaceOrientationMaskPortraitUpsideDown;
    if (self.gsy_orientation == UIInterfaceOrientationLandscapeRight) return UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskPortrait;
}

@end
