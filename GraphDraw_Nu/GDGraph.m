//  Created by Jonathan Yedidia on 5/31/08.
//  Copyright 2008. All rights reserved.
//  Objective-C code based on Aaron Hillegass'
//  "GraphLaughs" PyObjC application, available online at
//  http://weblog.bignerdranch.com/pythonex/GraphLaughs.tgz

#import "GDGraph.h"

@implementation GDGraph

- (id)init
{
    [super init];
    nodes = [[NSMutableArray alloc] init];
    edges = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [nodes release];
    [edges release];
    [super dealloc];
}

- (void)addNode:(GDNode *)n
{
    [nodes addObject:n];
}

- (void)addEdge:(GDEdge *)e
{
    [edges addObject:e];
}

- (NSArray *)nodes
{
    return nodes;
}

- (NSArray *)edges
{
    return edges;
}

- (void)setNodes:(NSArray *)nodeArray
{
    [nodes release];
    nodes = [nodeArray mutableCopy];
}

- (void)setEdges:(NSArray *)edgesArray
{
    [edges release];
    edges = [edgesArray mutableCopy];
}

@end
