//
//  CCStuffHeader.m
//  CampusJungle
//
//  Created by Yury Grinenko on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffHeader.h"
#import "CCStuff.h"
#import "CCUserSessionProtocol.h"
#import "CCViewPositioningHelper.h"
#import "CCBook.h"

@interface CCStuffHeader ()

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIButton *offerButton;
@property (nonatomic, weak) IBOutlet UIButton *deleteStuffButton;
@property (nonatomic, weak) IBOutlet UILabel *isbnLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionTitle;

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) CCStuff *stuff;
@property (nonatomic, weak) id<CCStuffHeaderDelegate> delegate;

@end

@implementation CCStuffHeader

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    return self;
}

- (void)setStuff:(CCStuff *)stuff
{
    _stuff = stuff;
    [self setupLabels];
    [self setupButtons];
    [self setupImageView];
}

- (void)setupLabels
{
    [self.nameLabel setText:self.stuff.name];
    [self.priceLabel setText:[NSString stringWithFormat:@"Price: $%0.2lf", self.stuff.priceInDolars.doubleValue]];
    if([self.stuff isKindOfClass:[CCBook class]] && [(CCBook *)self.stuff isbn]){
        self.isbnLabel.text = [NSString stringWithFormat:@"ISBN : %@",[(CCBook *)self.stuff isbn]];
        [CCViewPositioningHelper setOriginY:self.descriptionLabel.frame.origin.y + 20 toView:self.descriptionLabel];
        [CCViewPositioningHelper setOriginY:self.descriptionTitle.frame.origin.y + 20 toView:self.descriptionTitle];
    }
    [self.descriptionLabel setText:self.stuff.description];
    [self.descriptionLabel sizeToFit];
    [self fixLayout];
}

- (void)setupImageView
{
    if (self.stuff.thumbnailRetina.length){
        NSURL *thumbURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.stuff.thumbnailRetina]];
        [self.thumbnailImageView setImageWithURL:thumbURL];
    }
    else {
        self.thumbnailImageView.image = [UIImage imageNamed:@"stuff_placeholder_icon_active"];
    }
}

- (void)setupButtons
{
     if([self.stuff isKindOfClass:[CCBook class]]){
         [self.deleteStuffButton setTitle:@"Delete Book" forState:UIControlStateNormal];
     }
    if ([self isMyStuff]) {
        [self.offerButton setHidden:YES];
    }
    else {
        [self.deleteStuffButton setHidden:YES];
    }
}

- (void)fixLayout
{
    [CCViewPositioningHelper setHeight:[CCViewPositioningHelper bottomOfView:self.descriptionLabel] + 10 toView:self];
}

- (BOOL)isMyStuff
{
    CCUser *currentUser = [self.ioc_userSession currentUser];
    NSString *currentUserID = currentUser.uid;
    
    if ([self.stuff.ownerID isEqualToString:currentUserID]) {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark Actions
- (IBAction)deleteButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteStuffButtonDidPressed:)]) {
        [self.delegate deleteStuffButtonDidPressed:sender];
    }
}

- (IBAction)makeOfferButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(makeOfferButtonDidPressed:)]) {
        [self.delegate makeOfferButtonDidPressed:sender];
    }
}

@end
