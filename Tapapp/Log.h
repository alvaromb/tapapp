//
//  Log.h
//  Tapapp
//
//  Created by Álvaro on 08/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#ifndef Tapapp_Log_h
#define Tapapp_Log_h

#define AMBLog(s, ...) \
    __weak typeof(self) selfRef = self; \
    NSLog(@"<%@> : %@ --> %@", NSStringFromClass([selfRef class]), NSStringFromSelector(_cmd), s);\

#endif
