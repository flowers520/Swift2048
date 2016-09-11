

#import <Foundation/Foundation.h>
#import "KKColorsSchemeType.h"

/**
 Colors List Loader.
 Load asynchronously colors list from plist.
 */
@interface KKColorsLoader : NSObject

+ (void)loadColorsForType:(KKColorsSchemeType)colorSchemeType completion:(void(^)(NSArray *colors))completion;

@end
