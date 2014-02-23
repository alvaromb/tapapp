//
//  TATapaViewController.m
//  Tapapp
//
//  Created by Álvaro on 23/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TATapaViewController.h"

@interface TATapaViewController ()

@property (strong, nonatomic) UILabel *descripcionLabel;
@property (strong, nonatomic) UIImageView *tapaImageView;

@end

@implementation TATapaViewController

#pragma mark - Lazy instantiation

- (UILabel *)descripcionLabel
{
    if (!_descripcionLabel) {
        _descripcionLabel = [[UILabel alloc] init];
        _descripcionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _descripcionLabel.textColor = [UIColor blackColor];
        _descripcionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descripcionLabel;
}

- (UIImageView *)tapaImageView
{
    if (!_tapaImageView) {
        _tapaImageView = [[UIImageView alloc] init];
        _tapaImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _tapaImageView;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
        self.view.backgroundColor = [UIColor whiteColor];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.descripcionLabel];
    [self.view addSubview:self.tapaImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.descripcionLabel.frame = CGRectMake(0, self.view.bounds.size.width + 10, self.view.bounds.size.width, 20);
    self.tapaImageView.frame    = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    
    self.title = self.tapa.nombre;
//    self.descripcionLabel.text = self.tapa.
    [self.tapaImageView setImageWithURL:[NSURL URLWithString:self.tapa.path_imagen]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
