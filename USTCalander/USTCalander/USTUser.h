//
//  USTUser.h
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USTUser : NSObject

@property(nonatomic,strong) NSString * userID;
@property(nonatomic,strong) NSString * userPassword;
@property(nonatomic,strong) NSString * userFirstName;
@property(nonatomic,strong) NSString * userLastName;
@property(nonatomic,strong) NSString * userSessionID;


+ (id)sharedInstance;
-(void)setCredentialsToKeychain;
-(void)loadCredentialsFromKeychain;
-(void)clearCredentialsFromKeychain;
-(void)logOut;

@end
