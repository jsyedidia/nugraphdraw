//  Created by Jonathan Yedidia on 5/31/08.
//  Copyright 2008. All rights reserved.
//  Objective-C code based on Aaron Hillegass'
//  "GraphLaughs" PyObjC application, available online at
//  http://weblog.bignerdranch.com/pythonex/GraphLaughs.tgz

#import "GDGraphView.h"
#import "GDGraph.h"
#import "GDNode.h"
#import "GDEdge.h"

@implementation GDGraphView

- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect]) != nil) {
        NSRect b = [self bounds];
        [self translateOriginToPoint:NSMakePoint(b.origin.x + b.size.width/2.0,
                                                 b.origin.y + b.size.height/2.0)];
	}
	return self;
}

- (void)setGraph:(GDGraph *)g
{
    [g retain];
    [graph release];
    graph = g;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect
{
    NSRect b = [self bounds];
    [[NSColor darkGrayColor] set];
    [NSBezierPath fillRect:b];
    [self translateOriginToPoint:NSMakePoint(b.origin.x + b.size.width/2.0,
                                             b.origin.y + b.size.height/2.0)];
        
    [[NSColor redColor] set];
    NSArray *nodes = [graph nodes];
    int i, count;
    count = [nodes count];
    NSRect r = NSMakeRect(0,0, 6, 6);
    for (i = 0; i < count; i++) {
        GDNode *n = [nodes objectAtIndex:i];
        NSPoint np = [n point];
        r.origin.x = np.x - 3;
        r.origin.y = np.y - 3;
        [NSBezierPath fillRect:r];
    }
    
    [[NSColor whiteColor] set];
    [NSBezierPath setDefaultLineWidth:0.9];
    NSArray *edges = [graph edges];
    count = [edges count];
    for (i = 0; i < count; i++) {
        GDEdge *e = [edges objectAtIndex:i];
        GDNode *n1 = [e sourceNode];
        NSPoint np1 = [n1 point];
        GDNode *n2 = [e destinationNode];
        NSPoint np2 = [n2 point];
        [NSBezierPath strokeLineFromPoint:np1
                                  toPoint:np2];
    }    
}

@end
