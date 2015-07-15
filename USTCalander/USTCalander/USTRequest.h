//
//  USTRequest.h
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <Foundation/Foundation.h>

@class USTRequest;

typedef void(^requestCompletion)(USTRequest *);

@interface USTRequest : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSError *errorResponse;
@property (nonatomic, strong) NSError *errorJSON;
@property (nonatomic, strong) NSDictionary *responseDict;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic) NSInteger statusCode;
@property (nonatomic) BOOL isDataFromCache;
@property (nonatomic) BOOL isRetry;

- (instancetype)initWithUrl:(NSString *)urlString;
- (void)makeGETNetworkRequestWithCompletionHandler:(requestCompletion)completionBlock;
- (void)makePOSTNetworkRequestWithParameters:(NSDictionary *)parameters completionHandler:(requestCompletion)completionBlock;
- (void)makeUploadRequestFromFile:(NSData *)imageData WithCompletionHandler:(requestCompletion)completionBlock;
- (void)retryPost;


@end
