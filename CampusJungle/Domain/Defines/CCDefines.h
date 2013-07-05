//
//  CCDefines.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

extern const struct CCAPIDefines {
    __unsafe_unretained NSString *baseURL;
    __unsafe_unretained NSString *authorization;
    __unsafe_unretained NSString *signUp;
    __unsafe_unretained NSString *login;
    __unsafe_unretained NSString *states;
    __unsafe_unretained NSString *cities;
    __unsafe_unretained NSString *colleges;
    __unsafe_unretained NSString *linkFacebook;
    __unsafe_unretained NSString *updateUser;
    __unsafe_unretained NSString *createClass;
    __unsafe_unretained NSString *emptyAvatarPath;
    __unsafe_unretained NSString *currentUserInfo;
    __unsafe_unretained NSString *allClasses;
    __unsafe_unretained NSString *addClass;
    __unsafe_unretained NSString *classesOfCollege;
    __unsafe_unretained NSString *uploadNotesPath;
    __unsafe_unretained NSString *listOfMyNotes;
    __unsafe_unretained NSString *notesInMarket;
    __unsafe_unretained NSString *stuffInMarket;
    __unsafe_unretained NSString *notesAttachmentURL;
    __unsafe_unretained NSString *purchaseNote;
    __unsafe_unretained NSString *removeNote;
    __unsafe_unretained NSString *resendLinkToNote;
    __unsafe_unretained NSString *loadMyStuff;
    __unsafe_unretained NSString *createStuff;
    __unsafe_unretained NSString *classesInColleges;
} CCAPIDefines;


extern const struct CCUserDefines {
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *avatar;
    __unsafe_unretained NSString *oauthToken;
    __unsafe_unretained NSString *uid;
    
    __unsafe_unretained NSString *facebookUID;
    __unsafe_unretained NSString *facebookToken;
    __unsafe_unretained NSString *facebook;
    
    __unsafe_unretained NSString *currentUser;
    
    __unsafe_unretained NSString *facebookAvatarLinkTemplate;
    __unsafe_unretained NSString *isFacebookLinked;
    NSInteger minimumPasswordLength;
} CCUserDefines;

extern const struct CCUserSignUpKeys {
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *password;
} CCUserSignUpKeys;

extern const struct CCUserAuthorizationKeys {
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *avatar;
    __unsafe_unretained NSString *authToken;
    __unsafe_unretained NSString *authProvider;
    __unsafe_unretained NSString *authUID;
    __unsafe_unretained NSString *authSecretToken;
} CCUserAuthorizationKeys;

extern const struct CCTwitterUserKeys  {
    __unsafe_unretained NSString *auth;
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *avatar;
    __unsafe_unretained NSString *token;
    __unsafe_unretained NSString *secret;
    __unsafe_unretained NSString *twitter;
    __unsafe_unretained NSString *uid;
    __unsafe_unretained NSString *credentials;
    __unsafe_unretained NSString *info;
} CCTwitterUserKeys;

extern const struct CCFacebookKeys {
    __unsafe_unretained NSString *uid;
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
} CCFacebookKeys;

extern const struct CCErrorKeys {
    __unsafe_unretained NSString *localizedRecoverySuggestion;
    __unsafe_unretained NSString *errorMessage;
} CCErrorKeys;

extern const struct CCTableDefines {
    __unsafe_unretained NSString *tableCellIdentifier;
    __unsafe_unretained NSString *collectionCellIdentifier;
    __unsafe_unretained NSString *tableHeaderIdentifier;
} CCTableDefines;

extern const struct CCLinkUserKeys {
    __unsafe_unretained NSString *oauth_token;
    __unsafe_unretained NSString *uid;
    __unsafe_unretained NSString *provider;
    
} CCLinkUserKeys;

extern const struct CCResponseKeys
{
    __unsafe_unretained NSString *item;
    __unsafe_unretained NSString *items;
    __unsafe_unretained NSString *count;
} CCResponseKeys;

extern const struct CCAppDelegateDefines
{
    __unsafe_unretained NSString *notificationOnBackToForeground;
    __unsafe_unretained NSString *dropboxLinked;
    
} CCAppDelegateDefines;

extern const struct CCScreenTitles {
    __unsafe_unretained NSString *stateScreenTitle;
    __unsafe_unretained NSString *dropboxTitle;
} CCScreenTitles;

extern const struct CCDropboxDefines {
    __unsafe_unretained NSString *appKey;
    __unsafe_unretained NSString *appSecret;
} CCDropboxDefines;

extern const struct CCTwitterDefines {
    __unsafe_unretained NSString *appKey;
    __unsafe_unretained NSString *appSecret;
    __unsafe_unretained NSString *appURLSchema;
} CCTwitterDefines;

extern const struct CCMarketFilterConstants {
    __unsafe_unretained NSString *colleges;
    __unsafe_unretained NSString *classes;
    __unsafe_unretained NSString *orderTop;
    __unsafe_unretained NSString *orderLatest;
} CCMarketFilterConstants;

extern const struct CCProgressHudsConstants {
    __unsafe_unretained NSInteger loaderDuration;
} CCProgressHudsConstants;