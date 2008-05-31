//  Created by Jonathan Yedidia on 5/31/08.
//  Copyright 2008. All rights reserved.
//  Objective-C code based on Aaron Hillegass'
//  "GraphLaughs" PyObjC application, available online at
//  http://weblog.bignerdranch.com/pythonex/GraphLaughs.tgz

#import "GDNode.h"

@implementation GDNode

- (id)initWithPoint:(NSPoint)aPoint
{
    [super init];
    point = aPoint;
    return self;
}

- (NSPoint)point
{
    return point;
}

@end
