//
//  USTUser.m
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "USTUser.h"
#import "KeychainItemWrapper.h"
#import "USTDataCacheHandler.h"
#import "Constants.h"

NSString * const kSecIdentifier = @"USTUserCredentials";

@implementation USTUser

+(id)sharedInstance{
    static USTUser *sharedValue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedValue = [[self alloc]init];
    });
    return sharedValue;
}

-(void)setCredentialsToKeychain{
    [self clearCredentialsFromKeychain];
    KeychainItemWrapper *keyChainWrapper = [[KeychainItemWrapper alloc]initWithIdentifier:kSecIdentifier accessGroup:nil];
    [keyChainWrapper setObject:self.userID forKey:(__bridge id)kSecAttrAccount];
    [keyChainWrapper setObject:self.userPassword forKey:(__bridge id)kSecValueData];
    NSData *sessonData = [self.userSessionID dataUsingEncoding:NSUTF8StringEncoding];
    if (sessonData) {
        [USTDataCacheHandler cacheData:sessonData forServiceId:k_AppSessionID andPageID:@""];
    }
    else
    {
        NSLog(@"User session is nil");
    }

}

-(void)loadCredentialsFromKeychain{
    KeychainItemWrapper *keyChainWrapper = [[KeychainItemWrapper alloc]initWithIdentifier:kSecIdentifier accessGroup:nil];
    self.userID = [keyChainWrapper objectForKey:(__bridge id)kSecAttrAccount];
    self.userPassword = [keyChainWrapper objectForKey:(__bridge id)kSecValueData];
    NSData *sessionData = [USTDataCacheHandler getDataforServiceId:k_AppSessionID andPageID:@""];
    if (sessionData) {
        self.userSessionID=[[NSString alloc]initWithData:sessionData encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSLog(@"User session data returned nil");
    }
    
}

-(void)clearCredentialsFromKeychain{
    KeychainItemWrapper *keyChainWrapper = [[KeychainItemWrapper alloc]initWithIdentifier:kSecIdentifier accessGroup:nil];
    [keyChainWrapper resetKeychainItem];
}

-(void)logOut{
    [self clearCredentialsFromKeychain];
    self.userSessionID=nil;
}


@end
