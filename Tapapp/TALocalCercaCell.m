//
//  TALocalCercaCell.m
//  Tapapp
//
//  Created by Álvaro on 10/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TALocalCercaCell.h"

@implementation TALocalCercaCell

#pragma mark - Lazy instantiation

- (UIImageView *)localImageView
{
    if (!_localImageView) {
        _localImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _localImageView;
}

- (UILabel *)localLabel
{
    if (!_localLabel) {
        _localLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _localLabel;
}

- (UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _distanceLabel;
}


#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.localLabel];
        [self.contentView addSubview:self.localImageView];
        [self.contentView addSubview:self.distanceLabel];
    }
    return self;
}

@end
