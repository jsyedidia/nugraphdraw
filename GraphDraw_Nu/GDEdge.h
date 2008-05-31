//  Created by Jonathan Yedidia on 5/31/08.
//  Copyright 2008. All rights reserved.
//  Objective-C code based on Aaron Hillegass'
//  "GraphLaughs" PyObjC application, available online at
//  http://weblog.bignerdranch.com/pythonex/GraphLaughs.tgz

#import <Cocoa/Cocoa.h>
@class GDNode;

@interface GDEdge : NSObject {
    GDNode *sourceNode;
    GDNode *destinationNode;
}

- (id)initWithSourceNode:(GDNode *)aNode
         destinationNode:(GDNode *)bNode;
- (GDNode *)sourceNode;
- (GDNode *)destinationNode;

@end
