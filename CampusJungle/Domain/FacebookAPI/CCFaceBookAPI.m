//
//  GIFaceBookAPI.m
//  GiftIt
//
//  Created by Vlad Korzun on 15.03.13.
//  Copyright (c) 2013 Julia Petryshena. All rights reserved.
//

#import "CCFaceBookAPI.h"
#import "FBSession.h"
#import <FacebookSDK/FacebookSDK.h>

@interface CCFaceBookAPI()

@end

@implementation CCFaceBookAPI

-(void)loginWithSuccessHandler:(successHandler)successBlock errorHandler:(errorHandler)errorHandler
{
     if (![self isDeviceSessionExist]) {
         NSArray *permissions = @[@"email"];
        
         [FBSession openActiveSessionWithPublishPermissions:permissions
                                            defaultAudience:FBSessionDefaultAudienceEveryone 
                                               allowLoginUI:YES
                                          completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
              if(!error){
                  FBSession.activeSession = session;
                  if(successBlock){
                      successBlock();
                  }
              } else {
                  if(errorHandler){
                      errorHandler(error);
                  }
              }
          }];
    }
}

-(void)getUserInfoSuccessHandler:(userInfoSuccessHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    if ([self isDeviceSessionExist]) {
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if(!error){                 
                 if(successHandler){
                     successHandler(user);
                 }
             } else {
                 if(errorHandler){
                     errorHandler(error);
                 }
             }
         }];
    } 
}

-(BOOL)isDeviceSessionExist
{
    if(FBSession.activeSession.isOpen){
        return YES;
    }
    return NO;
}

-(void)logout
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

@end
