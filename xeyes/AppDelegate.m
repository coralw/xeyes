//
//  AppDelegate.m
//  xeyes
//
//  Created by Coral Wu on 16-3-2.
//  Copyright (c) 2016 Langui.net. All rights reserved.
//

#import "AppDelegate.h"

#define WINDOW_WITH_TITLE_STYLE NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask
#define WINDOW_WITHOUT_TITLE_STYLE NSBorderlessWindowMask

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    [self loadDefaultValues];
    [self.window setOpaque:NO];
    [self.window setBackgroundColor:[NSColor clearColor]];
    [self.window setMovableByWindowBackground:YES];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    showTitleBar = [userDefaults boolForKey:@"showTitleBar"];
    alwaysOnTop = [userDefaults boolForKey:@"alwaysOnTop"];
    [self updateTitleBar];
    [self updateMenuItems];
    [self updateWindowLevel];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    NSUInteger eventMask1 = NSMouseMovedMask | NSLeftMouseDraggedMask | NSRightMouseDraggedMask | NSOtherMouseDraggedMask | NSLeftMouseDownMask | NSRightMouseDownMask | NSOtherMouseDownMask;
    NSUInteger eventMask2 = NSMouseMovedMask | NSLeftMouseDownMask | NSRightMouseDownMask | NSOtherMouseDownMask;
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:eventMask1 handler:^(NSEvent * event) {
        [self.window.contentView display];
    }];
    [NSEvent addLocalMonitorForEventsMatchingMask:eventMask2 handler:^NSEvent *(NSEvent *event) {
        [self.window.contentView display];
        return event;
    }];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (IBAction)toggleTitleBar:(id)sender
{
    showTitleBar = !showTitleBar;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:showTitleBar] forKey:@"showTitleBar"];
    [userDefaults synchronize];
    
    [self updateTitleBar];
    [self updateMenuItems];
}

- (IBAction)toggleAlwaysOnTop:(id)sender
{
    alwaysOnTop = ! alwaysOnTop;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:alwaysOnTop] forKey:@"alwaysOnTop"];
    [userDefaults synchronize];
    
    [self updateWindowLevel];
}

- (void)updateTitleBar
{
    if (showTitleBar) {
        [self.window setStyleMask:WINDOW_WITH_TITLE_STYLE];
        [self.window makeKeyWindow];
    }
    else
    {
        [self.window setStyleMask:WINDOW_WITHOUT_TITLE_STYLE];
    }
}

- (void)updateMenuItems
{
    if (showTitleBar) {
        NSString *appName = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
        [self.window setTitle:appName];
        [self.toggleTitleBarMenuItem1 setTitle:NSLocalizedString(@"Hide Title Bar", nil)];
        [self.toggleTitleBarMenuItem2 setTitle:NSLocalizedString(@"Hide Title Bar", nil)];
    }
    else
    {
        [self.toggleTitleBarMenuItem1 setTitle:NSLocalizedString(@"Show Title Bar", nil)];
        [self.toggleTitleBarMenuItem2 setTitle:NSLocalizedString(@"Show Title Bar", nil)];
    }
}

- (void)updateWindowLevel
{
    if (alwaysOnTop) {
        [self.alwaysOnTopMenuItem setState:NSOnState];
        [self.window setLevel:NSWindowAbove];
    }
    else
    {
        [self.alwaysOnTopMenuItem setState:NSOffState];
        [self.window setLevel:NSWindowOut];
    }
}

- (void)loadDefaultValues
{
    // Load default defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"]]];
}

@end
