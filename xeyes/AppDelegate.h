//
//  AppDelegate.h
//  xeyes
//
//  Created by Coral Wu on 16-3-2.
//  Copyright (c) 2016 Langui.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    BOOL showTitleBar;
    BOOL alwaysOnTop;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenuItem *toggleTitleBarMenuItem1;
@property (assign) IBOutlet NSMenuItem *toggleTitleBarMenuItem2;
@property (assign) IBOutlet NSMenuItem *alwaysOnTopMenuItem;

@end
