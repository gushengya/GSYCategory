#import <Foundation/Foundation.h>

#pragma mark- KVC方式获取关联值
@interface NSArray (GSYKVC)

/// 数组最大值  [arr.gsy_maxValue integerValue]
@property (nonatomic, readonly) NSNumber *gsy_maxValue;

/// 数组最小值  [arr.gsy_minValue integerValue]
@property (nonatomic, readonly) NSNumber *gsy_minValue;

/// 数组平均值  [arr.gsy_avgValue integerValue]
@property (nonatomic, readonly) NSNumber *gsy_avgValue;

/// 数组总和值  [arr.gsy_sumValue integerValue]
@property (nonatomic, readonly) NSNumber *gsy_sumValue;

/// 合并子数组内容结果无序(非NSNumber对象不排列)
- (NSArray *)gsy_mergeSubArraysUnorderly;

/// 合并子数组内容结果升序(非NSNumber对象不排列)
- (NSArray *)gsy_mergeSubArraysAscending;

/// 合并子数组内容结果降序(非NSNumber对象不排列)
- (NSArray *)gsy_mergeSubArraysDescending;

/// 合并子数组内容结果无序且去重
- (NSArray *)gsy_mergeSubArraysNoRepeatAndUnorderly;

@end
