//
//  ViewController.m
//  testKVC
//
//  Created by Maximilian Tagher on 5/8/14.
//  Copyright (c) 2014 Tagher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Don't use this property, instead use the `mutableList` method.
@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation ViewController

/**
 *  This returns a proxy which will forward messages to your NSMutableArray and trigger KVO notifications.
 *
 *  @return The proxy; treat it as an NSMutableArray
 */
- (NSMutableArray*) mutableList {
    return [self mutableArrayValueForKey: @"list"];
}

/**
 *  According to the "Ensuring KVO Compliance" https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/KeyValueCoding/Articles/Compliant.html, implementing and using these (and similar) methods should trigger the KVO notifications for arrays. However, I couldn't get this to work (only spent like 10 minutes on this before work though).
 */

//- (void)addListObject:(NSString *)object
//{
//    [self.list addObject:object];
//}
//
//- (void)insertObject:(NSString *)object inListAtIndex:(NSUInteger)index
//{
//    [self.list insertObject:object atIndex:index];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.list = [NSMutableArray array];
    
    [self addObserver:self forKeyPath:@"list" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    
    [[self mutableList] addObject:@"test"];
    
}



/**
 *  The
 *
 *  @param keyPath The observed keypath; @"list" in this case
 *  @param object  the object being observed (the VC/self in this case)
 *  @param change  a dictionary with the indexes changed, the type of change, and the new objects
 *  @param context NULL
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"list"]) {
        NSKeyValueChange changeType = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
        NSArray *newItems = change[NSKeyValueChangeNewKey];
        NSLog(@"ChangeType = %i",changeType);
        NSLog(@"Indexes = %@",indexes);
        NSLog(@"New items = %@",newItems);
        NSLog(@"Change = %@",change);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"list"];
}

@end
