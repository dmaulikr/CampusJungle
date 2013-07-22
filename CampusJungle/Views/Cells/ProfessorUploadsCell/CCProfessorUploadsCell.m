//
//  CCProfessorUploadsCell.m
//  CampusJungle
//
//  Created by Vlad Korzun on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUploadsCell.h"
#import "CCPluralizeHelper.h"
#import "CCViewPositioningHelper.h"
#import "CCUserSessionProtocol.h"
#import "MACircleProgressIndicator.h"

#import "CCDateFormatterProtocol.h"

static const NSInteger kTextLabelOriginY = 77;
static const NSInteger kDefaultTextLabelWidth = 272;
static const NSInteger kBottomSpace = 5;
static const NSInteger kAttachmentViewHeight = 34;
static const CGFloat kMinCellHeight = 63;


@interface CCProfessorUploadsCell()<CCUploadIndicatorDelegateProtocol>

@property (nonatomic, weak) IBOutlet UIImageView *ownerAvatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdAtLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionTextLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteQuestionButton;

@property (nonatomic, weak) IBOutlet UIView *attachmentView;
@property (nonatomic, weak) IBOutlet UIButton *emailAttachmentButton;
@property (nonatomic, weak) IBOutlet UIButton *viewAttachmentButton;

@property (nonatomic, strong) CCProfessorUpload *professorUpload;
@property (nonatomic, weak) id<CCUploadsCellDelegate> delegate;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDateFormatterProtocol> ioc_dateFormatterHelper;
@property (nonatomic, weak) IBOutlet MACircleProgressIndicator *indicator;


@end

@implementation CCProfessorUploadsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionColor];
    
    [self.deleteQuestionButton addTarget:self action:@selector(deleteQuestionButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.emailAttachmentButton addTarget:self action:@selector(emailAttachmentButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewAttachmentButton addTarget:self action:@selector(viewAttachmentButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CCButtonsHelper removeBackgroundImageInButton:self.deleteQuestionButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.emailAttachmentButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.viewAttachmentButton];
}

- (void)prepareForReuse
{
    [CCViewPositioningHelper setWidth:kDefaultTextLabelWidth toView:self.questionTextLabel];
}

- (void)setCellObject:(CCProfessorUpload *)object
{
    if(object.uploadProgress){
        [self setUpUploadingIndicatorWithObject:object];
    } else {
        [self removeIndicator];
    }
    _cellObject = object;
    self.professorUpload = object;
    [self fillLabels];
    [self fillImageView];
    [self setDeleteButtonVisibility];
    [self setAttachmentViewVisibility];
}

- (void)fillLabels
{
    [self.ownerNameLabel setText:[NSString stringWithFormat:@"%@ %@", self.professorUpload.ownerFirstName, self.professorUpload.ownerLastName]];
    [self.questionTextLabel setText:self.professorUpload.text];
    [self.createdAtLabel setText:[self.ioc_dateFormatterHelper formatedDateStringFromDate:self.professorUpload.createdDate]];
    
    [self.questionTextLabel sizeToFit];
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.questionTextLabel] toView:self.attachmentView];
}

- (void)fillImageView
{
    NSURL *ownerAvatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL, self.professorUpload.ownerAvatar]];
    [self.ownerAvatarImageView setImageWithURL:ownerAvatarUrl placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
}

- (void)setDeleteButtonVisibility
{
    BOOL isHidden = YES;
    if ([self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.professorUpload.ownerID]) {
        isHidden = NO;
    }
    [self.deleteQuestionButton setHidden:isHidden];
}

- (void)setAttachmentViewVisibility
{
    if ([self.professorUpload.attachment length] > 0 && ![self.professorUpload uploadProgress]) {
        [self.attachmentView setHidden:NO];
    }
    else {
        [self.attachmentView setHidden:YES];
    }
}

+ (CGFloat)heightForCellWithObject:(CCProfessorUpload *)upload
{
    UIFont *font = [UIFont fontWithName:@"Avenir-MediumOblique" size:15];
    CGSize requiredSize = [upload.text sizeWithFont:font constrainedToSize:CGSizeMake(kDefaultTextLabelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat additionalAttachmentHeight = [upload.attachment length] > 0 ? kAttachmentViewHeight : 0;
    return MAX(kMinCellHeight + additionalAttachmentHeight, kTextLabelOriginY + requiredSize.height + kBottomSpace + additionalAttachmentHeight - 20);
}

#pragma mark -
#pragma mark Actions
- (void)deleteQuestionButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteUploads:)]) {
        [self.delegate deleteUploads:self.professorUpload];
    }
}


- (void)emailAttachmentButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emailAttachmentOfUploads:)]) {
        [self.delegate emailAttachmentOfUploads:self.professorUpload];
    }
}

- (void)viewAttachmentButtonDidPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewAttachmentOfUplads:)]) {
        [self.delegate viewAttachmentOfUplads:self.professorUpload];
    }
}

- (void)setUpUploadingIndicatorWithObject:(CCProfessorUpload *)object
{
    self.indicator.color = [UIColor brownColor];
    if(_cellObject.uploadProgress){
        [(CCProfessorUpload *)_cellObject setDelegate:nil];
    }
    object.delegate = self;
    self.indicator.value = object.uploadProgress.floatValue;
    self.indicator.hidden = NO;
    self.deleteQuestionButton.hidden = YES;
}

- (void)uploadProgressDidUpdate
{
    self.indicator.value = [(CCProfessorUpload *)self.cellObject uploadProgress].floatValue;
}

- (void)removeIndicator
{
    self.indicator.hidden = YES;
    self.deleteQuestionButton.hidden = NO;
    [self setAttachmentViewVisibility];
}

@end
