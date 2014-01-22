//
//  TAInfoLocalViewController.m
//  Tapapp
//
//  Created by Álvaro on 04/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TAInfoLocalViewController.h"

@interface TAInfoLocalViewController ()

@property (strong, nonatomic) UILabel *localLabel;
@property (strong, nonatomic) UILabel *descripcionLabel;
@property (strong, nonatomic) UIImageView *localImageView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) UIButton *favoritoButton;
@property (strong, nonatomic) UIButton *comentariosButton;

@end

@implementation TAInfoLocalViewController

#pragma mark - Lazy instantiation

- (UILabel *)localLabel
{
    if (!_localLabel) {
        _localLabel = [[UILabel alloc] init];
        _localLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _localLabel.textColor = [UIColor blackColor];
        _localLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _localLabel;
}

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

- (UIImageView *)localImageView
{
    if (!_localImageView) {
        _localImageView = [[UIImageView alloc] init];
    }
    return _localImageView;
}

//- (NSFetchedResultsController *)fetchedResultsController
//{
//    if (!_fetchedResultsController) {
//        _fetchedResultsController = [TATapaMapper fetchedTapasForLocal:self.local.nombre delegate:self inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
//    }
//    return _fetchedResultsController;
//}

- (UIButton *)favoritoButton
{
    if (!_favoritoButton) {
        _favoritoButton = [[UIButton alloc] init];
        _favoritoButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_favoritoButton setTitle:@"Añadir favorito" forState:UIControlStateNormal];
        [_favoritoButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_favoritoButton addTarget:self action:@selector(addFavorito) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favoritoButton;
}

- (UIButton *)comentariosButton
{
    if (!_comentariosButton) {
        _comentariosButton = [[UIButton alloc] init];
        _comentariosButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_comentariosButton setTitle:@"Comentarios (-)" forState:UIControlStateNormal];
        [_comentariosButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_comentariosButton addTarget:self action:@selector(viewComments) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comentariosButton;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Local";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.localLabel];
    [self.view addSubview:self.descripcionLabel];
    [self.view addSubview:self.localImageView];
    [self.view addSubview:self.favoritoButton];
    [self.view addSubview:self.comentariosButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.localLabel.frame = CGRectMake(0, 20, self.view.bounds.size.width, 22);
    self.descripcionLabel.frame = CGRectMake(0, 50, self.view.bounds.size.width, 20);
    self.localImageView.frame = CGRectMake(0, 0, 0, 0);
    self.favoritoButton.frame = CGRectMake(10, 150, 150, 30);
    self.comentariosButton.frame = CGRectMake(160, 150, 150, 30);
    
    self.localLabel.text = self.local.nombre;
    self.descripcionLabel.text = self.local.calle;
    NSInteger numberOfComments = [[self.local valueForKeyPath:@"comentarios.@count"] integerValue];
    [self.comentariosButton setTitle:[NSString stringWithFormat:@"Comentarios (%d)", numberOfComments] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)addFavorito
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Añadir favorito"
                                                        message:[NSString stringWithFormat:@"%@ añadido a favoritos", self.local.nombre]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
    [alertView show];
}

- (void)viewComments
{
    TAComentariosLocalViewController *comentariosViewController = [[TAComentariosLocalViewController alloc] init];
    [comentariosViewController setLocal:self.local];
    [self.navigationController pushViewController:comentariosViewController animated:YES];
}

@end
