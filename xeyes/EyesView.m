//
//  CustomView.m
//  xeyes
//
//  Created by Coral Wu on 16-3-2.
//  Copyright (c) 2016 Langui.net. All rights reserved.
//

#import "EyesView.h"

@implementation EyesView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
    NSRect screen = [self bounds];
    
    if (NSIntersectsRect(dirtyRect, screen)) {
        [[NSColor clearColor] set];
        NSRectFill(screen);
    }
    
    NSPoint myPoint = [self convertPoint:[self.window convertScreenToBase:[NSEvent mouseLocation]]
                                                   fromView:nil];
    
    CGRect lRect1 = NSMakeRect(screen.origin.x, screen.origin.y, screen.size.width/2.1, screen.size.height);
    CGRect lRect2 = NSMakeRect(lRect1.origin.x + lRect1.size.width*0.1, lRect1.origin.y + lRect1.size.height*0.1, lRect1.size.width*0.8, lRect1.size.height*0.8);
    CGRect lRect3 = NSMakeRect(lRect1.origin.x + lRect1.size.width*0.3, lRect1.origin.y + lRect1.size.height*0.3, lRect1.size.width*0.18, lRect1.size.height*0.18);
    CGRect rRect1 = NSMakeRect(screen.size.width - screen.size.width/2.1, screen.origin.y, screen.size.width/2.1, screen.size.height);
    CGRect rRect2 = NSMakeRect(rRect1.origin.x + rRect1.size.width*0.1, rRect1.origin.y + rRect1.size.height*0.1, rRect1.size.width*0.8, rRect1.size.height*0.8);
    CGRect rRect3 = NSMakeRect(rRect1.origin.x + rRect1.size.width*0.3, rRect1.origin.y + rRect1.size.height*0.3, rRect1.size.width*0.18, rRect1.size.height*0.18);
    CGRect lPupilRect = NSMakeRect(lRect1.origin.x + lRect1.size.width*0.3, lRect1.origin.y + lRect1.size.height*0.3, lRect1.size.width*0.4, lRect1.size.height*0.4);
    CGRect rPupilRect = NSMakeRect(rRect1.origin.x + rRect1.size.width*0.3, rRect1.origin.y + rRect1.size.height*0.3, rRect1.size.width*0.4, rRect1.size.height*0.4);
    
    [[NSColor blackColor] set];
    if (NSIntersectsRect(dirtyRect, lRect1)) {
        [[NSBezierPath bezierPathWithOvalInRect:lRect1] fill];
    }
    if (NSIntersectsRect(dirtyRect, rRect1)) {
        [[NSBezierPath bezierPathWithOvalInRect:rRect1] fill];
    }
    
    [[NSColor whiteColor] set];
    [[NSBezierPath bezierPathWithOvalInRect:lRect2] fill];
    [[NSBezierPath bezierPathWithOvalInRect:rRect2] fill];
    
    
    NSBezierPath *lPupilPath = [NSBezierPath bezierPathWithOvalInRect:lPupilRect];
    NSBezierPath *rPupilPath = [NSBezierPath bezierPathWithOvalInRect:rPupilRect];

    if ([lPupilPath containsPoint:myPoint]) {
        lRect3.origin = NSMakePoint(myPoint.x-lRect3.size.width/2.0, myPoint.y-lRect3.size.height/2.0);
    }
    else
    {
        NSPoint point = [self getOvalPoint:lPupilRect mousePoint:myPoint];
        lRect3.origin = NSMakePoint(point.x - lRect3.size.width/2.0, point.y - lRect3.size.height/2.0);
    }
    if ([rPupilPath containsPoint:myPoint]) {
        rRect3.origin = NSMakePoint(myPoint.x-rRect3.size.width/2.0, myPoint.y-rRect3.size.height/2.0);
    }
    else
    {
        NSPoint point = [self getOvalPoint:rPupilRect mousePoint:myPoint];
        rRect3.origin = NSMakePoint(point.x - rRect3.size.width/2.0, point.y - rRect3.size.height/2.0);
    }
    
    [[NSColor blackColor] set];
    [[NSBezierPath bezierPathWithOvalInRect:lRect3] fill];
    [[NSBezierPath bezierPathWithOvalInRect:rRect3] fill];
}

- (NSPoint)getOvalPoint:(CGRect)rect mousePoint:(NSPoint)mousePoint
{
    CGFloat r1 = rect.size.width/2.0;
    CGFloat r2 = rect.size.height/2.0;
    CGFloat cX = rect.origin.x + r1;
    CGFloat cY = rect.origin.y + r2;
    CGFloat a = MAX(r1, r2);
    CGFloat b = MIN(r1, r2);
    CGFloat x = 0;
    CGFloat y = 0;
    if (mousePoint.x != cX)
    {
        CGFloat tanA = (mousePoint.y-cY) / (mousePoint.x-cX);
        if (rect.size.width > rect.size.height) {
            x = sqrt(pow(a, 2)*pow(b, 2) / (pow(b, 2) + pow(tanA, 2)*pow(a, 2)));
        }
        else
        {
            x = sqrt(pow(a, 2)*pow(b, 2) / (pow(a, 2) + pow(tanA, 2)*pow(b, 2)));
        }
        if (mousePoint.x - cX < 0) {
            x = -x;
        }
        y = tanA * x;
    }
    else
    {
        if (mousePoint.y - cY > 0) {
            y = r2;
        }
        else
        {
            y = -r2;
        }
    }
    NSPoint point = NSMakePoint(x+cX, y+cY);
    return point;
}

@end
