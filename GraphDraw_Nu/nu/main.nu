;;  Created by Jonathan Yedidia on 5/31/08.
;;  Copyright 2008. All rights reserved.

(import Cocoa)		;; bridgesupport
(load "console")	;; interactive console
       
(class GDNode is NSObject
    (ivar (id) point)
    
    (- (id) initWithPoint: (id) aPoint is
        (super init)
        (set @point aPoint)
        self)
        
    (- (NSPoint) point is
        @point))
        
(class GDEdge is NSObject
    (ivar (id) sourceNode (id) destinationNode)
    (ivar-accessors)
    
    (- (id) initWithSourceNode: (id) aNode 
              destinationNode: (id) bNode is
        (super init)
        (set @sourceNode aNode)
        (set @destinationNode bNode)
        self))
        
    
    
(class GDGraphView is NSView
    (ivar (id) graph)

    (- (id) initWithFrame: (NSRect) frameRect is
        (set self (super initWithFrame:frameRect))
        (if (self)
            (set b (self bounds))
            (self translateOriginToPoint: (NSMakePoint (+ (b first) (/ (b third) 2.0))
                                                       (+ (b second) (/ (b fourth) 2.0)))))
        self)

    (- (void) setGraph: (id) g is
        (set @graph g)
        (self setNeedsDisplay:YES))

    (- (void) drawRect: (NSRect) rect is
        (set b (self bounds))
        ((NSColor darkGrayColor) set)
        (NSBezierPath fillRect:b)
        (self translateOriginToPoint:(NSMakePoint (+ (b first) (/ (b third) 2.0))
                                                  (+ (b second) (/ (b fourth) 2.0))))
        ((NSColor redColor) set)
        (set nodes (@graph nodes))
        (set count (nodes count))
        (count times: (do (i) 
            (set n (nodes i))
            (set np (n point))
            (set r (NSMakeRect (- (np first) 3) (- (np second) 3) 6 6))
            (NSBezierPath fillRect:r)))
            
        ((NSColor whiteColor) set)
        (NSBezierPath setDefaultLineWidth:0.9)
        (set edges (@graph edges))
        (set count (edges count))
        (count times: (do (i)
            (set e (edges i))
            (set n1 (e sourceNode))
            (set np1 (n1 point))
            (set n2 (e destinationNode))
            (set np2 (n2 point))
            (NSBezierPath strokeLineFromPoint:np1 toPoint:np2)))))

    
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
