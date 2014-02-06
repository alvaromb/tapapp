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
@property (strong, nonatomic) UIButton *profileImageButton;
@property (strong, nonatomic) UIButton *switchRegisterButton;
@property (strong, nonatomic) UIButton *sendFormButton;
@property (nonatomic, getter = isRegistering) BOOL registering;

@end

@implementation TALoginRegisterViewController

#pragma mark - Lazy instantiation

- (UITextField *)emailTextField
{
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc] init];
        _emailTextField.placeholder = @"E-mail";
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return _emailTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"Contraseña";
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UITextField *)usernameTextField
{
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.placeholder = @"Nombre de usuario";
    }
    return _usernameTextField;
}

- (UITextField *)nombreTextField
{
    if (!_nombreTextField) {
        _nombreTextField = [[UITextField alloc] init];
        _nombreTextField.placeholder = @"Nombre completo";
    }
    return _nombreTextField;
}

- (UIButton *)profileImageButton
{
    if (!_profileImageButton) {
        _profileImageButton = [[UIButton alloc] init];
        _profileImageButton.backgroundColor = [UIColor lightGrayColor];
        _profileImageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _profileImageButton.imageView.clipsToBounds = YES;
        [_profileImageButton addTarget:self action:@selector(openPhotoPicker) forControlEvents:UIControlEventTouchUpInside];
    }
    return _profileImageButton;
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
    [self.view addSubview:self.profileImageButton];
    [self.view addSubview:self.switchRegisterButton];
    self.registering = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.emailTextField.frame       = CGRectMake(10, 10, 300, 25);
    self.passwordTextField.frame    = CGRectMake(10, 40, 300, 25);
    self.usernameTextField.frame    = CGRectMake(10, 70, 300, 25);
    self.nombreTextField.frame      = CGRectMake(10, 100, 300, 25);
    self.profileImageButton.frame   = CGRectMake(10, 135, 50, 50);
    self.switchRegisterButton.frame = CGRectMake(10, 210, 300, 30);
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

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (nil == image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self.profileImageButton setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    if (buttonIndex == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if (buttonIndex == 1) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        return;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Actions

- (void)openPhotoPicker
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Foto de perfil"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancelar"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Album", @"Camara", nil];
    [actionSheet showInView:self.view];
}

- (void)switchRegisterLogin
{
    void (^switchLoginRegister)(void);
    if (self.isRegistering) {
        switchLoginRegister = ^(void){
            self.title = @"Login";
            self.emailTextField.alpha = 0;
            self.nombreTextField.alpha = 0;
            self.profileImageButton.alpha = 0;
            [self.switchRegisterButton setTitle:@"Pulsa aqui para registrarte" forState:UIControlStateNormal];
        };
    }
    else {
        switchLoginRegister = ^(void){
            self.title = @"Registro";
            self.emailTextField.alpha = 1;
            self.nombreTextField.alpha = 1;
            self.profileImageButton.alpha = 1;
            [self.switchRegisterButton setTitle:@"Pulsa aqui si ya tienes cuenta" forState:UIControlStateNormal];
        };
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        switchLoginRegister();
    }];
    self.registering = !self.isRegistering;
}

- (void)sendRegisterLogin
{
    if (self.isRegistering) {
        [[TATappapAPI sharedInstance]
         registerWithEmail:self.emailTextField.text
         password:self.passwordTextField.text
         username:self.usernameTextField.text
         name:self.nombreTextField.text
         image:self.profileImageButton.imageView.image
         completionBlock:^(id response) {
             [self dismissViewControllerAnimated:YES completion:^{
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"locationAvailable" object:nil];
             }];
         }];
    }
    else {
        [[TATappapAPI sharedInstance]
         loginWithUsername:self.usernameTextField.text
         password:self.passwordTextField.text
         completionBlock:^(id response) {
             NSLog(@"Me he logueado");
         }];
    }
//    [self.delegate loginRegisterDidFinishedWithSuccess:self];
}

@end
