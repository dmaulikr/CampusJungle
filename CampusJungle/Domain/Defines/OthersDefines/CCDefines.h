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
    __unsafe_unretained NSString *classmates;
    __unsafe_unretained NSString *leaveClass;
    __unsafe_unretained NSString *makeOffer;
    __unsafe_unretained NSString *recivedOffers;
    __unsafe_unretained NSString *classLocations;
    __unsafe_unretained NSString *postClassLocation;
    __unsafe_unretained NSString *deleteLocation;
    __unsafe_unretained NSString *getStuff;
    __unsafe_unretained NSString *getUser;
    __unsafe_unretained NSString *postMessage;
    __unsafe_unretained NSString *loadMyMessages;
    __unsafe_unretained NSString *postReview;
    __unsafe_unretained NSString *loadReviews;
    __unsafe_unretained NSString *loadGroups;
    __unsafe_unretained NSString *loadForums;
    __unsafe_unretained NSString *postForum;
    __unsafe_unretained NSString *deleteForum;
    __unsafe_unretained NSString *loadQuestions;
    __unsafe_unretained NSString *postQuestion;
    __unsafe_unretained NSString *emailQuestionAttachment;
    __unsafe_unretained NSString *deleteQuestion;
    __unsafe_unretained NSString *loadAnswers;
    __unsafe_unretained NSString *postAnswer;
    __unsafe_unretained NSString *deleteAnswer;
    __unsafe_unretained NSString *likeAnswer;
    __unsafe_unretained NSString *updateClass;
    __unsafe_unretained NSString *purchasedNotes;
    __unsafe_unretained NSString *loadComments;
    __unsafe_unretained NSString *postComment;
    __unsafe_unretained NSString *deleteComment;
    __unsafe_unretained NSString *getUploads;
    __unsafe_unretained NSString *postUploads;
    __unsafe_unretained NSString *removeUploads;
    __unsafe_unretained NSString *getAttachmentFromUploads;
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
    __unsafe_unretained NSString *classmatesCellIdentifier;
    __unsafe_unretained NSString *locationsCellIdentifier;
    __unsafe_unretained NSString *forumsCellIdentifier;
    __unsafe_unretained NSString *groupsCellIdentifier;
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
    NSInteger loaderDuration;
} CCProgressHudsConstants;

extern const struct CCClassTabbarButtonsTitles {
    __unsafe_unretained NSString *classmates;
    __unsafe_unretained NSString *groups;
    __unsafe_unretained NSString *locations;
    __unsafe_unretained NSString *forums;
} CCClassTabbarButtonsTitles;

extern const struct CCLocationPlacesTypes {
    __unsafe_unretained NSString *classType;
    __unsafe_unretained NSString *groupType;
} CCLocationPlacesTypes;

extern const struct CCHeaderViewsTitles {
    __unsafe_unretained NSString *answersHeaderViewTitle;
} CCHeaderViewsTitles;

enum CCClassTabbarButtonsIdentifiers {
    CCClassTabbarButtonsIdentifierClassmate = 1,
    CCClassTabbarButtonsIdentifierGroup = 2,
    CCClassTabbarButtonsIdentifierLocations = 3,
    CCClassTabbarButtonsIdentifierForums = 4,
};

