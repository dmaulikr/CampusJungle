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

@interface CCFilterController ()

@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPIProvider;

@end

@implementation CCFilterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.ioc_classesAPIProvider getAllClasesSuccessHandler:^(id result) {
        
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end