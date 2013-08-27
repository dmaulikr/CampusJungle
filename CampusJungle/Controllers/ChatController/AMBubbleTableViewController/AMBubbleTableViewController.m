//
//  AMBubbleTableViewController.m
//  BubbleTableDemo
//
//  Created by Andrea Mazzini on 30/06/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "AMBubbleTableViewController.h"
#import "AMBubbleTableCell.h"

#define kInputHeight 40.0f
#define kLineHeight 30.0f
#define kButtonWidth 78.0f


@interface AMBubbleTableViewController () <BubbleCellDelegate, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (strong, nonatomic) NSMutableDictionary*	options;

@property (nonatomic, strong) UIImageView*	imageInput;
@property (nonatomic, strong) UITextView*	textView;
@property (nonatomic, strong) UIImageView*	imageInputBack;
@property (nonatomic, strong) UIButton*		buttonSend;
@property (nonatomic, strong) NSDateFormatter *shortDateFormatter;
@property (nonatomic, strong) NSDateFormatter *longDateFormater;
@property (nonatomic, assign) float			previousTextFieldHeight;

@end

@implementation AMBubbleTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setupView]; 
    [self.tableView registerClass:[AMBubbleTableCell class] forCellReuseIdentifier:@"Cell"];
    self.shortDateFormatter = [[NSDateFormatter alloc] init];
    [self.shortDateFormatter setLocale:[NSLocale currentLocale]];
    [self.shortDateFormatter setDateFormat:@"HH:mm"];
    
    self.longDateFormater = [[NSDateFormatter alloc] init];
    [self.longDateFormater setLocale:[NSLocale currentLocale]];
    [self.longDateFormater setDateStyle:NSDateFormatterMediumStyle];	
    [self.longDateFormater setTimeStyle:NSDateFormatterShortStyle];
}

- (void)setBubbleTableOptions:(NSDictionary *)options
{
	[self.options addEntriesFromDictionary:options];
}

- (NSMutableDictionary*)options
{
	if (_options == nil) {
		_options = [[AMBubbleGlobals defaultOptions] mutableCopy];
	}
	return _options;
}

