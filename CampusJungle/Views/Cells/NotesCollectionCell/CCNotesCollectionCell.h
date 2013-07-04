//
//  CCNotesCollectionCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableCellProtocol.h"

@interface CCNotesCollectionCell : UICollectionViewCell<CCTableCellProtocol>

@property (nonatomic, strong) id cellObject;

@end
