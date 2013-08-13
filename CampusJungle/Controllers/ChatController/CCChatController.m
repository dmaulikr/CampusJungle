//
//  CCChatController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCChatController.h"
#import "CCUserSessionProtocol.h"

@interface CCChatController ()<AMBubbleTableDataSource, AMBubbleTableDelegate>

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCChatController

- (void)viewDidAppear:(BOOL)animated
{
    [self setDataSource:self];
	[self setDelegate:self];
    self.data = [@[
                  ] mutableCopy];
    [self setTableStyle:AMBubbleTableStyleSquare];
    [super viewDidAppear:YES];
}

- (NSString *)title
{
    return @"Chat";
}

- (NSInteger)numberOfRows
{
	return self.data.count;
}

- (AMBubbleCellType)cellTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.data[indexPath.row][@"type"] intValue];
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.data[indexPath.row][@"text"];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [NSDate date];
}

- (UIImage*)avatarForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,[[self.ioc_userSession currentUser] avatar]];
}

#pragma mark - AMBubbleTableDelegate

- (void)didSendText:(NSString*)text
{
	[self.data addObject:@{ @"text": text,
	 @"date": [NSDate date],
	 @"type": @(AMBubbleCellSent)
	 }];
	[super reloadTableScrollingToBottom:NO];
}

- (NSString*)usernameForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.data[indexPath.row][@"username"];
}

- (UIColor*)usernameColorForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.data[indexPath.row][@"color"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
