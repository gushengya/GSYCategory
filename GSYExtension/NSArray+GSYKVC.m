#import "NSArray+GSYKVC.h"

#pragma mark- KVC方式获取关联值
@implementation NSArray (GSYKVC)

- (NSNumber *)gsy_maxValue {
    if (![self isKindOfClass:NSArray.class] || self.count <= 0) return nil;
    
    NSNumber *tmpNum = [self valueForKeyPath:@"@max.doubleValue"];
    if (![tmpNum isKindOfClass:NSNumber.class]) {
        return nil;
    }
    
    return tmpNum;
}

- (NSNumber *)gsy_minValue {
    if (![self isKindOfClass:NSArray.class] || self.count <= 0) return nil;
    
    NSNumber *tmpNum = [self valueForKeyPath:@"@min.doubleValue"];
    if (![tmpNum isKindOfClass:NSNumber.class]) {
        return nil;
    }
    
    return tmpNum;
}

- (NSNumber *)gsy_avgValue {
    if (![self isKindOfClass:NSArray.class] || self.count <= 0) return nil;
    
    NSNumber *tmpNum = [self valueForKeyPath:@"@avg.doubleValue"];
    if (![tmpNum isKindOfClass:NSNumber.class]) {
        return nil;
    }
    
    return tmpNum;
}

- (NSNumber *)gsy_sumValue {
    if (![self isKindOfClass:NSArray.class] || self.count <= 0) return nil;
    
    NSNumber *tmpNum = [self valueForKeyPath:@"@sum.doubleValue"];
    if (![tmpNum isKindOfClass:NSNumber.class]) {
        return nil;
    }
    
    return tmpNum;
}

- (NSArray *)gsy_mergeSubArraysUnorderly {
    NSMutableArray *tmp = [NSMutableArray array];
    for (id subItem in self) {
        if ([subItem isKindOfClass:NSArray.class]) {
            [tmp addObjectsFromArray:((NSArray *)subItem).gsy_mergeSubArraysUnorderly];
            
            continue;
        }
        
        if ([subItem isKindOfClass:NSDictionary.class]) {
            continue;
        }
        
        if ([subItem isKindOfClass:NSSet.class]) {
            continue;
        }
        
        [tmp addObject:subItem];
    }
    
    return tmp;
}

- (NSArray *)gsy_mergeSubArraysAscending
{
    return [self.gsy_mergeSubArraysUnorderly sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        if (![obj1 isKindOfClass:NSNumber.class] || ![obj2 isKindOfClass:NSNumber.class]) {
            return NSOrderedSame;
        }
        
        if (obj1.doubleValue > obj2.doubleValue) {
            return NSOrderedDescending;
        }else {
            return NSOrderedAscending;
        }
    }];
}

- (NSArray *)gsy_mergeSubArraysDescending
{
    return [self.gsy_mergeSubArraysUnorderly sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        if (![obj1 isKindOfClass:NSNumber.class] || ![obj2 isKindOfClass:NSNumber.class]) {
            return NSOrderedSame;
        }
        
        if (obj1.doubleValue > obj2.doubleValue) {
            return NSOrderedAscending;
        }else {
            return NSOrderedDescending;
        }
    }];
}

- (NSArray *)gsy_mergeSubArraysNoRepeatAndUnorderly {
    NSArray *tmpArray = nil;
    @try {
        tmpArray = [self.gsy_mergeSubArraysUnorderly valueForKeyPath:@"@distinctUnionOfObjects.self"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    return tmpArray;
}

@end
