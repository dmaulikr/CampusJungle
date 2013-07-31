//
//  CCReport.m
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReport.h"

@implementation CCReport

+ (CCReport *)createWithItemId:(NSString *)itemId itemType:(NSString *)itemType;
{
    CCReport *report = [CCReport new];
    report.itemId = itemId;
    report.itemType = itemType;
    return report;
}

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureRequestMapping:objectManager];
}

+ (void)configureRequestMapping:(RKObjectManager *)objectManager
{
    RKObjectMapping *reportMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [reportMapping addAttributeMappingsFromDictionary:[CCReport requestMappingDictionary]];
    RKRequestDescriptor *reportRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:reportMapping objectClass:[CCReport class] rootKeyPath:nil];
    [objectManager addRequestDescriptor:reportRequestDescriptor];

}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"text" : @"text",
             @"itemId" : @"item_id",
             @"itemType" : @"item_type"
             };
}

@end
