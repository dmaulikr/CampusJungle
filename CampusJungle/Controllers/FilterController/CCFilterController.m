//
//  CCFilterController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFilterController.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCFiltersDataProvider.h"
#import "CCMarketFilterDataSource.h"
#import "CCOrdinaryCell.h"
#import "CCFilterSectionHeader.h"
#import "CCDefines.h"
#import "CCMarketFilterClassesCell.h"
#import "CCFilterSection.h"
#import "CCClass.h"
#import "CCAlertDefines.h"

@interface CCFilterController ()

@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPIProvider;
@property (nonatomic, strong) CCBaseDataProvider *dataProvider;

@end

@implementation CCFilterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CCFiltersDataProvider *dataProvider = [CCFiltersDataProvider new];
    dataProvider.filters = self.oldFilters;
    self.dataProvider = dataProvider;
    self.dataSourceClass = [CCMarketFilterDataSource class];
    [self configTableWithProvider:dataProvider cellClass:[CCMarketFilterClassesCell class]];
    [self.mainTable registerClass:[CCFilterSectionHeader class] forHeaderFooterViewReuseIdentifier:CCTableDefines.tableHeaderIdentifier];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStyleBordered target:self action:@selector(applyFilters)];
}

- (void)applyFilters
{
    NSDictionary *filters = [self filters];
    if([filters[CCMarketFilterConstants.classes] count] || [filters[CCMarketFilterConstants.colleges] count]){
        [self.backToMarketTRansaction performWithObject:[self filters]];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCValidationMessages.filterCanNotBeEmpty];
    }
}

- (NSDictionary *)filters
{

    NSMutableArray *arrayOfColleges = [NSMutableArray new];
    NSMutableArray *arrayOfClasses = [NSMutableArray new];
    
    for(CCFilterSection *section in self.dataProvider.arrayOfItems){
        if([section.classes[0] isSelected]){
            [arrayOfColleges addObject:[NSNumber numberWithInteger: section.collegeID]];
        } else {
            for (CCClass *currentClass in section.classes){
                if(currentClass.isSelected){
                    [arrayOfClasses addObject:currentClass.classID];
                }
            }
        }
    }
    
    NSDictionary *filters = @{
                CCMarketFilterConstants.classes : arrayOfClasses,
                CCMarketFilterConstants.colleges : arrayOfColleges,
                };

    return filters;
}


@end