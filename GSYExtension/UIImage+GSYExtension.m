#import "UIImage+GSYExtension.h"

@implementation UIImage (GSYExtension)

- (NSUInteger)gsy_imageUseMemorySize {
    if (![self isKindOfClass:UIImage.class]) {
        return 0;
    }
    
    return CGImageGetHeight(self.CGImage) * CGImageGetBytesPerRow(self.CGImage);
}

+ (UIImage *)gsy_imageWithColors:(NSArray *)colors size:(CGSize)size locations:(NSArray *)locations horizontal:(BOOL)horizontal {
    if (!colors || ![colors isKindOfClass:NSArray.class] || colors.count == 0) {
        NSAssert(NO, @"[UIImage+GSYExtension]--colors参数有问题");
        return nil;
    }
    
    if (size.width <= 0 || size.height <= 0) {
        NSAssert(NO, @"[UIImage+GSYExtension]--size参数有问题");
        return nil;
    }
    
    if (colors.count == 1) {
        return [self gsy_imageWithColor:colors.firstObject size:size];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    CFMutableArrayRef cfArrayRef =  CFArrayCreateMutable(kCFAllocatorDefault, 0, nil);
    
    for (UIColor *color in colors) {
        if (![color isKindOfClass:UIColor.class]) {
            NSAssert(NO, @"[UIImage+GSYExtension]--colors参数有问题");
            return nil;
        }
        
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        CGColorRef colorRef = CGColorCreate(spaceRef, (CGFloat[]){components[0], components[1], components[2], components[3]});
        CFArrayAppendValue(cfArrayRef, colorRef);
    }
    
    CGGradientRef gradientRef = nil;
    
    do {
        if (!locations) break;
        
        if (![locations isKindOfClass:NSArray.class] || locations.count != colors.count) {
            NSAssert(NO, @"[UIImage+GSYExtension]--locations参数有问题");
            break;
        }
        
        CGFloat tmpLocations[] = {};
        for (int i = 0; i < locations.count; i++) {
            NSNumber *number = locations[i];
            if (!number || ![number isKindOfClass:NSNumber.class]) {
                NSAssert(NO, @"[UIImage+GSYExtension]--locations参数有问题");
                break;
            }
            
            tmpLocations[i] = number.floatValue;
        }
        
        gradientRef = CGGradientCreateWithColors(spaceRef, cfArrayRef, tmpLocations);
    } while (0);
    
    if (!gradientRef) {
        CGFloat locations[] = {};
        CFIndex count = CFArrayGetCount(cfArrayRef);
        CGFloat margin = 1.0 / (count - 1);
        for (int i = 0; i < count; i++) {
            locations[i] = i * margin;
        }
        gradientRef = CGGradientCreateWithColors(spaceRef, cfArrayRef, locations);
    }
    
    if (gradientRef == nil) {
        UIGraphicsEndImageContext();
        return nil;
    }
    
    if (horizontal) {
        CGContextDrawLinearGradient(ref, gradientRef, CGPointMake(0, size.height / 2), CGPointMake(size.width, size.height / 2), kCGGradientDrawsAfterEndLocation);
    }else {
        CGContextDrawLinearGradient(ref, gradientRef, CGPointMake(size.width / 2, 0), CGPointMake(size.width / 2, size.height), kCGGradientDrawsAfterEndLocation);
    }
    
    CGContextSetFillColorSpace(ref, spaceRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CFRelease(cfArrayRef);
    CGColorSpaceRelease(spaceRef);
    return image;
}

+ (UIImage *)gsy_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || ![color isKindOfClass:UIColor.class]) {
        NSAssert(NO, @"[UIImage+GSYExtension]--color参数有问题");
        return nil;
    }
    
    if (size.width <= 0 || size.height <= 0) {
        NSAssert(NO, @"[UIImage+GSYExtension]--size参数有问题");
        return nil;
    }
    
    // 设置画布的大小
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 开启上下文
    UIGraphicsBeginImageContext(rect.size);

    // 获得当前上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 设置填充色
    CGContextSetFillColorWithColor(ref, color.CGColor);
    
    // 设置填充rect
    CGContextFillRect(ref, rect);
    
    // 从上下文获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    // 关闭上下文
    UIGraphicsEndImageContext();
    
    // 返回获得的图片
    return image;
}

