//
//  USTUser.h
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USTUser : NSObject

@property(nonatomic,strong) NSNumber * userID;
@property(nonatomic,strong) NSString * username;
@property(nonatomic,strong) NSString * userPassword;
@property(nonatomic,strong) NSString * userFirstName;
@property(nonatomic,strong) NSString * userLastName;
@property(nonatomic,strong) NSString * userSessionID;
@property(nonatomic,strong) NSString * userDesignation;
@property(nonatomic,strong) NSString * userEventID;
@property(nonatomic,strong) NSString * userEventWelcomeMessage;
@property(nonatomic,strong) NSString * userLocation;
@property(nonatomic,strong) NSString * userImage;
@property(nonatomic,strong) NSString * userImageStatus;
@property(nonatomic,strong) NSString * userData;

+ (id)sharedInstance;
-(void)setCredentialsToKeychain;
-(void)loadCredentialsFromKeychain;
-(void)clearCredentialsFromKeychain;
-(void)logOut;

@end
