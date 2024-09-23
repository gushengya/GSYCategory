#import "NSDate+GSYExtension.h"

@implementation NSDate (GSYExtension)

- (BOOL)gsy_isToday {
    NSDate *currentDate = [NSDate date]; // 当前时间
    NSTimeInterval currentTimeInterval = [self timeIntervalSinceDate:currentDate];
    if (fabs(currentTimeInterval) > 60 * 60 * 24) { // 与当前时间差值大于24小时则表示肯定不是一天
        return NO;
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]]; // 设置东八区时区
    NSString *currentTimeString = [formatter stringFromDate:currentDate];
    NSString *selfTimeString = [formatter stringFromDate:self];
    
    return [currentTimeString isEqualToString:selfTimeString];
    // 也许可以用该方式: [[NSCalendar currentCalendar] isDateInToday:self]
}

- (BOOL)gsy_isYesterday {
    NSDate *currentDate = [NSDate date]; // 当前时间
    NSTimeInterval currentTimeInterval = [currentDate timeIntervalSinceDate:self];
    if (currentTimeInterval < 0 || currentTimeInterval > 24 * 60 * 60) { // 与当前时间差值大于24小时则表示肯定不是一天
        return NO;
    }
    
    // 先获取今天0时刻的时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]]; // 设置东八区时区
    NSString *currentTimeString = [formatter stringFromDate:currentDate];
    NSDate *date = [formatter dateFromString:currentTimeString]; // 经过这么一转换, 就变成了今日0时了
    
    NSTimeInterval interval = [date timeIntervalSinceDate:self];
    
    if (interval > 0 && interval < 24 * 60 * 60) {
        return YES;
    }
    
    return NO;
}

-(BOOL)gsy_isThisYear {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]]; // 设置东八区时区
    NSString *currentYear = [formatter stringFromDate:[NSDate date]];
    NSString *unknownYear = [formatter stringFromDate:self];
    
    return [currentYear isEqualToString:unknownYear];
}

- (BOOL)gsy_isThisWeek {
    return [self gsy_isSameWeekWithDate:[NSDate date]];
}

- (BOOL)gsy_isSameWeekWithDate:(NSDate *)date {
    //日期间隔大于七天直接返回NO
    if (fabs([self timeIntervalSinceDate:date]) > 7 * 24 * 60 * 60) {
        return NO;
    }
    
    // 计算两个日期分别为这年第几周
    NSCalendar *calender = [NSCalendar currentCalendar];
    calender.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    // 设置每周开始的第一天是周几    周日=1 周一=2 以此类推周六=7
    calender.firstWeekday = 2;
    NSUInteger firstWeekIndex = [calender ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
    NSUInteger secondWeekIndex = [calender ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:date];
    
    // 相等就在同一周，不相等不在同一周
    return firstWeekIndex == secondWeekIndex;
}

- (NSDate *)gsy_firstDayOfThisMonth {
    // 改成北京时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]]; // 设置东八区时区
    return [formatter dateFromString:[formatter stringFromDate:self]];
}

- (NSString *)gsy_dateStringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]]; // 设置东八区时区
    return [formatter stringFromDate:self];
}

+ (NSDate *)gsy_dateWithDateString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]]; // 设置东八区时区
    return [formatter dateFromString:dateString];
}

- (NSDate *)gsy_appendYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    //获取NSCalender单例
    NSCalendar *calender = [NSCalendar currentCalendar];
    calender.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    
    // 设置属性
    NSDateComponents *components = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    
    components.year += year;
    components.month += month;
    components.day += day;
    components.hour += hour;
    components.minute += minute;
    components.second += second;
    
    // 生成新的日期
    NSDate *newDate = [calender dateFromComponents:components];
    
    return newDate;
}

@end
