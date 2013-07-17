//
//  CCAnswersDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswersDataProvider.h"
#import "CCAnswersApiProviderProtocol.h"

@interface CCAnswersDataProvider ()

@property (nonatomic, strong) id<CCAnswersApiProviderProtocol> ioc_answersApiProvider;

@end

@implementation CCAnswersDataProvider


- (void)loadMoreItems
{
    if (!self.isCurrentlyLoad && !self.isEverythingLoaded) {
        self.isCurrentlyLoad = YES;
        __weak CCAnswersDataProvider *weakSelf = self;
        [self loadItemsForPageNumber:self.currentPage successHandler:^(id responseObject) {
            NSDictionary *response = responseObject;
            weakSelf.arrayOfItems = [response[CCResponseKeys.items] arrayByAddingObjectsFromArray:weakSelf.arrayOfItems];
            weakSelf.isEverythingLoaded = [self checkIsComplete];
            
            [weakSelf.targetTable reloadData];
            NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:[response[CCResponseKeys.items] count] inSection:0];
            NSIndexPath *secondIndexPath = [NSIndexPath indexPathForRow:[response[CCResponseKeys.items] count] - 1 inSection:0];
            [weakSelf.targetTable scrollToRowAtIndexPath:firstIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            [weakSelf.targetTable scrollToRowAtIndexPath:secondIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
            weakSelf.isCurrentlyLoad = NO;
        }];
        self.currentPage++;
    }
}

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_answersApiProvider loadAnswersForQuestionWithId:self.questionId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(RKMappingResult *result) {
        
        NSMutableDictionary *mutableResponse = [(NSDictionary *)result mutableCopy];
        NSArray *arrayOfItems = mutableResponse[CCResponseKeys.items];
        NSArray *reversedArray = [[arrayOfItems reverseObjectEnumerator] allObjects];
        [mutableResponse setValue:reversedArray forKey:CCResponseKeys.items];
        
        successHandler(mutableResponse);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

- (void)deleteItem:(id)item
{
    NSInteger itemIndex = [self.arrayOfItems indexOfObject:item];
    NSIndexPath *itemIndexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
    
    NSMutableArray *mutableArrayOfItems = [self.arrayOfItems mutableCopy];
    [mutableArrayOfItems removeObject:item];
    self.arrayOfItems = [NSArray arrayWithArray:mutableArrayOfItems];
    [self.targetTable deleteRowsAtIndexPaths:@[itemIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
