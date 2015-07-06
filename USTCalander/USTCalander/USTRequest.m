//
//  USTRequest.m
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "USTRequest.h"
#import <UIKit/UIKit.h>
#define TIME_OUT_INTERVAL 45

@interface USTRequest () <NSURLSessionDelegate>{
    
}

@property (nonatomic) NSUInteger sessionFailureCount;
@property (nonatomic, copy) requestCompletion completionBlock;
@property (nonatomic, assign) SEL currentRequestMethod;
@property (nonatomic, strong) NSDictionary *currentPostParameters;

@end

@implementation USTRequest

- (instancetype)initWithUrl:(NSString *)urlString
{
    self = [super init];
    if (self) {
        self.isDataFromCache = NO;
        self.url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        _sessionFailureCount = 0;
        self.isRetry = NO;
        
    }
    return self;
}

- (void)makeGETNetworkRequestWithCompletionHandler:(requestCompletion)completionBlock{
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = TIME_OUT_INTERVAL;
    [request setURL:_url];
    NSLog(@"ServiceURL:%@",_url);
    request.HTTPMethod = @"GET";
    
    if (/* DISABLES CODE check network rechability here amruth*/ (0)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(self);
            
        });
        return;
    }
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    self.responseData = [NSMutableData dataWithData:data];
                    NSError *errorInJSON = nil;
                    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:kNilOptions
                                                                           error:&errorInJSON];
                    self.responseDict = json;
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                    self.statusCode = httpResponse.statusCode;
                    self.errorResponse = error;
                    self.errorJSON = errorInJSON;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionBlock(self);
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        
                    });
                    
                }] resume];
}

//NSURLSession API not working properly in Cognizant proxy, NSURLConnection API is used for POST for the time being.
- (void)makePOSTNetworkRequestWithParameters:(NSDictionary *)parameters completionHandler:(requestCompletion)completionBlock{
    
    
    
    self.responseData = [NSMutableData data];
    self.completionBlock = completionBlock;
    self.currentRequestMethod = @selector(makeGETNetworkRequestWithCompletionHandler:);
    self.currentPostParameters = parameters;
    
    NSError * err;
    NSData * jsonInputData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&err];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = TIME_OUT_INTERVAL;
    [request setURL:_url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonInputData];
    
    if (/* DISABLES CODE */ (0)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionBlock(self);
        });
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection){
        NSLog(@"Connected");
    }
    else{
        NSLog(@"Connection NIL");
        
    }
}

- (void)retryPost{
    NSLog(@"Retrying POST Method...");
    self.isRetry = YES;
    [self makePOSTNetworkRequestWithParameters:self.currentPostParameters completionHandler:self.completionBlock];
    
}

/*
 - (void)makePOSTNetworkRequestWithParameters:(NSDictionary *)parameters completionHandler:(requestCompletion)completionBlock{
     
 
     NSError * err;
     NSData * jsonInputData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&err];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:_url];
     [request setHTTPMethod:@"POST"];
     [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     [request setHTTPBody:jsonInputData];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
     [[session dataTaskWithRequest:request
                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                     self.responseData = data;
                     NSError *errorInJSON = nil;
                     NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&errorInJSON];
                     self.responseDict = json;
                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                     self.statusCode = httpResponse.statusCode;
                     self.errorResponse = error;
                     self.errorJSON = errorInJSON;
                     completionBlock(self);
                     
                 }] resume];
    
 
 }
 */

#pragma mark - NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    self.statusCode = [httpResponse statusCode];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [self.responseData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.errorResponse = error;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.completionBlock(self);
        
    });
    //self.isRetry = NO;
}

- (BOOL)connection:(NSURLConnection *)connection
canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    return YES;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSError *errorInJSON = nil;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                         options:kNilOptions
                                                           error:&errorInJSON];
    self.responseDict = json;
    self.errorJSON = errorInJSON;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.completionBlock(self);
        
    });
    //self.isRetry = NO;
}




@end
