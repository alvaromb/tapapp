//
//  TAAddTapaViewController.m
//  Tapapp
//
//  Created by Álvaro on 25/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TAAddTapaViewController.h"

@interface TAAddTapaViewController ()

@property (strong, nonatomic) UIButton *closeViewButton;
@property (strong, nonatomic) UIButton *addTapaButton;
@property (strong, nonatomic) UITextField *nombreTextField;
@property (strong, nonatomic) UITextField *tapaTextView;
@property (strong, nonatomic) UIPickerView *tipoTapaControl;
@property (strong, nonatomic) NSArray *tipoTapaArray;
@property (strong, nonatomic) TipoTapa *selectedTipoTapa;
@property (strong, nonatomic) UIButton *tapaImageButton;

@end

@implementation TAAddTapaViewController

#pragma mark - Lazy instantiation

- (UITextField *)nombreTextField
{
    if (!_nombreTextField) {
        _nombreTextField = [[UITextField alloc] init];
        _nombreTextField.placeholder = @"Nombre de la tapa";
    }
    return _nombreTextField;
}

- (UIButton *)closeViewButton
{
    if (!_closeViewButton) {
        _closeViewButton = [[UIButton alloc] init];
        [_closeViewButton setTitle:@"Cerrar" forState:UIControlStateNormal];
        [_closeViewButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_closeViewButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [_closeViewButton sizeToFit];
    }
    return _closeViewButton;
}

- (UIButton *)addTapaButton
{
    if (!_addTapaButton) {
        _addTapaButton = [[UIButton alloc] init];
        [_addTapaButton setTitle:@"Añadir" forState:UIControlStateNormal];
        [_addTapaButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_addTapaButton addTarget:self action:@selector(addTapa) forControlEvents:UIControlEventTouchUpInside];
        [_addTapaButton sizeToFit];
    }
    return _addTapaButton;
}

- (UITextField *)tapaTextView
{
    if (!_tapaTextView) {
        _tapaTextView = [[UITextField alloc] init];
        _tapaTextView.backgroundColor = [UIColor greenColor];
        _tapaTextView.placeholder = @"Descripcion";
    }
    return _tapaTextView;
}

- (UIPickerView *)tipoTapaControl
{
    if (!_tipoTapaControl) {
        _tipoTapaControl = [[UIPickerView alloc] init];
        _tipoTapaControl.delegate = self;
        _tipoTapaControl.dataSource = self;
        _tipoTapaControl.backgroundColor = [UIColor redColor];
    }
    return _tipoTapaControl;
}

- (UIButton *)tapaImageButton
{
    if (!_tapaImageButton) {
        _tapaImageButton = [[UIButton alloc] init];
        [_tapaImageButton setBackgroundColor:[UIColor lightGrayColor]];
        _tapaImageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _tapaImageButton.imageView.clipsToBounds = YES;
        [_tapaImageButton addTarget:self action:@selector(setTapaImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapaImageButton;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Añadir tapa";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.view.backgroundColor = [UIColor whiteColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -10;
        UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.closeViewButton];
        self.navigationItem.leftBarButtonItems = @[space, closeBarButton];
        UIBarButtonItem *addTapaBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.addTapaButton];
        self.navigationItem.rightBarButtonItems = @[space, addTapaBarButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tipoTapaArray = [TipoTapa MR_findAll];
    [self.view addSubview:self.nombreTextField];
    [self.view addSubview:self.tapaTextView];
    [self.view addSubview:self.tipoTapaControl];
    [self.view addSubview:self.tapaImageButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nombreTextField.frame  = CGRectMake(5, 5, 310, 30);
    self.tapaTextView.frame     = CGRectMake(5, 35, 310, 30);
    self.tipoTapaControl.frame  = CGRectMake(0, 70, 320, 162);
    self.tapaImageButton.frame  = CGRectMake(10, 236, 50, 50);
    [self.nombreTextField becomeFirstResponder];
    [self.tipoTapaControl selectRow:0 inComponent:0 animated:NO];
    self.selectedTipoTapa = [self.tipoTapaArray objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.tipoTapaArray.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    TipoTapa *tipoTapa = self.tipoTapaArray[row];
    return tipoTapa.tipo;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedTipoTapa = self.tipoTapaArray[row];
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img) {
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self.tapaImageButton setImage:img forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.tapaTextView becomeFirstResponder];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        case 1: {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Actions

- (void)closeView
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)addTapa
{
//    $local = Local::findOrFail(Input::get('local'));
//    $tapa->setTipoTapa(TipoTapa::findOrFail(Input::get('tipo_tapa')));
//    $tapa->setDescripcion(Input::get('descripcion'));
//    $tapa->setNombre(Input::get('nombre'));
//    Tapa *newTapa = [Tapa MR_createEntity];
//    // TODO: control that tipo is selected
//    newTapa.tipo = self.selectedTipoTapa;
//    newTapa.nombre = self.tapaTextView.text;
//    newTapa.local = self.local;
//    newTapa.rating = @(5);
//    newTapa.path_imagen = @"";
    NSDictionary *tapa =
    @{@"local"      : self.local.identifier,
      @"tipo_tapa"  : self.selectedTipoTapa.identifier,
      @"descripcion": self.tapaTextView.text,
      @"nombre"     : self.nombreTextField.text};
    [[TATappapAPI sharedInstance] postTapa:tapa imagen:self.tapaImageButton.imageView.image forLocal:self.local.objectID completionBlock:^(id response) {
        [self dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }];
}

- (void)setTapaImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Elige desde donde obtener la imagen"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancelar"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camara", @"Album", nil];
    [actionSheet showInView:self.view];
}

@end
