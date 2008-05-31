//  Created by Jonathan Yedidia on 5/31/08.
//  Copyright 2008. All rights reserved.
//  Objective-C code based on Aaron Hillegass'
//  "GraphLaughs" PyObjC application, available online at
//  http://weblog.bignerdranch.com/pythonex/GraphLaughs.tgz

#import <Cocoa/Cocoa.h>
@class GDEdge;
@class GDNode;

@interface GDGraph : NSObject {
    NSMutableArray *nodes;
    NSMutableArray *edges;
}

- (void)addNode:(GDNode *)n;
- (void)addEdge:(GDEdge *)e;
- (NSArray *)nodes;
- (NSArray *)edges;
- (void)setNodes:(NSArray *)nodeArray;
- (void)setEdges:(NSArray *)edgesArray;
@end