- (void)setTableStyle:(AMBubbleTableStyle)style
{
	switch (style) {
		case AMBubbleTableStyleDefault:
			[self.options addEntriesFromDictionary:[AMBubbleGlobals defaultStyleDefault]];
			break;
		case AMBubbleTableStyleSquare:
			[self.options addEntriesFromDictionary:[AMBubbleGlobals defaultStyleSquare]];
			break;
		case AMBubbleTableStyleFlat:
			[self.options addEntriesFromDictionary:[AMBubbleGlobals defaultStyleFlat]];
			break;
		default:
			break;
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleKeyboardWillShow:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleKeyboardWillHide:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupView
{
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																						action:@selector(handleTapGesture:)];
	// Table View
    CGRect tableFrame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - kInputHeight);
	self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
	[self.tableView addGestureRecognizer:gestureRecognizer];
	[self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[self.tableView setDataSource:self];
	[self.tableView setDelegate:self];
	[self.tableView setBackgroundColor:[UIColor colorWithRed:239./255 green:215./255 blue:171./255 alpha:1]];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.view addSubview:self.tableView];
	
    // Input background
    CGRect inputFrame = CGRectMake(0.0f, self.view.frame.size.height - kInputHeight, self.view.frame.size.width, kInputHeight);
	
	self.imageInput = [[UIImageView alloc] initWithImage:self.options[AMOptionsImageBar]];
	[self.imageInput setFrame:inputFrame];
	[self.imageInput setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin)];
	[self.imageInput setUserInteractionEnabled:YES];
	
	[self.view addSubview:self.imageInput];
	
	// Input field
	CGFloat width = self.imageInput.frame.size.width - kButtonWidth;
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(6.0f, 3.0f, width, kLineHeight)];
    [self.textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.textView setScrollIndicatorInsets:UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f)];
    [self.textView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [self.textView setScrollEnabled:NO];
    [self.textView setScrollsToTop:NO];
    [self.textView setUserInteractionEnabled:YES];
    [self.textView setFont:self.options[AMOptionsTextFieldFont]];
    [self.textView setTextColor:self.options[AMOptionsTextFieldFontColor]];
    [self.textView setBackgroundColor:self.options[AMOptionsTextFieldBackground]];
    [self.textView setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [self.textView setKeyboardType:UIKeyboardTypeDefault];
    [self.textView setReturnKeyType:UIReturnKeyDefault];
	[self.textView setDelegate:self];
    [self.imageInput addSubview:self.textView];
	self.previousTextFieldHeight = self.textView.contentSize.height;

	// Input field's background
    self.imageInputBack = [[UIImageView alloc] initWithFrame:CGRectMake(self.textView.frame.origin.x - 1.0f,
																		0.0f,
																		self.textView.frame.size.width + 2.0f,
																		self.imageInput.frame.size.height)];
    [self.imageInputBack setImage:self.options[AMOptionsImageInput]];
    [self.imageInputBack setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self.imageInputBack setBackgroundColor:[UIColor clearColor]];
	[self.imageInputBack setUserInteractionEnabled:NO];
    [self.imageInput addSubview:self.imageInputBack];

	// Send button
    self.buttonSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonSend setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin)];
    
    UIImage *sendBack = self.options[AMOptionsImageButton];
    UIImage *sendBackHighLighted = self.options[AMOptionsImageButtonHighlight];
    [self.buttonSend setBackgroundImage:sendBack forState:UIControlStateNormal];
    [self.buttonSend setBackgroundImage:sendBack forState:UIControlStateDisabled];
    [self.buttonSend setBackgroundImage:sendBackHighLighted forState:UIControlStateHighlighted];
    
    NSString *title = NSLocalizedString(@"Send",);
    [self.buttonSend setTitle:title forState:UIControlStateNormal];
    [self.buttonSend setTitle:title forState:UIControlStateHighlighted];
    [self.buttonSend setTitle:title forState:UIControlStateDisabled];
    self.buttonSend.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    
    UIColor *titleShadow = [UIColor colorWithRed:0.325f green:0.463f blue:0.675f alpha:1.0f];
    titleShadow = [UIColor clearColor];
    [self.buttonSend setTitleShadowColor:titleShadow forState:UIControlStateNormal];
    [self.buttonSend setTitleShadowColor:titleShadow forState:UIControlStateHighlighted];
    self.buttonSend.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);

    [self.buttonSend setTitleColor:[UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1] forState:UIControlStateNormal];
    [self.buttonSend setTitleColor:[UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1] forState:UIControlStateHighlighted];
    [self.buttonSend setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    
    [self.buttonSend setEnabled:NO];
    [self.buttonSend setFrame:CGRectMake(self.imageInput.frame.size.width - 65.0f, [self.options[AMOptionsButtonOffset] floatValue], 59.0f, 27.0f)];
    [self.buttonSend addTarget:self	action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
	
    [self.imageInput addSubview:self.buttonSend];
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataSource numberOfRows];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	AMBubbleCellType type = [self.dataSource cellTypeForRowAtIndexPath:indexPath];
	
	NSDate* date = [self.dataSource timestampForRowAtIndexPath:indexPath];
	AMBubbleTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	cell.delegate = self;
    cell.index = indexPath.row;

	NSString* stringDate;
	if (type == AMBubbleCellTimestamp) {
		stringDate = [self.longDateFormater stringFromDate:date];
		[cell setupCellWithType:type
					  withWidth:self.tableView.frame.size.width
					  andParams:@{ @"date": stringDate }];
	} else {
        UIImage* avatar;
        UIColor* color;
        if ([self.dataSource respondsToSelector:@selector(usernameColorForRowAtIndexPath:)]) {
            color = [self.dataSource usernameColorForRowAtIndexPath:indexPath];
        }
        if ([self.dataSource respondsToSelector:@selector(avatarForRowAtIndexPath:)]) {
            avatar = [self.dataSource avatarForRowAtIndexPath:indexPath];
        }
		NSString* username;
		if ([self.dataSource respondsToSelector:@selector(usernameForRowAtIndexPath:)]) {
			username = [self.dataSource usernameForRowAtIndexPath:indexPath];
		}
        NSString* text = [self.dataSource textForRowAtIndexPath:indexPath];
		stringDate = [self.shortDateFormatter stringFromDate:date];
		[cell setupCellWithType:type
					  withWidth:self.tableView.frame.size.width
					  andParams:@{
		 @"text": text,
		 @"date": stringDate,
		 @"username": (username ? username : @""),
		 @"avatar": (avatar ? avatar: @""),
		 @"color": (color ? color: @"")
		 }];
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	AMBubbleCellType type = [self.dataSource cellTypeForRowAtIndexPath:indexPath];
	NSString* text = [self.dataSource textForRowAtIndexPath:indexPath];
	NSString* username = [self.dataSource usernameForRowAtIndexPath:indexPath];
	
	if (type == AMBubbleCellTimestamp) {
		return [self.options[AMOptionsTimestampHeight] floatValue];
	}
    
    // Set MessageCell height.
    CGSize size = [text sizeWithFont:self.options[AMOptionsBubbleTextFont]
				   constrainedToSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
					   lineBreakMode:NSLineBreakByWordWrapping];
	
	CGSize usernameSize = CGSizeZero;
	
	if (![username isEqualToString:@""] && type == AMBubbleCellReceived) {
		usernameSize = [username sizeWithFont:self.options[AMOptionsTimestampFont]
							constrainedToSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
								lineBreakMode:NSLineBreakByWordWrapping];
	}
	
	// Account for either the bubble or accessory size
    return MAX(size.height + 17.0f + usernameSize.height,
			   [self.options[AMOptionsAccessorySize] floatValue] + [self.options[AMOptionsAccessoryMargin] floatValue]);
}

#pragma mark - Keyboard Handlers

- (void)handleKeyboardWillShow:(NSNotification *)notification
{
	[self resizeView:notification];
	[self scrollToBottomAnimated:YES];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
	[self resizeView:notification];	
}

- (void)resizeView:(NSNotification*)notification
{
	CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:curve << 16 // Options conversion, TODO: fix it
                     animations:^{
                         CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
						 CGFloat inputViewFrameY = keyboardY - self.imageInput.frame.size.height;
                         
                         self.imageInput.frame = CGRectMake(self.imageInput.frame.origin.x,
                                                           inputViewFrameY,
                                                           self.imageInput.frame.size.width,
                                                           self.imageInput.frame.size.height);
                         
						 CGFloat viewHeight = (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ? self.view.frame.size.width : self.view.frame.size.height;
                         UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
                                                                0.0f,
                                                                viewHeight - self.imageInput.frame.origin.y - kInputHeight,
                                                                0.0f);

						 
						 
                         self.tableView.contentInset = insets;
                         self.tableView.scrollIndicatorInsets = insets;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)resizeTextViewByHeight:(CGFloat)delta
{
	
	int numLines = self.textView.contentSize.height / self.textView.font.lineHeight;
    
	self.textView.contentInset = UIEdgeInsetsMake((numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f,
                                                  (numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f);
	
    self.textView.scrollEnabled = (numLines >= 4);
	
	// Adjust table view's insets
	CGFloat viewHeight = (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ? self.view.frame.size.width : self.view.frame.size.height;
	UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
										   0.0f,
										   viewHeight - self.imageInput.frame.origin.y - kInputHeight,
										   0.0f);

	self.tableView.contentInset = insets;
	self.tableView.scrollIndicatorInsets = insets;

	// Slightly scroll the table
	[self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y + delta) animated:YES];
}

- (void)handleTapGesture:(UIGestureRecognizer*)gesture
{
	[self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
	// TODO: trim white spaces
	[self.buttonSend setEnabled:(textView.text.length > 0)];

	CGFloat maxHeight = self.textView.font.lineHeight * 5;
	CGFloat textViewContentHeight = textView.contentSize.height;
	CGFloat delta = textViewContentHeight - self.previousTextFieldHeight;
	BOOL isShrinking = textViewContentHeight < self.previousTextFieldHeight;

	delta = (textViewContentHeight + delta >= maxHeight) ? 0.0f : delta;

	
	if(!isShrinking)
        [self resizeTextViewByHeight:delta];
    
    if(delta != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 0.0f, self.tableView.contentInset.bottom + delta, 0.0f);
                             self.tableView.contentInset = insets;
                             self.tableView.scrollIndicatorInsets = insets;
							 
                             [self scrollToBottomAnimated:NO];
							 
                             self.imageInput.frame = CGRectMake(0.0f,
                                                               self.imageInput.frame.origin.y - delta,
                                                               self.imageInput.frame.size.width,
                                                               self.imageInput.frame.size.height + delta);
                         }
                         completion:^(BOOL finished) {
                             if(isShrinking)
                                 [self resizeTextViewByHeight:delta];
                         }];
        
        self.previousTextFieldHeight = MIN(textViewContentHeight, maxHeight);
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger bottomRow = [self.dataSource numberOfRows] - 1;
    if (bottomRow >= 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bottomRow inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath
						  atScrollPosition:UITableViewScrollPositionMiddle animated:animated];
    
    }
}

- (void)sendPressed:(id)sender
{
	[self.delegate didSendText:self.textView.text];
	[self.textView setText:@""];
	[self textViewDidChange:self.textView];
	[self resizeTextViewByHeight:self.textView.contentSize.height - self.previousTextFieldHeight];
	self.previousTextFieldHeight = self.textView.contentSize.height;
    [self.buttonSend setEnabled:NO];
    double delayInSeconds = 0.4;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self scrollToBottomAnimated:YES];
    });
	
    
}

- (void)reloadTableScrollingToBottom:(BOOL)scroll
{
	[self.tableView reloadData];
	if (scroll) {
		[self scrollToBottomAnimated:YES];
	}
}

- (void)reloadTableScrollingToBottomWitoutAnimation
{
	[self.tableView reloadData];
    [self scrollToBottomAnimated:NO];
}



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self.tableView reloadData];
}



@end