- (UIImage *)gsy_convertImageToSize:(CGSize)size rectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius {
    if (![self isKindOfClass:UIImage.class]) {
        NSAssert(NO, @"[UIImage+GSYExtension]--image参数有问题");
        return nil;
    }
    
    if (self.size.width <= 0 || self.size.height <= 0) {
        NSAssert(NO, @"[UIImage+GSYExtension]--image参数有问题");
        return nil;
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillPath(context);
    CGContextMoveToPoint(context, cornerRadius, 0);
    
    if (rectCorner == UIRectCornerAllCorners || (rectCorner & UIRectCornerTopLeft)) {
        CGContextAddArc(context, cornerRadius, cornerRadius, cornerRadius, -M_PI_2, M_PI, 1);
    }else {
        CGContextAddLineToPoint(context, 0, 0);
    }
    
    CGContextAddLineToPoint(context, 0, size.height - cornerRadius);
    
    if (rectCorner == UIRectCornerAllCorners || (rectCorner & UIRectCornerBottomLeft)) {
        CGContextAddArc(context, cornerRadius, size.height - cornerRadius, cornerRadius, M_PI, M_PI_2, 1);
    }else {
        CGContextAddLineToPoint(context, 0, size.height);
    }
    
    CGContextAddLineToPoint(context, size.width - cornerRadius, size.height);
    
    if (rectCorner == UIRectCornerAllCorners || (rectCorner & UIRectCornerBottomRight)) {
        CGContextAddArc(context, size.width - cornerRadius, size.height - cornerRadius, cornerRadius, M_PI_2, 0, 1);
    }else {
        CGContextAddLineToPoint(context, size.width, size.height);
    }
    
    CGContextAddLineToPoint(context, size.width, cornerRadius);
    
    if (rectCorner == UIRectCornerAllCorners || (rectCorner & UIRectCornerTopRight)) {
        CGContextAddArc(context, size.width - cornerRadius, cornerRadius, cornerRadius, 0, -M_PI_2, 1);
    }else {
        CGContextAddLineToPoint(context, size.width, 0);
    }
    
    CGContextAddLineToPoint(context, cornerRadius, 0);
    
    CGContextClosePath(context);
    CGContextClip(context);
    [self drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (UIImage *)gsy_convertImageToSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    return [self gsy_convertImageToSize:size rectCorner:UIRectCornerAllCorners cornerRadius:cornerRadius];
}


+ (UIImage *)gsy_imageWithColor:(UIColor *)color {
    return [self gsy_imageWithColor:color size:CGSizeMake(1, 1)];
}


- (UIColor *)gsy_imageColorAtPoint:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.f, 0.f, self.size.width, self.size.height), point)) {
        NSAssert(NO, @"[UIImage+GSYExtension]--point参数有问题");
        return nil;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    
    CGContextRef context = CGBitmapContextCreate(pixelData, 
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -point.x, point.y - self.size.height);
    CGContextDrawImage(context, CGRectMake(0.f, 0.f, self.size.width, self.size.height), self.CGImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIImage *)gsy_launchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    
    if (!launchImageName || ![launchImageName isKindOfClass:NSString.class]) {
        return nil;
    }
    
    return [UIImage imageNamed:launchImageName];
}


