//
//  CCProfessorUploadsAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"
#import "CCProfessorUpload.h"

@protocol CCProfessorUploadsAPIProviderProtocol <AppleGuiceInjectable>

- (void)loadUploadsForClassWithId:(NSString *)classId
                     filterString:(NSString *)filterString
                       pageNumber:(NSInteger)pageNumber
                   successHandler:(successWithObject)successHandler
                     errorHandler:(errorHandler)errorHandler;

- (void)postUploadInfo:(CCProfessorUpload *)profesorUploads
      ForClassWithId:(NSString *)classId
      successHandler:(successHandlerWithRKResult)successHandler
        errorHandler:(errorHandler)errorHandler;

- (void)deleteUploadInfo:(CCProfessorUpload *)profesorUploads
        successHandler:(successHandlerWithRKResult)successHandler
          errorHandler:(errorHandler)errorHandler;

- (void)postUploadInfo:(CCProfessorUpload *)profesorUploads
        ForClassWithId:(NSString *)classId
            withImages:(NSArray *)images
        successHandler:(successWithObject)successHandler
          errorHandler:(errorHandler)errorHandler
              progress:(progressBlock)progressBlock;

@end
