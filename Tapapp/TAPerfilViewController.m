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
@property (strong, nonatomic) UILabel *fullNameLabel;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *checkinLabel;
@property (strong, nonatomic) UILabel *checkinNumberLabel;
@property (strong, nonatomic) UILabel *commentsLabel;
@property (strong, nonatomic) UILabel *commentsNumberLabel;
@property (strong, nonatomic) UILabel *favsLabel;
@property (strong, nonatomic) UILabel *favsNumberLabel;
@property (strong, nonatomic) UILabel *commentAuthorLabel;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UIButton *logoutButton;

@end

@implementation TAPerfilViewController

#pragma mark - Lazy instantiation

- (UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
    }
    return _userImageView;
}

- (UILabel *)fullNameLabel
{
    if (!_fullNameLabel) {
        _fullNameLabel = [[UILabel alloc] init];
        _fullNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:22];
        _fullNameLabel.textColor = [UIColor whiteColor];
        _fullNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _fullNameLabel;
}

- (UILabel *)usernameLabel
{
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
        _usernameLabel.textColor = [UIColor whiteColor];
        _usernameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _usernameLabel;
}

- (UILabel *)checkinLabel
{
    if (!_checkinLabel) {
        _checkinLabel = [[UILabel alloc] init];
        _checkinLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
        _checkinLabel.textColor = [UIColor whiteColor];
        _checkinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _checkinLabel;
}

- (UILabel *)checkinNumberLabel
{
    if (!_checkinNumberLabel) {
        _checkinNumberLabel = [[UILabel alloc] init];
        _checkinNumberLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:48];
        _checkinNumberLabel.textColor = [UIColor whiteColor];
        _checkinNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _checkinNumberLabel;
}

- (UILabel *)commentsLabel
{
    if (!_commentsLabel) {
        _commentsLabel = [[UILabel alloc] init];
        _commentsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
        _commentsLabel.textColor = [UIColor whiteColor];
        _commentsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commentsLabel;
}

- (UILabel *)commentsNumberLabel
{
    if (!_commentsNumberLabel) {
        _commentsNumberLabel = [[UILabel alloc] init];
        _commentsNumberLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:48];
        _commentsNumberLabel.textColor = [UIColor whiteColor];
        _commentsNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commentsNumberLabel;
}

- (UILabel *)favsLabel
{
    if (!_favsLabel) {
        _favsLabel = [[UILabel alloc] init];
        _favsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
        _favsLabel.textColor = [UIColor whiteColor];
        _favsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _favsLabel;
}

- (UILabel *)favsNumberLabel
{
    if (!_favsNumberLabel) {
        _favsNumberLabel = [[UILabel alloc] init];
        _favsNumberLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:48];
        _favsNumberLabel.textColor = [UIColor whiteColor];
        _favsNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _favsNumberLabel;
}

- (UILabel *)commentAuthorLabel
{
    if (!_commentAuthorLabel) {
        _commentAuthorLabel = [[UILabel alloc] init];
        _commentAuthorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        _commentAuthorLabel.textColor = [UIColor whiteColor];
        _commentAuthorLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _commentAuthorLabel;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont fontWithName:@"HelveticaNeue-ThinItalic" size:15];
        _commentLabel.textColor = [UIColor whiteColor];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}

- (UIButton *)logoutButton
{
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc] init];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

#pragma mark - Lifecycle

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
    [self.view addSubview:self.userImageView];
    [self.view addSubview:self.fullNameLabel];
    [self.view addSubview:self.usernameLabel];
    [self.view addSubview:self.checkinLabel];
    [self.view addSubview:self.checkinNumberLabel];
    [self.view addSubview:self.commentsLabel];
    [self.view addSubview:self.commentsNumberLabel];
    [self.view addSubview:self.favsLabel];
    [self.view addSubview:self.favsNumberLabel];
    [self.view addSubview:self.commentAuthorLabel];
    [self.view addSubview:self.commentLabel];
    [self.view addSubview:self.logoutButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.backgroundImageView.frame = self.view.bounds;
    self.userImageView.frame        = CGRectMake(ceil(self.view.bounds.size.width/2 - 40), 20, 80, 80);
    self.fullNameLabel.frame        = CGRectMake(0, 120, self.view.bounds.size.width, 26);
    self.usernameLabel.frame        = CGRectMake(0, 150, self.view.bounds.size.width, 20);
    self.checkinLabel.frame         = CGRectMake(10, 200, 90, 18);
    self.commentsLabel.frame        = CGRectMake(115, 200, 90, 18);
    self.favsLabel.frame            = CGRectMake(220, 200, 90, 18);
    self.checkinNumberLabel.frame   = CGRectMake(10, 220, 90, 50);
    self.commentsNumberLabel.frame  = CGRectMake(115, 220, 90, 50);
    self.favsNumberLabel.frame      = CGRectMake(220, 220, 90, 50);
    self.commentAuthorLabel.frame   = CGRectMake(20, 275, 280, 20);
    self.commentLabel.frame         = CGRectMake(20, 300, 280, 150);
    self.logoutButton.frame         = CGRectMake(20, 400, 150, 30);
    
    [self configureUserData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[TATappapAPI sharedInstance] getSelfUserWithCompletionBlock:^(id response) {
        [self configureUserData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)configureUserData
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_code"];
    User *userProfile = [User MR_findFirstByAttribute:@"identifier" withValue:userId];
    
    __weak UIImageView *weakUserImageView = self.userImageView;
    NSString *imagePath = userProfile.path_imagen;
    [self.userImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imagePath]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        weakUserImageView.image = [[image resizedImage:CGSizeMake(160, 160) interpolationQuality:kCGInterpolationDefault] roundedCornerImage:80 borderSize:0];
    } failure:nil];
    
    self.fullNameLabel.text = userProfile.nombre;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", userProfile.username];
    self.checkinLabel.text = @"Check-ins";
    self.commentsLabel.text = @"Comentarios";
    self.favsLabel.text = @"Favoritos";
    self.checkinNumberLabel.text = [userProfile.checkins stringValue];
    self.commentsNumberLabel.text = [userProfile.comments stringValue];
    self.favsNumberLabel.text = [userProfile.favoritos stringValue];
    Comentario *comentario = [userProfile.comentarios anyObject];
    if (comentario) {
        self.commentAuthorLabel.text = [NSString stringWithFormat:@"@%@ en %@", userProfile.username, comentario.local.nombre];
        self.commentLabel.text = comentario.texto;
        [self.commentLabel sizeToFit];
    }
}

- (void)logoutAction
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"locationAvailable" object:nil];
    }];
}

@end
