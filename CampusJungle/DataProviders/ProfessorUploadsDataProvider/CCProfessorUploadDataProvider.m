//
//  CCProfessorUploadDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUploadDataProvider.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "CCProfessorUploadsAPIProviderProtocol.h"

@interface CCProfessorUploadDataProvider ()

@property (nonatomic, strong) id<CCQuestionsApiProviderProtocol> ioc_questionsApiProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;
@property (nonatomic, strong) id <CCProfessorUploadsAPIProviderProtocol> ioc_professorUploadsAPIProvider;

@end

@implementation CCProfessorUploadDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_professorUploadsAPIProvider
     loadUploadsForClassWithId:self.classID
                  filterString:self.searchQuery
                    pageNumber:numberOfPage
                successHandler:^(id result) {
                    result = [result firstObject];
                    if([[self.ioc_uploadManager uploadingProfessorUploads] count]){
                        [self.ioc_uploadManager setCurrentDataProvider:self];
                        NSMutableArray *allUploads = [NSMutableArray arrayWithArray:[self.ioc_uploadManager uploadingProfessorUploads]];
                        [allUploads addObjectsFromArray:result[@"items"]];
                        result[@"items"] = allUploads;
                        successHandler(result);
                    } else {
                        successHandler(result);
                    }
                } errorHandler:^(NSError *error) {
                    [self showErrorWhileLoading:error];
                }];
    
}

@end
