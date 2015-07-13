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
#import "USTUser.h"
#import "USTDataCacheHandler.h"

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


+(void)getActivityFeed:(NSNumber *)count andPage:(NSNumber *)page withCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=getallactivity&stat=1&userid=%@&eventid=%@&counter=%@",BaseUrl,user.userID,user.userEventID,page];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_ActivityListServiceID andPageID:[NSString stringWithFormat:@"%@",page]];
        }
        else if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
          request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_ActivityListServiceID andPageID:[NSString stringWithFormat:@"%@",page]]];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];

}


+(void)getAgendawithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=agenda&userid=%@&eventid=%@",BaseUrl,user.userID,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_AgendaListServiceID andPageID:[NSString stringWithFormat:@"%@",@""]];
        }
        else if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_AgendaListServiceID andPageID:[NSString stringWithFormat:@"%@",@""]]];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}
@end
