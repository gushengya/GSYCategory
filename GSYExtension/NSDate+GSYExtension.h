#import <Foundation/Foundation.h>

@interface NSDate (GSYExtension)

/// 该日期是否为今天
- (BOOL)gsy_isToday;

/// 该日期是否为昨天
- (BOOL)gsy_isYesterday;

/// 该日期是否在本年内(阳历)
- (BOOL)gsy_isThisYear;

/// 判断该日期是否是本周
- (BOOL)gsy_isThisWeek;

/// 判断两个日期是否在同一周
/// - Parameter date: 对比的另外一个日期
- (BOOL)gsy_isSameWeekWithDate:(NSDate *)date;

/// 获取该日期当月的第一天(默认返回当月第一天的00:00时间)
- (NSDate *)gsy_firstDayOfThisMonth;

/// 返回该日期经过格式化后的时间字符串
/// - Parameter formatterString: 格式化字符串
- (NSString *)gsy_dateStringWithFormat:(NSString *)formatterString;

/// 根据传入的格式化的时间字符串以及格式化方式返回一个NSDate对象
/// - Parameters:
///   - dateString: 格式化后的时间
///   - formatterString: 格式化方式
+ (NSDate *)gsy_dateWithDateString:(NSString *)dateString format:(NSString *)formatterString;

/// 在原有日期基础上拼接年月日时分秒
/// - Parameters:
///   - year: 年
///   - month: 月
///   - day: 日
///   - hour: 时
///   - minute: 分
///   - second: 秒
- (NSDate *)gsy_appendYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

@end
