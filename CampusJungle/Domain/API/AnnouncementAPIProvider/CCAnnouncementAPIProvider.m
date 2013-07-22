//
//  CCAnoumcementAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementAPIProvider.h"

@implementation CCAnnouncementAPIProvider

- (void)loadAnnouncementsClassID:(NSString *)classID filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadAnnouncements,classID];
    NSMutableDictionary *params = [@{@"page_number" : @(pageNumber)} mutableCopy];
    if(filterString){
        params[@"keywords"] = filterString;
    }
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)postAnnouncement:(CCAnnouncement *)announcement successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.postAnnouncements, announcement.classID];
    [objectManager postObject:announcement
                         path:path
                   parameters:nil
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult);
                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

- (void)deleteAnnouncement:(CCAnnouncement *)announcement successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.deleteAnouncements, announcement.announcementID];
    [objectManager deleteObject:nil
                         path:path
                   parameters:nil
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult);
                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

@end
