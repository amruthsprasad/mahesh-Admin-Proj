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

+(void)getEventListwithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=eventlist&user_id==%@",BaseUrl,user.userID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_EventListServiceID andPageID:@""];
        }
        else // ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_EventListServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}

+(void)updateUserEventwithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=changeevent&user_id=%@&event_id=%@",BaseUrl,user.userID,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
        }
        else // ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            
        }
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
        else if (!request.responseDict)
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_ActivityListServiceID andPageID:[NSString stringWithFormat:@"%@",page]]];
            
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];

}


+(void)getAgendaListwithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=agenda&user_id=%@&event_id=%@",BaseUrl,user.userID,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_AgendaListServiceID andPageID:@""];
        }
        else // ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_AgendaListServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)attendingAgendaWithAgendaID:(NSString *)agendaID withCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=addattendagenda&agenda_id=%@&user_id=%@",BaseUrl,agendaID,user.userID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
        }
        else if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
    
}

+(void)getAgendaDetail:(NSString *)agendaID withCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=singleagenda&agenda_id=%@&user_id=%@",BaseUrl,agendaID,user.userID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_AgendaDetailServiceID andPageID:@""];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_AgendaDetailServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
    
}


+(void)getSingleAgendaActivityList:(NSString *)agendaID andPage:(NSNumber *)page withCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=getagendaactivity&agenda_id=%@&stat=1&user_id=%@&user_group=%@&counter=%@",BaseUrl,agendaID,user.userID,user.userGroup,page];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_AgendaActivityListlServiceID andPageID:[NSString stringWithFormat:@"%@",page]];
        }
        else// if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_AgendaActivityListlServiceID andPageID:[NSString stringWithFormat:@"%@",page]]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];

    
}


+(void)getQuestionListWithAgendaID:(NSString *)agendaID withCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=questionlist&user_id=%@&agenda_id=%@",BaseUrl,user.userID,agendaID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_QuestionListServiceID andPageID:@""];
        }
        else // ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_QuestionListServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
    
}

+(void)getQuestionDetailWithQuestionID:(NSString *)questionID withCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=questionpoll&user_id=%@&qstn_id=%@",BaseUrl,user.userID,questionID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_QuestionDetailServiceID andPageID:@""];
        }
        else // ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_QuestionDetailServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)voteForPollWithID:(NSString *)pollID andQuestionID:(NSString *)questionID withCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=dovoting&qstn_id=%@&user_id=%@&user_poll=%@",BaseUrl,questionID,user.userID,pollID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
        }
        else // ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)getSpeakerListwithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=speakerlist&event_id=%@",BaseUrl,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_SpeakerListServiceID andPageID:[NSString stringWithFormat:@"%@",@""]];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_SpeakerListServiceID andPageID:[NSString stringWithFormat:@"%@",@""]]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)getSpeakerDetailsWithId:(NSString *)speakerID withCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=speakerdetails&speaker_id=%@&user_id=%@&event_id=%@",BaseUrl,speakerID,user.userID,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_SpeakerDetailsServiceID andPageID:speakerID];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_SpeakerDetailsServiceID andPageID:speakerID]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)getLeaderBoardwithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=leaderboard&event_id=%@",BaseUrl,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_LeaderBoardServiceID andPageID:@""];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_LeaderBoardServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)getAttendeesListWithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=attendeelist&event_id=%@",BaseUrl,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_AttendeesListServiceID andPageID:@""];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_AttendeesListServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)getTralelAndLogisticsWithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=travelinfo&event_id=%@",BaseUrl,user.userEventID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_TravelAndLogisticsServiceID andPageID:@""];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData = [NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_TravelAndLogisticsServiceID andPageID:@""]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)uploadImage:(NSData *)imageData WithCompletionHandler:(requestCompletion)completionBlock{
    USTUser * user=[USTUser sharedInstance];
    NSString * url=[NSString stringWithFormat:@"%@upload.php?userid=%@",BaseUrl,user.userID];
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeUploadRequestFromFile:imageData WithCompletionHandler:^(USTRequest *request) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];

}

