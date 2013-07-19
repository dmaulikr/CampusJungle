//
//  CCDefines.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDefines.h"

const struct CCAPIDefines CCAPIDefines = {
    .baseURL = @"http://collegeconnect.111projects.com",
    .signUp = @"/api/users/sign_up",
    .authorization = @"/api/authentications",
    .login = @"/api/users/login",
    .states = @"/api/states",
    .cities = @"/api/states/%@/cities",
    .colleges = @"/api/cities/%@/colleges",
    .linkFacebook = @"/api/users/me/authentications",
    .updateUser = @"/api/users/me",
    .createClass = @"/api/colleges/%@/classes",
    .emptyAvatarPath = @"/public",
    .currentUserInfo = @"/api/users/me",
    .allClasses = @"/api/users/me/classes",
    .addClass = @"/api/users/me/classes/%@",
    .classesOfCollege = @"/api/colleges/%@/classes",
    .uploadNotesPath = @"/api/colleges/%@/notes",
    .listOfMyNotes = @"/api/users/me/notes",
    .notesInMarket = @"/api/market/notes",
    .stuffInMarket = @"/api/market/stuff",
    .notesAttachmentURL = @"/api/notes/%@/attachment/show",
    .purchaseNote = @"/api/notes/%@/purchase",
    .removeNote = @"/api/users/me/notes/%@",
    .resendLinkToNote = @"/api/notes/%@/resend_link",
    .loadMyStuff = @"/api/users/me/stuff",
    .createStuff = @"/api/colleges/%@/stuff",
    .classesInColleges = @"/api/users/me/classes_in_colleges/",
    .classmates = @"/api/classes/%@/members",
    .leaveClass = @"/api/users/me/classes/%@",
    .makeOffer = @"/api/stuff/%@/offer",
    .recivedOffers = @"/api/users/me/offers",
    .classLocations = @"/api/users/me/classes/%@/locations",
    .postClassLocation = @"/api/classes/%@/locations",
    .deleteLocation = @"/api/locations/%@",
    .getStuff = @"/api/stuff/%@",
    .getUser = @"/api/users/%@",
    .postMessage = @"/api/messages",
    .loadMyMessages = @"/api/users/me/messages",
    .postReview = @"/api/users/%@/reviews",
    .loadReviews = @"/api/users/%@/reviews",
    .loadGroups = @"/api/users/me/classes/%@/groups",
    .loadForums = @"/api/classes/%@/forums",
    .postForum = @"/api/classes/%@/forums",
    .deleteForum = @"/api/forums/%@",
    .loadQuestions = @"/api/forums/%@/questions",
    .postQuestion = @"/api/forums/%@/questions",
    .emailQuestionAttachment = @"/api/questions/%@/email_attachment",
    .deleteQuestion = @"/api/questions/%@",
    .loadAnswers = @"/api/questions/%@/answers",
    .postAnswer = @"/api/questions/%@/answers",
    .deleteAnswer = @"/api/answers/%@",
    .likeAnswer = @"/api/answers/%@/like",
    .updateClass = @"/api/classes/%@",
    .purchasedNotes = @"/api/users/me/purchases/notes",
    .loadComments = @"/api/answers/%@/comments",
    .postComment = @"/api/answers/%@/comments",
    .deleteComment = @"/api/comments/%@",
    .loadUploads = @"/api/classes/%@/professors_uploads/index",
    .postUploads = @"/api/classes/%@/professors_uploads",
    .deleteUploads = @"/api/professors_uploads/%@",
    .getAttachmentFromUploads = @"/api/professors_uploads/%@",
};

const struct CCUserDefines CCUserDefines = {
    .firstName = @"UserFirstName",
    .lastName = @"UserLastName",
    .email = @"UserEmail",
    .avatar = @"UserAvatar",
    .oauthToken = @"UserOauthToken",
    .uid = @"UserUID",
    
    .facebookUID = @"FacebookUID",
    .facebookToken = @"FacebookToken",
    .facebook = @"facebook",
    
    .facebookAvatarLinkTemplate = @"https://graph.facebook.com/%@/picture?width=200&height=200",
    
    .currentUser = @"current_user",
    .minimumPasswordLength = 3,
    .isFacebookLinked = @"is_facebook_linked"

};

