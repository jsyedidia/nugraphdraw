//  Created by Jonathan Yedidia on 5/31/08.
//  Copyright 2008. All rights reserved.
//  Objective-C code based on Aaron Hillegass'
//  "GraphLaughs" PyObjC application, available online at
//  http://weblog.bignerdranch.com/pythonex/GraphLaughs.tgz

#import "GDEdge.h"


@implementation GDEdge

- (id)initWithSourceNode:(GDNode *)aNode
         destinationNode:(GDNode *)bNode
{
    [super init];
    sourceNode = [aNode retain];
    destinationNode = [bNode retain];
    return self;
}

- (void)dealloc
{
    [sourceNode release];
    [destinationNode release];
    [super dealloc];
}

- (GDNode *)sourceNode
{
    return sourceNode;
}

- (GDNode *)destinationNode
{
    return destinationNode;
}

@end
