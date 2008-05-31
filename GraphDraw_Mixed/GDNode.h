//  Created by Jonathan Yedidia on 5/31/08.
//  Copyright 2008. All rights reserved.
//  Objective-C code based on Aaron Hillegass'
//  "GraphLaughs" PyObjC application, available online at
//  http://weblog.bignerdranch.com/pythonex/GraphLaughs.tgz

#import <Cocoa/Cocoa.h>

@interface GDNode : NSObject {
    NSPoint point;
}

- (id)initWithPoint:(NSPoint)aPoint;
- (NSPoint)point;

@end
