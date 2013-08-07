//
//  CCBooksOfferController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBooksOfferController.h"
#import "CCStandardErrorHandler.h"
#import "CCBook.h"
#import "CCBooksAPIProviderProtocol.h"

@interface CCBooksOfferController ()

@property (nonatomic, strong) id <CCBooksAPIProviderProtocol> ioc_booksAPIProvider;

@end

@implementation CCBooksOfferController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"CCOfferControllerViewController" bundle:nibBundleOrNil];
    return self;
}

- (void)sendOffer
{
    [self.ioc_booksAPIProvider makeAnOffer:self.inputField.text
                             toBookWithID:[(CCBook *)self.currentStuff bookID]
                            successHandler:^(id result) {
                                [self.backToStuffTransaction perform];
                            } errorHandler:^(NSError *error) {
                                [CCStandardErrorHandler showErrorWithError:error];
                            }];
    
}


@end
