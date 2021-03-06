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

(class GDGraph is NSObject
     (ivar (id) nodes (id) edges)
     (ivar-accessors)
     
     (- (id) init is
        (super init)
        ;; Set the global variable $graph to give easy access to the graph.
        (set $graph self)
        (set @nodes (array))
        (set @edges (array))
        self)
     
     (- (void) addNode: (id) n is
        (@nodes << n))
     
     (- (void) addEdge: (id) e is
        (@edges << e)))

(class GDGraphView is NSView
     (ivar (id) graph (id) backgroundColor (id) nodeColor (id) edgeColor
           (int) nodeSize (double) edgeWidth)
     (ivar-accessors)
     
     (- (id) initWithFrame: (NSRect) frameRect is
        (set self (super initWithFrame:frameRect))
        (if (self)
            ;; Set the global variable $view to give easy access to the view.
            (set $view self)
            (set @backgroundColor (NSColor darkGrayColor))
            (set @nodeColor (NSColor redColor))
            (set @edgeColor (NSColor whiteColor))
            (set @nodeSize 6)
            (set @edgeWidth 0.9)
            (set b (self bounds))
            (self translateOriginToPoint:
                  (NSMakePoint (+ (b first) (/ (b third) 2.0))
                       (+ (b second) (/ (b fourth) 2.0)))))
        self)
     
     ;; The following methods are here so the user can change aspects of
     ;; the graph from the console or script.
     (- (void) setGraph: (id) g is
        (set @graph g)
        (self setNeedsDisplay:YES))
     
     (- (void) setBackgroundColor: (id) color is
        (set @backgroundColor color)
        (self setNeedsDisplay:YES))
     
     (- (void) setNodeColor: (id) color is
        (set @nodeColor color)
        (self setNeedsDisplay:YES))
     
     (- (void) setEdgeColor: (id) color is
        (set @edgeColor color)
        (self setNeedsDisplay:YES))
     
     (- (void) setNodeSize: (int) size is
        (set @nodeSize size)
        (self setNeedsDisplay:YES))
     
     (- (void) setEdgeWidth: (double) width is
        (set @edgeWidth width)
        (self setNeedsDisplay:YES))
     
     (- (void) drawRect: (NSRect) rect is
        (set b (self bounds))
        (@backgroundColor set)
        (NSBezierPath fillRect:b)
        (self translateOriginToPoint:
              (NSMakePoint (+ (b first) (/ (b third) 2.0))
                   (+ (b second) (/ (b fourth) 2.0))))
        (@nodeColor set)
        (set nodes (@graph nodes))
        (set count (nodes count))
        (count times: (do (i)
                          (set n (nodes i))
                          (set np (n point))
                          (set r (NSMakeRect (- (np first) (/ @nodeSize 2))
                                      (- (np second) (/ @nodeSize 2))
                                      @nodeSize
                                      @nodeSize))
                          (NSBezierPath fillRect:r)))
        
        (@edgeColor set)
        (NSBezierPath setDefaultLineWidth:@edgeWidth)
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
            (unless prs (throw "No acceptable parse of Nu script. You may be missing a parenthesis."))
            (eval prs)
            (@graphView setGraph:@graph)
            (catch (exception)
                   (NSRunAlertPanel "Bad script" (exception description)
				    nil nil nil)))))

(set SHOW_CONSOLE_AT_STARTUP nil)

;; @class ApplicationDelegate
;; @discussion Methods of this class perform general-purpose tasks 
;; that are not appropriate methods of any other classes.
(class ApplicationDelegate is NSObject
     
     ;; This method is called after Cocoa has finished its basic application setup.
     ;; It instantiates application-specific components.
     ;; In this case, it constructs an interactive Nu console that can 
	 ;; be activated from the application's Window menu.
     (- (void) applicationDidFinishLaunching:(id) sender is
        (set $console ((NuConsoleWindowController alloc) init))
        (if SHOW_CONSOLE_AT_STARTUP ($console toggleConsole:self))))

;; install the delegate and keep a reference to it since the application won't retain it.
((NSApplication sharedApplication) setDelegate:(set $delegate ((ApplicationDelegate alloc) init)))

;; this makes the application window take focus when we've 
;; started it from the terminal (or with nuke)
((NSApplication sharedApplication) activateIgnoringOtherApps:YES)

;; run the main Cocoa event loop
(NSApplicationMain 0 nil)
