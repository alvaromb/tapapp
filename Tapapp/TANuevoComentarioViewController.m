//
//  TANuevoComentarioViewController.m
//  Tapapp
//
//  Created by Álvaro on 22/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TANuevoComentarioViewController.h"

@interface TANuevoComentarioViewController ()

@property (strong, nonatomic) UIButton *sendNewCommentButton;
@property (strong, nonatomic) UIButton *closeView;
@property (strong, nonatomic) UITextView *textView;

@end

@implementation TANuevoComentarioViewController

#pragma mark - Lazy instantiation

- (UIButton *)sendNewCommentButton
{
    if (!_sendNewCommentButton) {
        _sendNewCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_sendNewCommentButton setTitle:@"Enviar" forState:UIControlStateNormal];
        [_sendNewCommentButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_sendNewCommentButton addTarget:self action:@selector(sendNewComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendNewCommentButton;
}

- (UIButton *)closeView
{
    if (!_closeView) {
        _closeView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_closeView setTitle:@"Cerrar" forState:UIControlStateNormal];
        [_closeView setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_closeView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeView;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
    }
    return _textView;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Nuevo comentario";
        // Hack to align the UIBarButtons in iOS 7
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -15;
        UIBarButtonItem *newComment = [[UIBarButtonItem alloc] initWithCustomView:self.sendNewCommentButton];
        self.navigationItem.rightBarButtonItems = @[space, newComment];
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:self.closeView];
        self.navigationItem.leftBarButtonItems = @[space, closeButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.textView.frame = CGRectMake(5, 5, 310, 310);
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)sendNewComment
{
    if (self.textView.text.length <= 0) {
        return;
    }
    Comentario *nuevoComentario = [Comentario MR_createInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    nuevoComentario.local = self.local;
    nuevoComentario.fecha = [NSDate new];
    nuevoComentario.texto = self.textView.text;
    nuevoComentario.autor = @"Alf";
    [[NSManagedObjectContext MR_contextForCurrentThread] save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
