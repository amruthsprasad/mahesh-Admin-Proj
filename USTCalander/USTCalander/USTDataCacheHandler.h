//
//  USTDataCacheHandler.h
//  USTCalander
//
//  Created by Amruth on 08/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USTDataCache.h"

@interface USTDataCacheHandler : NSObject

+(BOOL)cacheData:(NSData *)jsonData forServiceId:(NSString *)serviceID andPageID:(NSString *)pageID;
+(NSData *)getDataforServiceId:(NSString *)serviceID andPageID:(NSString *)pageID;
+(BOOL)clearCache;
+(NSUInteger)totalNumberOfCacheRecords;

@end
