//
//  USTServiceProvider.h
//  USTCalander
//
//  Created by Amruth on 10/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USTRequest.h"

typedef void(^requestCompletion)(USTRequest *);

@interface USTServiceProvider : NSObject


//********************************
//*Login service
//********************************

+ (void)loginWithUserId:(NSString *)userID andPassword:(NSString *)password withCompletionHandler:(requestCompletion)completionBlock;


@end
