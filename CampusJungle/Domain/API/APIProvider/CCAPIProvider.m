//
//  CCAPIProvider.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAPIProvider.h"
#import "CCUserSessionProtocol.h"
#import "CCDefines.h"

@interface CCAPIProvider()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCAPIProvider

- (void)setAuthorizationToken
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.HTTPClient setAuthorizationHeaderWithToken:self.ioc_userSession.currentUser.token];
}

- (void)setContentTypeJSON
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    objectManager.HTTPClient.parameterEncoding = AFJSONParameterEncoding;
}

- (void)putUser:(NSDictionary *)userInfo
 successHandler:(successHandlerWithRKResult)successHandler
   errorHandler:(RKErrorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager putObject:nil
                         path:CCAPIDefines.authorization
                   parameters:userInfo success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       if(successHandler){
                           successHandler(mappingResult);
                       }
                   }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          if(errorHandler){
                              errorHandler(operation, error);
                          }
                      }];
}

- (void)putUserForSingUp:(NSDictionary *)userInfo
          successHandler:(successHandlerWithRKResult)successHandler
            errorHandler:(errorHandler)errorHandler{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager postObject:nil path:CCAPIDefines.signUp parameters:userInfo success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)putUserForLogin:(NSDictionary *)userInfo
         successHandler:(successHandlerWithRKResult)successHandler
           errorHandler:(errorHandler)errorHandler{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [objectManager putObject:nil
                         path:CCAPIDefines.login
                   parameters:userInfo
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadStatesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
       [params setObject:query forKey:@"name"];
    }
    [self loadItemsWithParams:params path:CCAPIDefines.states successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadCitiesInState:(NSNumber *)stateID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
        [params setObject:query forKey:@"name"];
    }
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.cities, stateID];
    
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadCollegesInCity:(NSNumber *)cityID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
        [params setObject:query forKey:@"name"];
    }
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.colleges, cityID];
    
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadCollegesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
        [params setObject:query forKey:@"name"];
    }
    
    NSString *path = @"/api/colleges";
    
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];


}

- (void)loadClassmatesForClass:(NSString *)classID filterString:(NSString *)filterString numberOfPage:(NSNumber *)pageNumber successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if ([filterString length] > 0) {
        [params setObject:filterString forKey:@"keywords"];
    }
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.classmates,classID];
    [self loadItemsWithParams:params
                         path:path
               successHandler:successHandler
                 errorHandler:errorHandler];
}

- (void)loadItemsWithParams:(NSDictionary *)params path:(NSString *)path successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    [objectManager getObjectsAtPath:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)linkUserWithUserInfo:(NSDictionary *)userInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    [objectManager putObject:nil
                        path:CCAPIDefines.linkFacebook
                  parameters:userInfo
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(userInfo);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                     }];
}


- (void)updateUser:(CCUser *)user withAvatarImage:(UIImage *)avatarImage successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSMutableURLRequest *request =
    [objectManager multipartFormRequestWithObject:user
                                           method:RKRequestMethodPUT
                                             path:CCAPIDefines.updateUser parameters:nil
                        constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if(avatarImage){
             [formData appendPartWithFileData:UIImagePNGRepresentation(avatarImage)
                                     name:@"user[avatar]"
                                     fileName:@"avatar.png"
                                     mimeType:@"image/png"];
         }
     }];
    RKObjectRequestOperation *operation =
    [objectManager objectRequestOperationWithRequest:request
                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         if(successHandler){
             successHandler(mappingResult.firstObject);
         }
     }
                                             failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                 if(successHandler){
                                                     errorHandler(error);
                                                 }
                                             }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [operation start];
    });
}

- (void)createCity:(NSString *)cityName stateID:(NSNumber *)stateID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.cities,stateID];
    [objectManager postObject:nil
                        path:path
                   parameters:@{@"name" :  cityName}
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult.firstObject);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                     }];

}

- (void)createCollege:(NSString *)collegeName cityID:(NSNumber *)cityID address:(NSString *)addess SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSMutableDictionary *params = [@{@"name" :  collegeName} mutableCopy];
    if(addess) {
        [params setObject:addess forKey:@"address"];
    }
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.colleges,cityID];
    [objectManager postObject:nil
                         path:path
                   parameters:params
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult.firstObject);
                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

- (void)loadUserInfoSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    [objectManager getObject:nil
                         path:CCAPIDefines.currentUserInfo
                   parameters:nil
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult.firstObject);
                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

- (void)loadMyNotesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [@{@"page_number" : pageNumber.stringValue} mutableCopy];
    if(query){
        [params setValue:query forKey:@"keywords"];
    }
    
    [self loadItemsWithParams:params path:CCAPIDefines.listOfMyNotes successHandler:successHandler errorHandler:errorHandler];
}

- (void)postInfoWithObject:(id)object thumbnail:(UIImage *)thumb images:(NSArray *)images onPath:(NSString *)path successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock
{
    [self uploadInfoWithObject:object thumbnail:thumb images:images onPath:path successHandler:successHandler errorHandler:errorHandler progress:progressBlock method:RKRequestMethodPOST];
}

- (void)putInfoWithObject:(id)object thumbnail:(UIImage *)thumb images:(NSArray *)images onPath:(NSString *)path successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock
{
    [self uploadInfoWithObject:object thumbnail:thumb images:images onPath:path successHandler:successHandler errorHandler:errorHandler progress:progressBlock method:RKRequestMethodPUT];
}


- (void)uploadInfoWithObject:(id)object thumbnail:(UIImage *)thumb images:(NSArray *)images onPath:(NSString *)path successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock method:(RKRequestMethod)method
{
    [self setAuthorizationToken];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableURLRequest *request =
        [objectManager multipartFormRequestWithObject:object
                                               method:method
                                                 path:path
                                           parameters:nil
                            constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
             if(thumb){
                 [formData appendPartWithFileData:UIImagePNGRepresentation(thumb)
                                             name:@"thumbnail"
                                         fileName:@"thumbnail.png"
                                         mimeType:@"image/png"];
             }
             int i = 1;
             for(UIImage *image in images){
                 NSString *fileName = [NSString stringWithFormat:@"file%d.png",i++];
                 [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                             name:@"images[]"
                                         fileName:fileName
                                         mimeType:@"image/png"];
             }
             
         }];
        
        RKObjectRequestOperation *operation =
        [objectManager objectRequestOperationWithRequest:request
                                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
         {
             if(successHandler){
                 successHandler(mappingResult.firstObject);
             }
         }
                                                 failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                     if(successHandler){
                                                         errorHandler(error);
                                                     }
                                                 }];
        
        [operation.HTTPRequestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            progressBlock((double)totalBytesWritten/totalBytesExpectedToWrite);
        }];
        [operation start];
        
    });
}

- (void)getUserWithID:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.getUser,userID];
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)postReviewWithRate:(NSNumber *)rank text:(NSString *)text forUserWithID:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.postReview,userID];
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager postObject:nil path:path parameters:@{
     @"rank" : rank,
     @"text" : text
     } success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         successHandler(mappingResult);
     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         errorHandler(error);
     }];
}

- (void)loadReviewsForUser:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadReviews,userID];
    
    [self loadItemsWithParams:nil
                         path:path
               successHandler:successHandler
                 errorHandler:errorHandler];
}

@end