+(void)addPost:(NSDictionary *)parameters WithCompletionHandler:(requestCompletion)completionBlock{
    
    
    NSData * imageData = [parameters objectForKey:@"imageData"];
   NSString *imageName=@"";
    
    if (imageData.length) {
        [self uploadImage:imageData WithCompletionHandler:^(USTRequest * request){
            NSString* imageName = [NSString stringWithFormat:@"%@",[request.responseDict objectForKey:@"image_name"]];
            if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
                
                [self addPostWithData:parameters andImageName:imageName WithCompletionHandler:^(USTRequest * request) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionBlock(request);
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        
                    });
                }];
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(request);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    
                });
            }
        }];

    }
    else{
        [self addPostWithData:parameters andImageName:imageName WithCompletionHandler:^(USTRequest * request) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(request);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
            });
        }];

    }
    
}

+(void)addPostWithData:(NSDictionary *)parameters andImageName:(NSString *)image_Name WithCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];

    NSString * text = [parameters objectForKey:@"text"];
    NSString * agendaId = [parameters objectForKey:@"agendaId"];
    
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=add&userid=%@&text=%@&agendaid=%@&image=%@&eventid=%@",BaseUrl,user.userID,text,agendaId,image_Name,user.userEventID];
    
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
        }
        else if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}


+(void)likePostWithPostId:(NSString *)postID WithCompletionHandler:(requestCompletion)completionBlock{
   
    USTUser * user=[USTUser sharedInstance];
    
    
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=addlike&post_id=%@&user_id=%@&event_id=%@",BaseUrl,postID,user.userID,user.userEventID];
    
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
        }
        else if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];

}

+(void)getLikersListForPostWithID:(NSString *)postID WithCompletionHandler:(requestCompletion)completionBlock{
    
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=like&post_id=%@",BaseUrl,postID];
    
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
             [USTDataCacheHandler cacheData:request.responseData forServiceId:k_LikersListServiceID andPageID:postID];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData=[NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_LikersListServiceID andPageID:postID]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];

}

+(void)commentPostWithPostId:(NSString *)postID andComment:(NSString *)comment WithCompletionHandler:(requestCompletion)completionBlock{
    
    USTUser * user=[USTUser sharedInstance];
    
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=addcomment&post_id=%@&user_id=%@&cmnt_text=%@&event_id=%@",BaseUrl,postID,user.userID,comment,user.userEventID];
    
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
        }
        else if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];
}

+(void)getCommentListForPostWithID:(NSString *)postID WithCompletionHandler:(requestCompletion)completionBlock{
    
    NSString * url=[NSString stringWithFormat:@"%@post.php?action=comment&post_id=%@",BaseUrl,postID];
    
    USTRequest * request =[[USTRequest alloc]initWithUrl:url];
    
    [request makeGETNetworkRequestWithCompletionHandler:^(USTRequest *request) {
        
        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
            [USTDataCacheHandler cacheData:request.responseData forServiceId:k_CommentersListServiceID andPageID:postID];
        }
        else //if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"fail"])
        {
            request.responseData=[NSMutableData dataWithData:[USTDataCacheHandler getDataforServiceId:k_CommentersListServiceID andPageID:postID]];
            NSError *errorInJSON = nil;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                                 options:kNilOptions
                                                                   error:&errorInJSON];
            if (!errorInJSON) {
                request.responseDict = json;
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(request);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    }];

}


+(NSData *)getImageWithName:(NSString *)imageName{
    
    NSData * imageData ;
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageSubdirectory = [documentsPath stringByAppendingPathComponent:@"Images"];
    NSString *filePath = [imageSubdirectory stringByAppendingPathComponent:imageName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExists) {
        imageData = [NSData dataWithContentsOfFile:filePath];
        return imageData;
    }
    else{
         imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlFull,imageName]]];
        if (imageData.length) {
            [self createFileWithName:imageName andImageData:imageData];
        }
        return imageData;
        
    }
    

    return nil;
}

+ (void)createFileWithName:(NSString *)fileName andImageData:(NSData *)imageData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageSubdirectory = [documentsDirectory stringByAppendingPathComponent:@"Images"];
    
    BOOL isDir = NO;
    NSError *error;
    if (! [[NSFileManager defaultManager] fileExistsAtPath:imageSubdirectory isDirectory:&isDir]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:imageSubdirectory withIntermediateDirectories:YES attributes:nil error:&error];
        NSLog(@"Error after creating directory:\n%@",error);
    } else {
        // file exists - I don't expect to use the else block. This is for figuring out what's going on.
    }
    NSString *filePath = [imageSubdirectory stringByAppendingPathComponent:fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createFileAtPath:[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] contents:imageData attributes:nil];
    
}

@end
