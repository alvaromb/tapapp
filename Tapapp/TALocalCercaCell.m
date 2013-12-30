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
        _localImageView.contentMode = UIViewContentModeScaleAspectFill;
        _localImageView.clipsToBounds = YES;
        _localImageView.backgroundColor = [UIColor grayColor];
    }
    return _localImageView;
}

- (UILabel *)localLabel
{
    if (!_localLabel) {
        _localLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _localLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    }
    return _localLabel;
}

- (UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _distanceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _distanceLabel.textColor = [UIColor lightGrayColor];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.localLabel.frame = CGRectMake(5, 0, 270, 22);
    self.distanceLabel.frame = CGRectMake(5, 22, 270, 18);
    self.localImageView.frame = CGRectMake(270, 0, 50, 50);
}

@end
