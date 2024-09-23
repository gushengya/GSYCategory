#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *tmpLabel;

@property (nonatomic, strong) UIImageView *imgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self initUI];
    
    // 数组
    NSArray *tmpArr = @[@1.22, @3.3, @222, @29];
    NSLog(@"%@, %@, %@, %@", tmpArr.gsy_maxValue, tmpArr.gsy_minValue, tmpArr.gsy_avgValue, tmpArr.gsy_sumValue);
    
    NSArray *tmpArr1 = @[@14, @0.2, @3];
    NSArray *tmpArr2 = @[@2.31, @54, @1.6];
    NSArray *tmpArr3 = @[@5.7, @7.1, @92];
    NSArray *tmpArr4 = @[tmpArr1, tmpArr2, tmpArr3];
    
    NSArray *tmpArr5 = @[@112, @21, @2.31];
    NSArray *tmpArr6 = @[@0.41, @50.1, @6.1];
    NSArray *tmpArr7 = @[@7.1, @81, @5.7];
    NSArray *tmpArr8 = @[tmpArr5, tmpArr6, tmpArr7];
    
    NSArray *tmpArr9 = @[tmpArr4, tmpArr8];
    NSLog(@"升序: %@", tmpArr9.gsy_mergeSubArraysAscending);
    NSLog(@"无序: %@", tmpArr9.gsy_mergeSubArraysUnorderly);
    NSLog(@"降序: %@", tmpArr9.gsy_mergeSubArraysDescending);
    NSLog(@"去重且无序: %@", tmpArr9.gsy_mergeSubArraysNoRepeatAndUnorderly);
    
    
    
    
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"这是一个测试文案看看效果有多么炸裂"];
    NSMutableParagraphStyle *tmpStyle = [[NSMutableParagraphStyle alloc] init];
//    tmpStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    tmpStyle.lineSpacing = 15;
    
    [att setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:26],
                         NSForegroundColorAttributeName: [UIColor colorWithRed:(arc4random() % 256) / 255.0 green:(arc4random() % 256) / 255.0 blue:(arc4random() % 256) / 255.0 alpha:1],
                         NSBackgroundColorAttributeName: UIColor.redColor,
                         NSParagraphStyleAttributeName: tmpStyle
                       } range:NSMakeRange(0, att.length)];
    
    for (int i = 0; i < att.length; i++) {
        UIColor *color = (i % 2 == 0) ? UIColor.redColor : UIColor.blackColor;
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16 + 4 * i] range:NSMakeRange(i, 1)];
        [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(arc4random() % 256) / 255.0 green:(arc4random() % 256) / 255.0 blue:(arc4random() % 256) / 255.0 alpha:1] range:NSMakeRange(i, 1)];
        [att addAttribute:NSBackgroundColorAttributeName value:color range:NSMakeRange(i, 1)];
    }
    
    
    att = [att gsy_setTextAlignmentFromBottomToCenterWithMaxWidth:[UIScreen mainScreen].bounds.size.width - 40];
    self.tmpLabel.attributedText = att;
    
    CGSize size = [att gsy_textSizeWithMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT) numberOfLines:self.tmpLabel.numberOfLines];
    NSLog(@"[size]%@", NSStringFromCGSize(size));
    
    UIColor *tmpColor = [UIColor gsy_colorWithRGBHexNumber:0xf3f5d7];
    tmpColor = [UIColor gsy_colorWithRGBAHexNumber:0xf3f5d732];
    tmpColor = [UIColor gsy_colorWithRGBHexString:@"0xf3f5d732"];
    tmpColor = [UIColor gsy_colorWithRGBAHexString:@"0xf3f5d732"];
    tmpColor = [UIColor gsy_colorWithRandomRGB];
    tmpColor = [UIColor gsy_colorWithRandomRGBA];
    NSLog(@"[颜色16进制字符串]%@, r: %f, g: %f, b: %f, a: %f", [tmpColor gsy_hexString], tmpColor.gsy_redValue, tmpColor.gsy_greenValue, tmpColor.gsy_blueValue, tmpColor.gsy_alphaValue);
    
//    [self after5SecondRotationScreen];
    
    NSLog(@"\nuuid: %@\nbundleID: %@\nappVersion: %@\nsystemName: %@\ndeviceModel: %@\nsystemVersion: %@\ndeviceUserName: %@\nsafeAreaTop: %f\nsafeAreaBottom: %f", UIDevice.gsy_uuid, UIDevice.gsy_bundleId, UIDevice.gsy_appVersion, UIDevice.gsy_systemName, UIDevice.gsy_deviceModel, UIDevice.gsy_systemVersion, UIDevice.gsy_deviceUserName, UIDevice.gsy_safeAreaTopHeight, UIDevice.gsy_safeAreaBottomHeight);
    
    
    [tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"[tmpArr]--[%@]", obj);
    }];
    
//    self.imgV.image = [UIImage gsy_imageFromView:self.view];
}

- (void)initUI {
    [self.view addSubview:self.tmpLabel];
    [self.tmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
    
    [self.view addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.tmpLabel.mas_bottom).offset(40);
        make.height.mas_equalTo(300);
    }];
}

static BOOL isLandscapeRight = NO;

- (void)after5SecondRotationScreen {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLandscapeRight) {
            [UIDevice gsy_switchToOrientationLandscapeRight];
        }else {
            [UIDevice gsy_switchToOrientationPortrait];
        }
        isLandscapeRight = !isLandscapeRight;
        [self after5SecondRotationScreen];
    });
}


- (UILabel *)tmpLabel {
    if (!_tmpLabel) {
        _tmpLabel = [[UILabel alloc] init];
        _tmpLabel.textColor = UIColor.blackColor;
        _tmpLabel.font = [UIFont systemFontOfSize:16];
        _tmpLabel.textAlignment = NSTextAlignmentLeft;
        _tmpLabel.numberOfLines = 0;
        _tmpLabel.backgroundColor = UIColor.orangeColor;
    }
    return _tmpLabel;
}

- (UIImageView *)imgV {
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.contentMode = UIViewContentModeScaleToFill;
        _imgV.layer.masksToBounds = YES;
        _imgV.backgroundColor = UIColor.greenColor;
        
        CGSize tmpSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 300);
        UIImage *tmpImage = nil;
//        tmpImage = [UIImage gsy_imageWithColor:[UIColor gsy_colorWithRandomRGB] size:tmpSize];
        tmpImage = [UIImage gsy_imageWithColors:@[[UIColor gsy_colorWithRandomRGB], [UIColor gsy_colorWithRandomRGB], [UIColor gsy_colorWithRandomRGB]] size:tmpSize locations:nil horizontal:NO];
        tmpImage = [tmpImage gsy_convertImageToSize:tmpSize cornerRadius:80];
//        tmpImage = [tmpImage gsy_convertImageToSize:tmpSize rectCorner:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadius:40];
//        NSLog(@"[点颜色]%@--%lu", [tmpImage gsy_imageColorAtPoint:CGPointMake(0, 99)], tmpImage.gsy_imageUseMemorySize);
//        tmpImage = [UIImage gsy_launchImage];
//        tmpImage = [[UIImage imageNamed:@"haizeiwang"] gsy_covertImageToSize:CGSizeMake(300, 300) contentMode:UIViewContentModeScaleAspectFit backgroundColor:nil];
        
        _imgV.image = tmpImage;
    }
    return _imgV;
}

@end
