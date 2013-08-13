//
//  CCChatDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCChatDataSource.h"
#import "CCMessage.h"
#import "CCUserSessionProtocol.h"

@interface CCChatDataSource()

@property (nonatomic, strong) NSArray *formatedArrayOfMessages;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCChatDataSource

- (NSInteger)numberOfRows
{
    [self formateMessagesFromDataProvider];
    return self.formatedArrayOfMessages.count;
}

- (AMBubbleCellType)cellTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCMessage *currentMessage = self.formatedArrayOfMessages[indexPath.row];
    if([currentMessage isKindOfClass:[NSDate class]]){
        return AMBubbleCellTimestamp;
    }
    if(currentMessage.receiverID == [[self.ioc_userSession currentUser] uid]){
        return AMBubbleCellSent;
    } else {
        return AMBubbleCellReceived;
    }
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(CCMessage *)self.formatedArrayOfMessages[indexPath.row] text];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(CCMessage *)self.formatedArrayOfMessages[indexPath.row] createdAt];
}

- (NSString *)avatarForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,[(CCMessage *)self.formatedArrayOfMessages[indexPath.row] userAvatar]];
}

- (NSString*)usernameForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%@%@",[(CCMessage *)self.formatedArrayOfMessages[indexPath.row] userFirstName],[(CCMessage *)self.formatedArrayOfMessages[indexPath.row] userLastName]];
}

- (UIColor*)usernameColorForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIColor brownColor];
}

- (void)formateMessagesFromDataProvider
{
    NSMutableArray *rawMessages = self.chatDataProvider.arrayOfItems.mutableCopy;
    NSInteger numberOfMessages = rawMessages.count;
    for (int i = numberOfMessages - 1; i > 1; i--){
        if(![self isSameDayWithDate1:[(CCMessage *)rawMessages[i] createdAt] date2:[(CCMessage *)rawMessages[i - 1] createdAt]]){
            [rawMessages insertObject:[(CCMessage *)rawMessages[i] createdAt] atIndex:i];
        }
    }
    [rawMessages insertObject:[(CCMessage *)rawMessages[0] createdAt] atIndex:0];
    self.formatedArrayOfMessages = rawMessages;
}

- (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]  == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

@end
