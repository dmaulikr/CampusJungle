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
    //.baseURL = @"http://0.0.0.0:3000",
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
    .groupLocations = @"/api/users/me/groups/%@/locations",
    .postClassLocation = @"/api/classes/%@/locations",
    .postGroupLocation = @"/api/groups/%@/locations",
    .deleteLocation = @"/api/locations/%@",
    .getStuff = @"/api/stuff/%@",
    .deleteStuff = @"/api/users/me/stuff/%@",
    .getUser = @"/api/users/%@",
    .getMessage = @"/api/messages/%@",
    .postMessage = @"/api/messages",
    .loadMyMessages = @"/api/users/me/messages",
    .postReview = @"/api/users/%@/reviews",
    .loadReviews = @"/api/users/%@/reviews",
    .loadGroups = @"/api/users/me/classes/%@/groups",
    .loadClassQuestions = @"/api/classes/%@/questions",
    .loadGroupQuestions = @"/api/groups/%@/questions",
    .postClassQuestion = @"/api/classes/%@/questions",
    .postGroupQuestion = @"/api/groups/%@/questions",
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
    .loadUploads = @"/api/classes/%@/professors_uploads",
    .postUploads = @"/api/classes/%@/professors_uploads",
    .deleteUploads = @"/api/professors_uploads/%@",
    .emailUploadsAttachment = @"professors_uploads/%@/send_attachment",
    .getAttachmentFromUploads = @"/api/professors_uploads/%@",
    .createGroup = @"/api/users/me/classes/%@/groups",
    .updateGroup = @"/api/groups/%@",
    .leaveGroup = @"/api/groups/%@/leave",
    .destroyGroup = @"/api/groups/%@",
    .loadGroupMembers = @"/api/groups/%@/members",
    .loadClassmatesToInviteInGroup = @"/api/groups/%@/classmates_to_invite",
    .loadAnnouncements = @"/api/classes/%@/announcements",
    .postAnnouncements = @"/api/classes/%@/announcements",
    .deleteAnouncements = @"/api/announcements/%@",
    .deleteMessage = @"/api/messages/%@",
    .getCommonClasses = @"/api/users/%@/common_classes",
    .sendGroupInvite = @"/api/groups/%@/invites",
    .loadGroupInvites = @"/api/users/me/group_invites",
    .resendGroupInvite = @"/api/group_invites/%@/resend",
    .acceptGroupInvite = @"/api/group_invites/%@/accept",
    .rejectGroupInvite = @"/api/group_invites/%@/reject",
    .deleteGroupInvite = @"/api/group_invites/%@",
    .getFeedback = @"/api/classes/%@/feedback",
    .postFeedback = @"/api/classes/%@/feedback",
    .recalculateFeedback = @"/api/classes/%@/feedback/recalculate",
    .votingAvailability = @"/api/classes/%@/feedback/voting_availability",
    .loadAppInvites = @"/api/users/me/app_invites",
    .sendAppInvites = @"/api/app_invites",
    .resendAppInvite = @"/api/app_invites/%@",
    .deleteAppInvite = @"/api/app_invites/%@",
    .payUsingPayPal = @"/api/%@",
    .payUsingInAppPurchases = @"/api/%@",
    .linkDevice = @"/api/users/me/devices",
    .unlinkDevice = @"/api/users/me/devices",
    .loadQuestion = @"/api/questions/%@",
    .loadClass = @"/api/users/me/classes/%@",
    .loadComment = @"/api/comments/%@",
    .loadAnswer = @"/api/answers/%@",
    .loadProfessorsUpload = @"/api/professors_uploads/%@",
    .resetUnwatchedEvents = @"/api/users/me/unwatched_events/reset",
    .checkAvailablityOfReport = @"/api/reports/availablity_of_report",
    .postReport = @"/api/reports",
    .users = @"/api/users",
    .acceptInvite = @"/api/app_invites/users/accept",
    .loadGroup = @"/api/groups/%@",
    .loadAds = @"/api/classes/%@/ads",
    .getSettings = @"/api/users/me/notification_settings",
    .setSettings = @"/api/users/me/notification_settings",
    .loadMyBooks = @"/api/users/me/books",
    .bookInMarket = @"/api/market/books",
    .createBook = @"/api/colleges/%@/books",
    .getBook = @"/api/books/%@",
    .deleteBook = @"/api/users/me/books/%@",
    .makeBookOffer = @"/api/books/%@/offer",
    .changePassword = @"/api/users/me/change_password",
    .cashOutRequest = @"/api/",
    .myDialogs = @"/api/dialogs",
    .dialogForUserWithID = @"/api/dialogs/user/%@",
    .messagesForDialog = @"/api/dialogs/%@",
    .dialogWithId = @"/api/dialogs/dialog/%@",
    .dialogForGroupWithID = @"/api/dialog/group/%@",
    .requestMoney = @"/api/users/me/cashout_requests",
    .answerAttachmentSendUsingEmail = @"/api/answer/%@/email_attachment",
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
    .questionsCellIdentifier = @"QuestionCellIdentifier",
    .groupsCellIdentifier = @"GroupCellIdentifier",
    .messageCellIdentifier = @"MessageCellIdentifier",
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
    .groupmates = @"Groupmates",
    .groups = @"Groups",
    .locations = @"Locations",
    .questions = @"Questions",
    .groupMessages = @"Group Messages",
};

