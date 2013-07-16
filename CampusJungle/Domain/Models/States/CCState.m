//
//  CCState.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCState.h"
#import "CCRestKitConfigurator.h"

@implementation CCState

+ (void)configureMappingWithManager:(RKObjectManager *)objectManager
{
    [self configureStateResponse:objectManager];
}

+ (void)configureStateResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationStatesResponseMapping  = [CCRestKitConfigurator paginationMapping];
    
    RKObjectMapping *statesMapping = [RKObjectMapping mappingForClass:[CCState class]];
    [statesMapping addAttributeMappingsFromDictionary:[CCState responseMappingDictionary]];
    RKRelationshipMapping* relationShipResponseStatesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:CCResponseKeys.items
                                                                                                           toKeyPath:CCResponseKeys.items
                                                                                                         withMapping:statesMapping];
    
    RKResponseDescriptor *responsePaginationState = [RKResponseDescriptor responseDescriptorWithMapping:paginationStatesResponseMapping pathPattern:CCAPIDefines.states keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [paginationStatesResponseMapping addPropertyMapping:relationShipResponseStatesMapping];
    [objectManager addResponseDescriptor:responsePaginationState];
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"stateID",
      @"name" : @"name"
    };
}

@end
