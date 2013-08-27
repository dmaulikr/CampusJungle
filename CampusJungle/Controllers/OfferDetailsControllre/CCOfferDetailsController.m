//
//  CCOfferDetailsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOfferDetailsController.h"
#import "CCStuffAPIProviderProtocol.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCButtonsHelper.h"
#import "CCStuff.h"
#import "CCBook.h"
#import "CCUser.h"
#import "CCBooksAPIProviderProtocol.h"
#import "CCDialogsAPIProviderProtocol.h"

@interface CCOfferDetailsController ()

@property (nonatomic, weak) IBOutlet UITextView *offerText;
@property (nonatomic, weak) IBOutlet UIImageView *senderAvatar;
@property (nonatomic, weak) IBOutlet UILabel *senderName;
@property (nonatomic, weak) IBOutlet UILabel *stuffNameLabel;
@property (nonatomic, weak) IBOutlet UIButton *stuffDetailsButton;
@property (nonatomic, weak) IBOutlet UIButton *senderDetailsButton;
@property (nonatomic, strong) id <CCDialogsAPIProviderProtocol> ioc_dialogAPIProvider;
@property (nonatomic, strong) id <CCBooksAPIProviderProtocol> ioc_booksAPIProvider;
@property (nonatomic, strong) id <CCStuffAPIProviderProtocol> ioc_stuffAPIProvider;
@property (nonatomic ,strong) id <CCAPIProviderProtocol> ioc_APIProvider;
@property (nonatomic, strong) CCStuff *stuff;
@property (nonatomic, strong) CCBook *book;
@property (nonatomic, strong) CCUser *sender;

- (IBAction)senderButtonDidPressed;
- (IBAction)stuffDidPerssed;
- (IBAction)answerButtonDidPressed;

@end

@implementation CCOfferDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Offer";
    [self loadOfferInfo];
    [self loadInfo];
    [self setupButtons];
    
}

- (void)setupButtons
{
    [CCButtonsHelper removeBackgroundImageInButton:self.stuffDetailsButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.senderDetailsButton];
}

- (void)loadInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if(self.offer.stuffID){
        [self.ioc_stuffAPIProvider getStuffWithID:self.offer.stuffID
                                   successHandler:^(RKMappingResult *result) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       self.stuff = result.firstObject;
                                   }
                                     errorHandler:^(NSError *error) {
                                         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                         [CCStandardErrorHandler showErrorWithError:error];
                                     }];
    } else {
        [self.ioc_booksAPIProvider getBookWithID:self.offer.bookID
                                  successHandler:^(RKMappingResult *result) {
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            self.book = result.firstObject;
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }
    
    [self.ioc_APIProvider getUserWithID:self.offer.senderID
                         successHandler:^(RKMappingResult *result) {
                             self.sender = result.firstObject;
                         } errorHandler:^(NSError *error) {
                             [CCStandardErrorHandler showErrorWithError:error];
                         }];
}

- (void)setStuff:(CCStuff *)stuff
{
    _stuff = stuff;
    [self loadStuffInfo];
}

- (void)setBook:(CCBook *)book
{
    _book = book;
    [self loadBookInfo];
}

- (void)setSender:(CCUser *)sender
{
    _sender = sender;
    [self loadSenderInfo];
}

- (void)loadBookInfo
{
    self.stuffNameLabel.text = self.book.description;
}

- (void)loadOfferInfo
{
    self.offerText.text = self.offer.text;
}

- (void)loadStuffInfo
{
    self.stuffNameLabel.text = self.stuff.description;
}

- (void)loadSenderInfo
{
    NSURL *avatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.sender.avatar]];
    [self.senderAvatar setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    self.senderName.text = [NSString stringWithFormat:@"%@ %@",self.sender.firstName, self.sender.lastName];
}

- (IBAction)senderButtonDidPressed
{
    [self.senderDetailsTransaction performWithObject:self.sender];
}

- (IBAction)stuffDidPerssed
{
    if(self.stuff){
        [self.stuffDetailsTransaction performWithObject:self.stuff];
    } else {
        [self.bookDetailsTransaction performWithObject:self.book];
    }
        
}

- (IBAction)answerButtonDidPressed
{
    [self.ioc_dialogAPIProvider loadDialogWithUser:self.sender.uid SuccessHandler:^(id result) {
        [self.answerTransaction performWithObject:result];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
   
}

@end