const struct CCLocationPlacesTypes CCLocationPlacesTypes = {
    .classType = @"Klass",
    .groupType = @"Group"
};

const struct CCProgressHudsConstants CCProgressHudsConstants = {
    .loaderDuration = 4,
};

const struct CCHeaderViewsTitles CCHeaderViewsTitles = {
    .answersHeaderViewTitle = @"Tap to load previous answers",
};

const struct CCAvatarActionSheetButtonsTitles CCAvatarActionSheetButtonsTitles = {
    .takePhotoButtonTitle = @"Take a photo",
    .selectFromGalleryButtonTitle = @"Select from gallery",
    .cancelButtonTitle = @"Cancel",
};

const struct CCShareItemActionSheetDefines CCShareItemActionSheetDefines = {
    .title = @"Share Options",
    .shareWithClassButtonTitle = @"Share with Class",
    .shareWithGroupsButtonTitle = @"Share with Groups",
    .shareWithGroupButtonTitle = @"Share with Group",
    .shareWithClassmatesButtonTitle = @"Share with Classmates",
    .shareWithGroupmatesButtonTitle = @"Share with Groupmates",
};

const struct CCSearchBarPlaceholders CCSearchBarPlaceholders = {
    .searchGroupmates = @"Search Groupmates",
    .searchQuestions = @"Search Questions",
    .searchLocations = @"Search Locations",
    .searchMessages = @"Search Messages",
    .searchClassmates = @"Search Classmates",
    .searchGroups = @"Search Groups",
};

const struct CCAppInvitesDefines CCAppInvitesDefines = {
    .appInviteSubject = @"Campus Jungle Invite",
    .emailInviteBody = @"Hey! Why not to start using CampusJungle App for iOS?",
    .smsInviteBody = @"Hey! Why not to start using CampusJungle App for iOS?",
};

const struct CCAppInvitesFacebookConstants CCAppInvitesFacebookConstants = {
    .name = @"CampusJungle for iOS",
    .caption = @"Great New App",
    .description = @"CampusJungle is a great new app! Check it out.",
    .link = @"",
};

const struct CCPushNotificationTypes CCPushNotificationTypes = {
    .privateMessage = @"PrivateMessage",
    .groupMessage = @"GroupMessage",
    .answer = @"Answer",
    .comment = @"Comment",
    .professorUpload = @"ProfessorsUpload",
    .announcement = @"Announcement",
    .location = @"Location",
    .question = @"Question",
    .coupon = @"Coupon",
    .groupInvite = @"GroupInvite",
    .moneyOut = @"MoneyOut",
    .classfeedback = @"ClassFeedback",
    .moneyForInvite = @"MoneyForInvite",
    .offer = @"Offer",
};

const struct CCPayPalDefines CCPayPalDefines = {
    .clientID = @"AUxTVhCEXoIo1xu4UAvWPiGXSJD0T-aKNy0A3hfKGbQ9_xpDy1n1VNSuAFgr",
    .reciverEmail = @"v.korzun-facilitator@111min.com",
};
