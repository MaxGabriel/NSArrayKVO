NSArrayKVO
==========

Repo showing how to do KVO on an NSArray's contents

This implementation is pretty simple, though KVO is a bit clunky as always. I think you could factor out some things—notably pulling values out of the change dictionary—into a library like Bindings or something.

#### Brief Overview:
 

```objc
// Use a proxy object to modify the NSMutableArray—this triggers KVO notifications
- (NSMutableArray*) mutableList {
    return [self mutableArrayValueForKey: @"list"];
}

// Pull the change information (like what object was added at what index) from the change dictionary
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
```
