//
//  CCFiltersDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFiltersDataProvider.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCClass.h"
#import "CCFilterSection.h"
#import "CCDefines.h"
#import "CCUserSessionProtocol.h"
#import "CCAPIProviderProtocol.h"
#import "CCEducation.h"

@interface CCFiltersDataProvider()

@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesProviderProtocol;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCFiltersDataProvider

- (void)loadItems
{
    [self.ioc_classesProviderProtocol getAllClasesSuccessHandler:^(id result) {
        [self.ioc_userSession loadUserEducationsSuccessHandler:^(id educations){
            self.arrayOfItems = [self sectionFromResponse:result];
            [self.targetTable reloadData];
        }];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (NSArray *)sectionFromResponse:(NSArray *)response
{
    NSMutableArray *arrayOfSection = [NSMutableArray new];
    NSArray *educations = [[self.ioc_userSession currentUser] educations];
    NSArray *arrayOfCollegeIDs = [CCEducation arrayOfCollegesIDFromEducations:educations];
   
    for (NSString *collegeID in arrayOfCollegeIDs){
        CCFilterSection *section = [CCFilterSection new];
        section.collegeName = [self collegeNameFromEducations:educations collegeID:collegeID];
        section.collegeID = collegeID.integerValue;
        section.isOpen = YES;
        section.index = arrayOfSection.count;
        [section.classes addObject:[self fakeClassForCollegeID:section.collegeID]];
        [arrayOfSection addObject:section];
    }
    
    for (CCClass *class in response){
        CCFilterSection *section = [self findSection:class.collegeID.integerValue inArray:arrayOfSection];
        [section.classes addObject:class];
    }
    [self checkAlreadyFiltred:arrayOfSection];
    
    return arrayOfSection;
}

- (NSString *)collegeNameFromEducations:(NSArray *)educations collegeID:(NSString *)collegeID
{
    for(CCEducation *education in educations){
        if ([education.collegeID.stringValue isEqualToString:collegeID]){
            return education.collegeName;
        }
    }
    return nil;
}

- (void)checkAlreadyFiltred:(NSArray *)sections
{
    NSArray *filtredColleges = self.filters[CCMarketFilterConstants.colleges];
    NSArray *filtredClasses = self.filters[CCMarketFilterConstants.classes];
    for(CCFilterSection *section in sections){
        if([self isString:[NSString stringWithFormat:@"%d",section.collegeID] inArray:filtredColleges]){
            [section.classes[0] setIsSelected:YES];
        } else {
            for(CCClass *currentClass in section.classes){
                if ([self isString:currentClass.classID inArray:filtredClasses]){
                    currentClass.isSelected = YES;
                }
            }
        }
    }
}

- (BOOL)isString:(NSString *)string inArray:(NSArray *)array
{
    for(id stringFromArray in array){
        if([string isEqualToString:[stringFromArray description]]){
            return YES;
        }
    }
    return NO;
}

- (CCClass *)fakeClassForCollegeID:(NSInteger)collegeID
{
    CCClass *fakeClass = [CCClass new];
    fakeClass.subject = @"All over college";
    fakeClass.classID = 0;
    fakeClass.collegeID = [NSString stringWithFormat:@"%d",collegeID];

    return fakeClass;
}

- (CCFilterSection *)findSection:(NSInteger)collegeID inArray:(NSArray *)sections
{
    for(CCFilterSection *section in sections){
        if(section.collegeID == collegeID){
            return section;
        }
    }
    return nil;
}

@end
