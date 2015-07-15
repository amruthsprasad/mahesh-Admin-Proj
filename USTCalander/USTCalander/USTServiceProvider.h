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

//********************************
//*Activity service
//********************************

+ (void)getActivityFeed:(NSNumber *)count andPage:(NSNumber *)page withCompletionHandler:(requestCompletion)completionBlock;

//********************************
//*Agenda service
//********************************

+(void)getAgendawithCompletionHandler:(requestCompletion)completionBlock;

//********************************
//*Speaker List service
//********************************

+(void)getSpeakerListwithCompletionHandler:(requestCompletion)completionBlock;

//********************************
//*Speaker Details service
//********************************

+(void)getSpeakerDetailsWithId:(NSString *)speakerID withCompletionHandler:(requestCompletion)completionBlock;

//********************************
//*LeaderBoard service
//********************************

+(void)getLeaderBoardwithCompletionHandler:(requestCompletion)completionBlock;

//********************************
//*Attendees List service
//********************************

+(void)getAttendeesListWithCompletionHandler:(requestCompletion)completionBlock;

//********************************
//*Add Post service
//********************************

+(void)uploadImage:(NSData *)imageData WithCompletionHandler:(requestCompletion)completionBlock;

@end
