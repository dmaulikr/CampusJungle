//
//  CCProfessorUploadDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPaginationDataProvider.h"

@interface CCProfessorUploadDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *classID;
@property (nonatomic, weak) id delegate;

@end
