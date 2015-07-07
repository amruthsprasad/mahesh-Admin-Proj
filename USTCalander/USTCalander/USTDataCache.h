//
//  USTDataCache.h
//  USTCalander
//
//  Created by Amruth on 08/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface USTDataCache : NSManagedObject

@property (nonatomic, retain) NSString * serviceId;
@property (nonatomic, retain) NSData * jsonData;
@property (nonatomic, retain) NSString * timeStamp;
@property (nonatomic, retain) NSString * serviceType;

@end
