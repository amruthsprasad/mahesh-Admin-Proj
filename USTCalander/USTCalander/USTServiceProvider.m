//
//  USTServiceProvider.m
//  USTCalander
//
//  Created by Amruth on 10/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "USTServiceProvider.h"
#import "Constants.h"
#import "AppDelegate.h"

@implementation USTServiceProvider

+(void)loginWithUserId:(NSString *)userID andPassword:(NSString *)password withCompletionHandler:(requestCompletion)completionBlock{
    NSString * url=[NSString stringWithFormat:@"%@firstlogin.php?username=%@&password=%@&deviceid=",BaseUrl,userID,password];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
    
    
}

@end
