#import "NSObject+GSYExtension.h"

@implementation NSObject (GSYExtension)

- (NSString *)gsy_jsonSerialWithWritingPrettyPrinted:(BOOL)isPretty {
    NSError *error;
    NSData *jsonData = nil;
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingOptions) (isPretty ? NSJSONWritingPrettyPrinted : 0) error:&error];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    if (!jsonData) return nil;
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (BOOL)gsy_isString {
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)gsy_isNotEmptyString {
    if (![self gsy_isString]) return NO;
    if (((NSString *)self).length <= 0) return NO;
    
    return YES;
}

- (BOOL)gsy_isArray {
    if ([self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)gsy_isNotEmptyArray {
    if (![self gsy_isArray]) return NO;
    if ([(NSArray *)self count] <= 0) return NO;
    
    return YES;
}

- (BOOL)gsy_isDictionary {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)gsy_isNotEmptyDictionary {
    if (![self gsy_isDictionary]) return NO;
    if ([(NSDictionary *)self allKeys].count <= 0) return NO;
    
    return YES;
}

@end
