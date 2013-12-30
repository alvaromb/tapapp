//
//  TANuevoBarViewController.m
//  Tapapp
//
//  Created by Álvaro on 30/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TANuevoBarViewController.h"

@interface TANuevoBarViewController ()

@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UIButton *newBarButton;
@property (strong, nonatomic) UITextField *nombreTextField;
@property (strong, nonatomic) UITextField *descripcionTextField;
@property (strong, nonatomic) UISwitch *creditCardSwitch;
@property (strong, nonatomic) UILabel *creditCardLabel;
@property (strong, nonatomic) UIButton *addPhotoButton;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIButton *selectedImageButton;

@end

@implementation TANuevoBarViewController

#pragma mark - Lazy instantiation

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_closeButton setTitle:@"Cancelar" forState:UIControlStateNormal];
        [_closeButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(cancelCheckIn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)newBarButton
{
    if (!_newBarButton) {
        _newBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_newBarButton setTitle:@"Crear" forState:UIControlStateNormal];
        [_newBarButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_newBarButton addTarget:self action:@selector(createBar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newBarButton;
}

- (UITextField *)nombreTextField
{
    if (!_nombreTextField) {
        _nombreTextField = [[UITextField alloc] init];
        _nombreTextField.placeholder = @"Nombre del local";
    }
    return _nombreTextField;
}

- (UITextField *)descripcionTextField
{
    if (!_descripcionTextField) {
        _descripcionTextField = [[UITextField alloc] init];
        _descripcionTextField.placeholder = @"Descripcion";
    }
    return _descripcionTextField;
}

- (UISwitch *)creditCardSwitch
{
    if (!_creditCardSwitch) {
        _creditCardSwitch = [[UISwitch alloc] init];
    }
    return _creditCardSwitch;
}

- (UILabel *)creditCardLabel
{
    if (!_creditCardLabel) {
        _creditCardLabel = [[UILabel alloc] init];
        _creditCardLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
        _creditCardLabel.text = @"¿Acepta tarjeta de crédito?";
        _creditCardLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _creditCardLabel;
}

- (UIButton *)addPhotoButton
{
    if (!_addPhotoButton) {
        _addPhotoButton = [[UIButton alloc] init];
        [_addPhotoButton setTitle:@"Añadir foto" forState:UIControlStateNormal];
        [_addPhotoButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_addPhotoButton addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPhotoButton;
}

- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:_picker.sourceType];
        _picker.allowsEditing = YES;
        _picker.delegate = self;
    }
    return _picker;
}

- (UIButton *)selectedImageButton
{
    if (!_selectedImageButton) {
        _selectedImageButton = [[UIButton alloc] init];
        _selectedImageButton.backgroundColor = [UIColor lightGrayColor];
    }
    return _selectedImageButton;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.title = @"Nuevo Bar";
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -15;
        UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
        self.navigationItem.leftBarButtonItems = @[space, closeBarButton];
        UIBarButtonItem *newBarBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.newBarButton];
        self.navigationItem.rightBarButtonItems = @[space, newBarBarButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.nombreTextField];
    [self.view addSubview:self.descripcionTextField];
    [self.view addSubview:self.creditCardSwitch];
    [self.view addSubview:self.creditCardLabel];
    [self.view addSubview:self.addPhotoButton];
    [self.view addSubview:self.selectedImageButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nombreTextField.frame      = CGRectMake(10, 10, 300, 30);
    self.descripcionTextField.frame = CGRectMake(10, 55, 300, 30);
    self.creditCardSwitch.frame     = CGRectMake(260, 100, 0, 0);
    self.creditCardLabel.frame      = CGRectMake(10, 106, 240, 18);
    self.addPhotoButton.frame       = CGRectMake(10, 140, 100, 30);
    self.selectedImageButton.frame  = CGRectMake(140, 140, 50, 50);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    if (nil == selectedImage) {
        selectedImage = info[UIImagePickerControllerOriginalImage];
    }
    [self.selectedImageButton setImage:selectedImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.picker animated:YES completion:nil];
            break;
        }
        case 1: {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.picker animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Actions

- (void)cancelCheckIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createBar
{
    UIAlertView *createBar = [[UIAlertView alloc] initWithTitle:@"Crear"
                                                        message:@"Crea un nuevo bar"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
    [createBar show];
}

- (void)addPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Elige desde donde obtener la foto"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancelar"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Album", @"Camara", nil];
    [actionSheet showInView:self.view];
}

@end
