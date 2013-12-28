//
//  TATapaCell.m
//  Tapapp
//
//  Created by Álvaro on 27/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TATapaCell.h"

@implementation TATapaCell

- (UILabel *)tapaLabel
{
    if (!_tapaLabel) {
        _tapaLabel = [[UILabel alloc] init];
        _tapaLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    }
    return _tapaLabel;
}

- (UILabel *)distanciaLabel
{
    if (!_distanciaLabel) {
        _distanciaLabel = [[UILabel alloc] init];
        _distanciaLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _distanciaLabel.textColor = [UIColor lightGrayColor];
    }
    return _distanciaLabel;
}

- (UIImageView *)tapaImageView
{
    if (!_tapaImageView) {
        _tapaImageView = [[UIImageView alloc] init];
        _tapaImageView.backgroundColor = [UIColor grayColor];
    }
    return _tapaImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.tapaLabel];
        [self.contentView addSubview:self.distanciaLabel];
        [self.contentView addSubview:self.tapaImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tapaLabel.frame = CGRectMake(5, 0, 270, 22);
    self.distanciaLabel.frame = CGRectMake(5, 22, 270, 18);
    self.tapaImageView.frame = CGRectMake(270, 0, 50, 50);
}

@end
