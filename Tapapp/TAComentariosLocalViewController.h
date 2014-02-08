//
//  TAComentariosLocalViewController.h
//  Tapapp
//
//  Created by Álvaro on 22/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "Local.h"
#import "Comentario.h"
#import "TAComentarioCell.h"
#import "TABaseTableViewController.h"
#import "TANuevoComentarioViewController.h"

@interface TAComentariosLocalViewController : TABaseTableViewController

@property (strong, nonatomic) Local *local;

@end
