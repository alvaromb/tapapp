//
//  TAPerfilViewController.m
//  Tapapp
//
//  Created by alvaro on 25/11/13.
//  Copyright (c) 2013 alvaromb. All rights reserved.
//

#import "TAPerfilViewController.h"

@interface TAPerfilViewController ()

@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *userImageView;

@end

@implementation TAPerfilViewController

- (UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
    }
    return _userImageView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"perfil.png"];
        self.title = @"Perfil";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"perfil-bg.png"]];
	[self.view addSubview:self.backgroundImageView];
    UIImage *originalImage = [UIImage imageNamed:@"alvaro.png"];
    self.userImageView.image = [[originalImage resizedImage:(CGSize){120, 120} interpolationQuality:kCGInterpolationDefault] roundedCornerImage:60 borderSize:0];
    [self.view addSubview:self.userImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.backgroundImageView.frame = self.view.bounds;
    self.userImageView.frame = CGRectMake(ceil(self.view.bounds.size.width/2 - 30), 150, 60, 60);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
