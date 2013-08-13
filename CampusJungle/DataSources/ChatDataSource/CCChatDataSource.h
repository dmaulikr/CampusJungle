//
//  CCChatDataSource.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCChatDataProvider.h"
#import "AMBubbleTableViewController.h"

@interface CCChatDataSource : NSObject<AMBubbleTableDataSource>

@property (nonatomic, strong) CCChatDataProvider *chatDataProvider;

@end
