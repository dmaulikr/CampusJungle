//
//  CCProfessorUploadsCell.h
//  CampusJungle
//
//  Created by Vlad Korzun on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseCell.h"
#import "CCProfessorUpload.h"

@protocol CCUploadsCellDelegate <NSObject>

- (void)deleteUploads:(CCProfessorUpload *)upload;
- (void)emailAttachmentOfUploads:(CCProfessorUpload *)upload;
- (void)viewAttachmentOfUplads:(CCProfessorUpload *)upload;

@end

@interface CCProfessorUploadsCell : CCBaseCell

@property (nonatomic, strong) CCProfessorUpload *cellObject;

- (void)setCellObject:(CCProfessorUpload *)object;
- (void)setDelegate:(id<CCUploadsCellDelegate>) delegate;


@end
