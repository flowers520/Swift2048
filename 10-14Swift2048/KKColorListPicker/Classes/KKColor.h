

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KKColor : NSObject

// color name
@property (nonatomic, strong) NSString *name;

// color hex
@property (nonatomic, strong) NSString *chash;

- (instancetype)initWithName:(NSString *)newName hash:(NSString *)newHash;

// to UIColor
- (UIColor *)uiColor;

@end