- (UIImage *)gsy_covertImageToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor {
    if (size.width <= 0 || size.height <= 0) {
        NSAssert(NO, @"[UIImage+GSYExtension]--size参数有问题");
        return self;
    }
    
    // 开启上下文（参数：1、画布尺寸；2、YES透明(黑色)NO不透明(白色)；3、缩放，0表示不缩放）
    UIGraphicsBeginImageContextWithOptions(size, YES, UIScreen.mainScreen.scale);
    
    if (!backgroundColor || ![backgroundColor isKindOfClass:UIColor.class]) {
        backgroundColor = [UIColor clearColor];
    }
    
    // 设置背景色
    [backgroundColor setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    switch (contentMode) {
        case UIViewContentModeScaleToFill: // 非等比例, 平铺到size范围
            {
                [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
            }
            break;
        case UIViewContentModeScaleAspectFit: // 等比例, 缩放到宽高皆在size内且居中
            {
                CGFloat scaleW = self.size.width / size.width;
                CGFloat scaleH = self.size.height / size.height;
                if (scaleW >= scaleH) { // 表示原图更宽
                    [self drawInRect:CGRectMake(0, (size.height - self.size.height / scaleW) / 2, size.width, self.size.height / scaleW)];
                }else {
                    [self drawInRect:CGRectMake((size.width - self.size.width / scaleH) / 2, 0, self.size.width / scaleH, size.height)];
                }
            }
            break;
        case UIViewContentModeScaleAspectFill: // 等比例, 缩放到铺满size多出部分裁剪
            {
                CGFloat scaleW = self.size.width / size.width;
                CGFloat scaleH = self.size.height / size.height;
                if (scaleW >= scaleH) { // 表示原图更宽
                    [self drawInRect:CGRectMake((size.width - self.size.width / scaleH) / 2, 0, self.size.width / scaleH, size.height)];
                }else {
                    [self drawInRect:CGRectMake(0, (size.height - self.size.height / scaleW) / 2, size.width, self.size.height / scaleW)];
                }
            }
            break;
        case UIViewContentModeCenter: // 不缩放, 原图大小直接居中, 多出部分裁剪
            {
                [self drawInRect:CGRectMake((size.width - self.size.width) / 2, (size.height - self.size.height) / 2, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeTop: // 不缩放, 原图大小居中居上, 多出部分裁剪
            {
                [self drawInRect:CGRectMake((size.width - self.size.width) / 2, 0, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeBottom: // 不缩放, 原图大小居中局下, 多出部分裁剪
            {
                [self drawInRect:CGRectMake((size.width - self.size.width) / 2, size.height - self.size.height, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeLeft: // 不缩放, 原图大小居中局左, 多出部分裁剪
            {
                [self drawInRect:CGRectMake(0, (size.height - self.size.height) / 2, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeRight: // 不缩放, 原图大小居中局右, 多出部分裁剪
            {
                [self drawInRect:CGRectMake(size.width - self.size.width, (size.height - self.size.height) / 2, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeTopLeft: // 不缩放, 原图大小居上局左, 多出部分裁剪
            {
                [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeTopRight: // 不缩放, 原图大小居上局右, 多出部分裁剪
            {
                [self drawInRect:CGRectMake(size.width - self.size.width, 0, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeBottomLeft: // 不缩放, 原图大小居下局左, 多出部分裁剪
            {
                [self drawInRect:CGRectMake(0, size.height - self.size.height, self.size.width, self.size.height)];
            }
            break;
        case UIViewContentModeBottomRight: // 不缩放, 原图大小居下局右, 多出部分裁剪
            {
                [self drawInRect:CGRectMake(size.width - self.size.width, size.height - self.size.height, self.size.width, self.size.height)];
            }
            break;
            
        default:
        {
            UIGraphicsEndImageContext();
            return self;
        }
            break;
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)gsy_imageFromView:(UIView *)targetView {
    if (!targetView || ![targetView isKindOfClass:UIView.class]) {
        return nil;
    }
    
    // 第二个参数为YES表示生成图片背景为黑色, 为NO表示生成图片背景为白色
    UIGraphicsBeginImageContextWithOptions(targetView.frame.size, NO, [UIScreen mainScreen].scale);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
