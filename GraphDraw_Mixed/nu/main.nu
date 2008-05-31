;;  Created by Jonathan Yedidia on 5/31/08.
;;  Copyright 2008. All rights reserved.

(import Cocoa)		;; bridgesupport
(load "console")	;; interactive console

(class AppController is NSObject
     (ivar (id) graphView (id) graph (id) scriptTextView)
     (ivar-accessors)
     
     (- (id) init is
        (super init)
        (set $ac self)
        (set @graph (GDGraph new))
        self)
     
     (- (void) evaluate: (id) sender is
        (set str (@scriptTextView string))
        (try
            (set prs (parse str))
            (unless prs (throw 1))
            (eval prs)
            (@graphView setGraph:@graph)
            (catch (exception)
                   (NSRunAlertPanel "Bad script" "" nil nil nil)))))

(set SHOW_CONSOLE_AT_STARTUP nil)

;; @class ApplicationDelegate
;; @discussion Methods of this class perform general-purpose tasks that are not appropriate methods of any other classes.
(class ApplicationDelegate is NSObject
     
     ;; This method is called after Cocoa has finished its basic application setup.
     ;; It instantiates application-specific components.
     ;; In this case, it constructs an interactive Nu console that can be activated from the application's Window menu.
     (- (void) applicationDidFinishLaunching:(id) sender is
        (set $console ((NuConsoleWindowController alloc) init))
        (if SHOW_CONSOLE_AT_STARTUP ($console toggleConsole:self))))

;; install the delegate and keep a reference to it since the application won't retain it.
((NSApplication sharedApplication) setDelegate:(set $delegate ((ApplicationDelegate alloc) init)))

;; this makes the application window take focus when we've started it from the terminal (or with nuke)
((NSApplication sharedApplication) activateIgnoringOtherApps:YES)

;; run the main Cocoa event loop
(NSApplicationMain 0 nil)
