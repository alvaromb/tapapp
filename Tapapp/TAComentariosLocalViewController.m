//
//  TAComentariosLocalViewController.m
//  Tapapp
//
//  Created by Álvaro on 22/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TAComentariosLocalViewController.h"

@interface TAComentariosLocalViewController ()

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIButton *addCommentButton;

@end

@implementation TAComentariosLocalViewController

#pragma mark - Lazy instantiation

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshComments) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (UIButton *)addCommentButton
{
    if (!_addCommentButton) {
        _addCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_addCommentButton setTitle:@"Añadir" forState:UIControlStateNormal];
        [_addCommentButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_addCommentButton addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCommentButton;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Comentarios";
        // Hack to align the UIBarButtons in iOS 7
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -15;
        UIBarButtonItem *newComment = [[UIBarButtonItem alloc] initWithCustomView:self.addCommentButton];
        self.navigationItem.rightBarButtonItems = @[space, newComment];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CommentCellIdentifier";
    TAComentarioCell *cell = (TAComentarioCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TAComentarioCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Comentario *comentario = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = comentario.texto;
}

#pragma mark - Actions

- (void)refreshComments
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.fetchedResultsController performFetch:nil];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

- (void)addComment
{
    TANuevoComentarioViewController *vc = [[TANuevoComentarioViewController alloc] init];
    [vc setLocal:self.local];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navController animated:YES completion:nil];
}

@end