const struct CCUserSignUpKeys CCUserSignUpKeys = {
    .firstName = @"first_name",
    .lastName = @"last_name",
    .email = @"email",
    .password = @"password",
};

const struct CCUserAuthorizationKeys CCUserAuthorizationKeys = {
    .firstName = @"user[first_name]",
    .lastName  = @"user[last_name]",
    .email = @"user[email]",
    .avatar = @"user[avatar]",
    .authToken = @"oauth[][oauth_token]",
    .authProvider = @"oauth[][provider]",
    .authUID = @"oauth[][uid]",
    .authSecretToken = @"oauth[][oauth_token_secret]",
};

const struct CCLinkUserKeys CCLinkUserKeys = {
    .oauth_token = @"oauth_token",
    .uid = @"uid",
    .provider = @"provider"
};

const struct CCFacebookKeys CCFacebookKeys = {
    .firstName = @"first_name",
    .lastName = @"last_name",
    .uid = @"id",
    .email = @"email"
};

const struct CCTwitterUserKeys CCTwitterUserKeys = {
    .auth = @"auth",
    .firstName = @"first_name",
    .lastName = @"last_name",
    .avatar = @"image",
    .token = @"token",
    .secret = @"secret",
    .twitter = @"twitter",
    .uid = @"uid",
    .credentials = @"credentials",
    .info = @"info"
    
};

const struct CCErrorKeys CCErrorKeys = {
    .localizedRecoverySuggestion = @"NSLocalizedRecoverySuggestion",
    .errorMessage = @"error_message",
};

const struct CCTableDefines CCTableDefines = {
    .tableCellIdentifier = @"CellIdentifier",
    .tableHeaderIdentifier = @"TableHeaderIdentifier",
    .collectionCellIdentifier = @"CollectionCellIdentifier",
    .classmatesCellIdentifier = @"ClassmateCellIdentifier",
    .locationsCellIdentifier = @"LocationCellIdentifier",
    .forumsCellIdentifier = @"ForumCellIdentifier",
    .groupsCellIdentifier = @"GroupCellIdentifier",
};

const struct CCResponseKeys CCResponseKeys = {
    .item = @"item",
    .items = @"items",
    .count = @"count",
};

const struct CCAppDelegateDefines CCAppDelegateDefines = {
    .notificationOnBackToForeground = @"ApplicationDidReturnToForeground",
    .dropboxLinked = @"ApplicationLinkedWithDropBox",
};

const struct CCScreenTitles CCScreenTitles = {
    .stateScreenTitle = @"Select State",
    .dropboxTitle = @"Dropbox",
};

const struct CCDropboxDefines CCDropboxDefines = {
    .appKey = @"1xmjfk2bja9m6gg",
    .appSecret = @"v84udobka9mo7k5",
};

const struct CCTwitterDefines CCTwitterDefines = {
    .appKey = @"5PArGIFtG4ZxIm5tm02g",
    .appSecret = @"CdvGtu0kuTvezy4jnJOx6HVRU3PaMkC9ZlmiPLc",
    .appURLSchema = @"campusjungle://success",
};

const struct CCMarketFilterConstants CCMarketFilterConstants = {
    .colleges = @"colleges_ids",
    .classes = @"classes_ids",
    .orderTop = @"sales",
    .orderLatest = @"date",
};

const struct CCClassTabbarButtonsTitles CCClassTabbarButtonsTitles = {
    .classmates = @"Classmates",
    .groups = @"Groups",
    .locations = @"Locations",
    .forums = @"Forums",
};

const struct CCLocationPlacesTypes CCLocationPlacesTypes = {
    .classType = @"Klass",
    .groupType = @"Group"
};

const struct CCProgressHudsConstants CCProgressHudsConstants = {
    .loaderDuration = 5,
};

const struct CCHeaderViewsTitles CCHeaderViewsTitles = {
    .answersHeaderViewTitle = @"Tap to load previous answers",
};
