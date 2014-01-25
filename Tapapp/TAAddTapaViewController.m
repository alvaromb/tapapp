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
@property (strong, nonatomic) UITextView *tapaTextView;
@property (strong, nonatomic) UIPickerView *tipoTapaControl;
@property (strong, nonatomic) NSArray *tipoTapaArray;
@property (strong, nonatomic) TipoTapa *selectedTipoTapa;

@end

@implementation TAAddTapaViewController

#pragma mark - Lazy instantiation

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

- (UITextView *)tapaTextView
{
    if (!_tapaTextView) {
        _tapaTextView = [[UITextView alloc] init];
        _tapaTextView.backgroundColor = [UIColor greenColor];
        _tapaTextView.text = @" ";
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
    [self.view addSubview:self.tapaTextView];
    [self.view addSubview:self.tipoTapaControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tapaTextView.frame = CGRectMake(5, 5, 310, 50);
    self.tipoTapaControl.frame = CGRectMake(0, 60, 320, 162);
    [self.tapaTextView becomeFirstResponder];
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

#pragma mark - Actions

- (void)closeView
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)addTapa
{
    Tapa *newTapa = [Tapa MR_createEntity];
    // TODO: control that tipo is selected
    newTapa.tipo = self.selectedTipoTapa;
    newTapa.nombre = self.tapaTextView.text;
    newTapa.local = self.local;
    newTapa.rating = @(5);
    newTapa.path_imagen = @"";
    [[NSManagedObjectContext MR_contextForCurrentThread] save:nil];
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
