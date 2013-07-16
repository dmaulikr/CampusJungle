//
//  CCTableBaseViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCDefines.h"

@interface CCTableBaseViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UITextField *hidedTextField;

@end

@implementation CCTableBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSearchBar];
    self.tapRecognizer.enabled = NO;
    self.reloadingTableViewWithActiveSearchBar = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addTableViewObservers];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeTableViewObservers];
}

- (void)addTableViewObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewWillReloadData) name:CCNotificationsNames.tableViewWillReloadData object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewDidReloadData) name:CCNotificationsNames.tableViewDidReloadData object:nil];
}

- (void)removeTableViewObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.tableViewWillReloadData object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.tableViewDidReloadData object:nil];
}

- (void)configSearchBar
{
    [self setNilButtonBackgroundForView:self.searchBar];
}

- (void)setNilButtonBackgroundForView:(UIView *)view
{
    for(UIButton *button in view.subviews){
        if([button isKindOfClass:[UIButton class]]){
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            [button setBackgroundImage:nil forState:UIControlStateHighlighted];
        } else {
            [self setNilButtonBackgroundForView:button];
        }
    }
}

- (void)configTableWithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    [self configTableWithProvider:provider cellClass:cellCass cellReuseIdentifier:CCTableDefines.tableCellIdentifier];
}

- (void)configTableWithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass cellReuseIdentifier:(NSString *)reuseIdentifier
{
    [self.mainTable registerClass:cellCass forCellReuseIdentifier:reuseIdentifier];
    CCCommonDataSource *dataSource;
    self.mainTable.backgroundColor = [UIColor clearColor];
    if(self.dataSource){
        dataSource = self.dataSource;
    } else if (self.dataSourceClass){
        dataSource = [self.dataSourceClass new];
    } else {
        dataSource = [CCCommonDataSource new];
    }
    dataSource.currentCellReuseIdentifier = reuseIdentifier;
    [dataSource.registeredCellClasses setObject:cellCass forKey:reuseIdentifier];
    dataSource.dataProvider = provider;
    dataSource.dataProvider.targetTable = self.mainTable;
    self.mainTable.dataSource = dataSource;
    self.mainTable.delegate = dataSource;
    self.dataSource = dataSource;
    self.dataSource.delegate = self;
    [dataSource.dataProvider loadItems];
}

#pragma mark -
#pragma mark Actions
- (void)didSelectedCellWithObject:(id)cellObject
{
    
}

- (void)tableViewWillReloadData
{
    if ([self.searchBar isFirstResponder]) {
        if (!self.hidedTextField) {
            self.hidedTextField = [self hiddenTextField];
            [self.view insertSubview:self.hidedTextField atIndex:0];
        }
        self.reloadingTableViewWithActiveSearchBar = YES;
        [self.hidedTextField becomeFirstResponder];
    }
}

- (void)tableViewDidReloadData
{
    if (self.reloadingTableViewWithActiveSearchBar) {
        [self.searchBar becomeFirstResponder];
        self.reloadingTableViewWithActiveSearchBar = NO;
        if ([self.mainTable isKindOfClass:[TPKeyboardAvoidingTableView class]]) {
            [self.mainTable performSelector:@selector(adjustOffsetToIdealIfNeeded) withObject:nil afterDelay:0.3];
        }
    }
}

- (UITextField *)hiddenTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:self.mainTable.frame];
    [textField setReturnKeyType:UIReturnKeySearch];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    return textField;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self performSelector:@selector(configSearchBar) withObject:nil afterDelay:0.01];
    self.dataSource.dataProvider.searchQuery = searchText;
    self.lastSearchPressTime = [NSDate date];
    
    double delayInSeconds = 1.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    __weak CCTableBaseViewController *weakSelf = self;
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[NSDate date] timeIntervalSinceDate:weakSelf.lastSearchPressTime] >= 1){
            [weakSelf.dataSource.dataProvider loadItems];
        }
    });
}

@end
