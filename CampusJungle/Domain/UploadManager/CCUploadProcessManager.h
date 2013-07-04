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

@end
