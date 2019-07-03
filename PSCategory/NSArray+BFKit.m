//
//  NSArray+BFKit.m
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 - 2015 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "NSArray+BFKit.h"


@interface NSString (Chinese)

/// 拼音字符串
@property (nonatomic, copy, readonly) NSString *pinyinString;

@end


@implementation NSString (Chinese)

- (NSString *)pinyinString {
    NSAssert([self isKindOfClass:[NSString class]], @"必须是字符串");
    
    if (self == nil) {
        return nil;
    }
    
    NSMutableString *pinyin = [self mutableCopy];
    
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
    
    return pinyin;
}

@end


@implementation NSArray (BFKit)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if([self count] > 0 && [self count] > index)
        return [self objectAtIndex:index];
    else
        return nil;
}

- (NSArray *)reversedArray
{
    return [NSArray reversedArray:self];
}

- (NSString *)arrayToJson
{
    return [NSArray arrayToJson:self];
}

- (NSInteger)superCircle:(NSInteger)index maxSize:(NSInteger)maxSize
{
    if(index < 0)
    {
        index = index % maxSize;
        index += maxSize;
    }
    if(index >= maxSize)
    {
        index = index % maxSize;
    }
    
    return index;
}

- (id)objectAtCircleIndex:(NSInteger)index
{
    return [self objectAtIndex:[self superCircle:index maxSize:self.count]];
}

+ (NSString *)arrayToJson:(NSArray*)array
{
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    if(!error)
    {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    else
        return error.localizedDescription;
}

+ (NSArray *)reversedArray:(NSArray*)array
{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for(id element in enumerator) [arrayTemp addObject:element];
    
    return arrayTemp;
}


- (NSArray *)sortedWithChineseKey:(NSString *)chineseKey {
    
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:self.count];
    
    for (int i = 0; i < self.count; ++i) {
        NSString *chineseString = (chineseKey == nil) ? self[i] : [self[i] valueForKeyPath:chineseKey];
        [tmpArray addObject:@{@"obj": self[i], @"pinyin": chineseString.pinyinString.lowercaseString}];
    }
    
    [tmpArray sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        return [obj1[@"pinyin"] compare:obj2[@"pinyin"]];
    }];
    
    return [tmpArray valueForKey:@"obj"];;
}


- (NSMutableArray *)sortedArray
{
    
    return [NSMutableArray arrayWithArray:[self sortedWithChineseKey:nil]];
}
@end



@implementation NSArray (ModeDics)
+ (NSArray *) lz_modelWithClass:(Class)cls dicsArray:(NSArray*)dics{
    if (!cls || !dics) return nil;
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary *dic in dics) {
        if (![dic isKindOfClass:[NSDictionary class]]) continue;
        NSObject *obj = [[cls alloc]initWithDictionary:dic];
        if (obj) [result addObject:obj];
    }
    return result;
    
}
@end





