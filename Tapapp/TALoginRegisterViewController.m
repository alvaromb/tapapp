//
//  TALoginRegisterViewController.m
//  Tapapp
//
//  Created by Álvaro on 26/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TALoginRegisterViewController.h"

@interface TALoginRegisterViewController ()

@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *nombreTextField;
@property (strong, nonatomic) UIButton *switchRegisterButton;
@property (strong, nonatomic) UIButton *sendFormButton;
@property (nonatomic) BOOL isRegistering;

@end

@implementation TALoginRegisterViewController

#pragma mark - Lazy instantiation

- (UITextField *)emailTextField
{
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc] init];
        _emailTextField.placeholder = @"E-mail";
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
//        _emailTextField.backgroundColor = [UIColor redColor];
    }
    return _emailTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"Contraseña";
        _passwordTextField.secureTextEntry = YES;
//        _passwordTextField.backgroundColor = [UIColor blueColor];
    }
    return _passwordTextField;
}

- (UITextField *)usernameTextField
{
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.placeholder = @"Nombre de usuario";
//        _usernameTextField.backgroundColor = [UIColor greenColor];
    }
    return _usernameTextField;
}

- (UITextField *)nombreTextField
{
    if (!_nombreTextField) {
        _nombreTextField = [[UITextField alloc] init];
        _nombreTextField.placeholder = @"Nombre completo";
//        _nombreTextField.backgroundColor = [UIColor orangeColor];
    }
    return _nombreTextField;
}

- (UIButton *)switchRegisterButton
{
    if (!_switchRegisterButton) {
        _switchRegisterButton = [[UIButton alloc] init];
        [_switchRegisterButton setTitle:@"Pulsa aqui si ya tienes cuenta" forState:UIControlStateNormal];
        [_switchRegisterButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_switchRegisterButton addTarget:self action:@selector(switchRegisterLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchRegisterButton;
}

- (UIButton *)sendFormButton
{
    if (!_sendFormButton) {
        _sendFormButton = [[UIButton alloc] init];
        [_sendFormButton setTitle:@"Enviar" forState:UIControlStateNormal];
        [_sendFormButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_sendFormButton addTarget:self action:@selector(sendRegisterLogin) forControlEvents:UIControlEventTouchUpInside];
        [_sendFormButton sizeToFit];
    }
    return _sendFormButton;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Registro";
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -10;
        UIBarButtonItem *sendFormBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.sendFormButton];
        self.navigationItem.rightBarButtonItems = @[space, sendFormBarButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.nombreTextField];
    [self.view addSubview:self.switchRegisterButton];
    self.isRegistering = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.emailTextField.frame       = CGRectMake(10, 50, 300, 25);
    self.passwordTextField.frame    = CGRectMake(10, 80, 300, 25);
    self.usernameTextField.frame    = CGRectMake(10, 110, 300, 25);
    self.nombreTextField.frame      = CGRectMake(10, 140, 300, 25);
    self.switchRegisterButton.frame = CGRectMake(10, 250, 300, 30);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.emailTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)switchRegisterLogin
{
    void (^switchLoginRegister)(void);
    if (self.isRegistering) {
        switchLoginRegister = ^(void){
            self.title = @"Login";
            self.usernameTextField.alpha = 0;
            self.nombreTextField.alpha = 0;
            [self.switchRegisterButton setTitle:@"Pulsa aqui para registrarte" forState:UIControlStateNormal];
        };
    }
    else {
        switchLoginRegister = ^(void){
            self.title = @"Registro";
            self.usernameTextField.alpha = 1;
            self.nombreTextField.alpha = 1;
            [self.switchRegisterButton setTitle:@"Pulsa aqui si ya tienes cuenta" forState:UIControlStateNormal];
        };
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        switchLoginRegister();
    }];
    self.isRegistering = !self.isRegistering;
}

- (void)sendRegisterLogin
{
    [self.delegate loginRegisterDidFinishedWithSuccess:self];
}

@end
