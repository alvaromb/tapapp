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
@property (strong, nonatomic) UITextField *telefonoTextField;
@property (strong, nonatomic) UISwitch *creditCardSwitch;
@property (strong, nonatomic) UILabel *creditCardLabel;
@property (strong, nonatomic) UIButton *addPhotoButton;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIButton *selectedImageButton;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *tipoLocales;
@property (strong, nonatomic) NSNumber *tipoIdentifier;
@property (nonatomic) BOOL deleteImageButtonPressed;

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

- (UITextField *)telefonoTextField
{
    if (!_telefonoTextField) {
        _telefonoTextField = [[UITextField alloc] init];
        _telefonoTextField.placeholder = @"Telefono (opcional)";
    }
    return _telefonoTextField;
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
        [_selectedImageButton addTarget:self action:@selector(photoMenu) forControlEvents:UIControlEventTouchUpInside];
        _selectedImageButton.enabled = NO;
    }
    return _selectedImageButton;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
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
        self.deleteImageButtonPressed = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    self.tipoLocales = [TipoLocal MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]];
    [self.view addSubview:self.nombreTextField];
    [self.view addSubview:self.telefonoTextField];
    [self.view addSubview:self.creditCardSwitch];
    [self.view addSubview:self.creditCardLabel];
    [self.view addSubview:self.addPhotoButton];
    [self.view addSubview:self.selectedImageButton];
    [self.view addSubview:self.pickerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nombreTextField.frame      = CGRectMake(10, 10, 300, 30);
    self.telefonoTextField.frame    = CGRectMake(10, 55, 300, 30);
    self.creditCardSwitch.frame     = CGRectMake(260, 100, 0, 0);
    self.creditCardLabel.frame      = CGRectMake(10, 106, 240, 18);
    self.addPhotoButton.frame       = CGRectMake(10, 140, 100, 30);
    self.selectedImageButton.frame  = CGRectMake(140, 140, 50, 50);
    self.pickerView.frame           = CGRectMake(0, 200, 0, 0);
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
    if (selectedImage) {
        [self.selectedImageButton setImage:selectedImage forState:UIControlStateNormal];
        self.selectedImageButton.enabled = YES;
        self.selectedImage = selectedImage;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button index %d", buttonIndex);
    if (self.deleteImageButtonPressed) {
        switch (buttonIndex) {
            case 0: {
                [self.selectedImageButton setImage:nil forState:UIControlStateNormal];
                break;
            }
            default:
                break;
        }
        self.deleteImageButtonPressed = NO;
    }
    else {
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
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.tipoLocales.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    TipoLocal *tipoLocal = self.tipoLocales[row];
    return tipoLocal.tipo;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    TipoLocal *selected = self.tipoLocales[row];
    NSLog(@"selected tipo local %@", selected.tipo);
    self.tipoIdentifier = selected.identifier;
}

#pragma mark - Actions

- (void)cancelCheckIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createBar
{
    NSDictionary *localData = @{@"nombre"           : self.nombreTextField.text,
                                @"latitud"          : @([TALocationManager sharedInstance].lastLocation.coordinate.latitude),
                                @"longitud"         : @([TALocationManager sharedInstance].lastLocation.coordinate.longitude),
                                @"calle"            : [TALocationManager sharedInstance].placemark.addressDictionary[@"Street"],
                                @"distrito"         : [TALocationManager sharedInstance].placemark.administrativeArea,
                                @"tipo_calle"       : [TALocationManager sharedInstance].placemark.subThoroughfare,
                                @"tipo_direccion"   : [TALocationManager sharedInstance].placemark.thoroughfare,
                                @"codigo_postal"    : [TALocationManager sharedInstance].placemark.postalCode,
                                @"pais"             : [TALocationManager sharedInstance].placemark.country,
                                @"telefono"         : ([self.telefonoTextField.text isEqualToString:@""]) ? @"" : self.telefonoTextField.text,
                                @"tipo_local"       : (self.tipoIdentifier) ? self.tipoIdentifier : @(1)};
    // TODO tipo_local  
    [[TATappapAPI sharedInstance] postLocalWithLocal:localData image:self.selectedImage completionBlock:^(id response) {
        [SVProgressHUD showSuccessWithStatus:@"Local creado!"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
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

- (void)photoMenu
{
    self.deleteImageButtonPressed = YES;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"¿Eliminar la foto?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancelar"
                                               destructiveButtonTitle:@"Eliminar"
                                                    otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

@end
