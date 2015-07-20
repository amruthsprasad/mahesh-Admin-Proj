//
//  USTDataCacheHandler.m
//  USTCalander
//
//  Created by Amruth on 08/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "USTDataCacheHandler.h"
#import "AppDelegate.h"


#define CACHE_ENTITY_NAME @"USTDataCache"

@interface USTDataCacheHandler ()
+(BOOL)saveContext;
+(USTDataCache *)getDataModalForServiceId:(NSString *)serviceId andPageId:(NSString *)pageID;

@end

@implementation USTDataCacheHandler

+(NSData *)getDataforServiceId:(NSString *)serviceID andPageID:(NSString *)pageID
{
    USTDataCache *dataRetreived = [self getDataModalForServiceId:serviceID andPageId:pageID];
    if (dataRetreived)
    {
        return dataRetreived.jsonData;
    }
    return nil;
}

+(BOOL)cacheData:(NSData *)jsonData forServiceId:(NSString *)serviceID andPageID:(NSString *)pageID
{
    USTDataCache *existingData = [self getDataModalForServiceId:serviceID andPageId:pageID];
    if (existingData) {
        existingData.jsonData = jsonData;
        existingData.serviceId = serviceID;
        existingData.pageId = pageID;
    }
    else{
        USTDataCache * cache = [NSEntityDescription insertNewObjectForEntityForName:CACHE_ENTITY_NAME inManagedObjectContext:[self getContext]];
        cache.jsonData = jsonData;
        cache.serviceId = serviceID;
        cache.pageId =pageID;
    }
    
    return [self saveContext];
}

+(NSArray *)getAllCacheData{
    NSError * error = nil;
    NSEntityDescription *entity = [NSEntityDescription entityForName:CACHE_ENTITY_NAME inManagedObjectContext:[self getContext]];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    NSArray * fetchedObjects = [[self getContext] executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

+(NSManagedObjectContext *)getContext
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

+(BOOL)saveContext{
    NSError *error = nil;
    if (![[self getContext] save:&error]) {
        return NO;
    }
    return YES;
}

+(BOOL)clearCache{
    
    NSArray *cacheArray = [self getAllCacheData];
    for (USTDataCache * cache in cacheArray) {
        [[self getContext] deleteObject:cache];
    }
    
    return [self saveContext];
    
}

+(USTDataCache *)getDataModalForServiceId:(NSString *)serviceId andPageId:(NSString *)pageID
{
    @try {
        NSArray *cacheArray = [self getAllCacheData];
        for (USTDataCache * cache in cacheArray) {
            if ([cache.serviceId isEqualToString:serviceId] && [cache.pageId isEqualToString:pageID]) {
                return cache;
            }
        }
        return nil;
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    
}


+(NSUInteger)totalNumberOfCacheRecords
{
    return [[self getAllCacheData] count];
}
@end
