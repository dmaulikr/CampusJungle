//
//  CCUploadManager.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUploadProcessManagerProtocol.h"

@interface CCUploadProcessManager : NSObject <CCUploadProcessManagerProtocol>

@property (nonatomic, strong) NSMutableArray *uploadingNotes;
@property (nonatomic, strong) NSMutableArray *uploadingStuff;
@property (nonatomic, strong) NSMutableArray *uploadingQuestions;
@property (nonatomic, strong) NSMutableArray *uploadingProfessorUploads;
@property (nonatomic, strong) NSMutableArray *uploadingBooks;

@property (nonatomic, weak) CCBaseDataProvider *currentDataProvider;

@end
