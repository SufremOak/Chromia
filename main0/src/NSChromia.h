// NSChromia.h

#import <Foundation/Foundation.h>

@interface NSChromia : NSObject

// Method to initialize the Chromia object
- (instancetype)initWithName:(NSString *)name;

// Method to get the name of the Chromia object
- (NSString *)getName;

// Method to set the name of the Chromia object
- (void)setName:(NSString *)name;

@end