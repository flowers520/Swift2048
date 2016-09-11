
#import "KKColor.h"
#import "UIColor+CustomColors.h"

@implementation KKColor

- (instancetype)initWithName:(NSString *)newName hash:(NSString *)newHash
{
    self = [self init];
    if (self) {
        self.name = newName;
        self.chash = newHash;
    }
    return self;
}

- (UIColor *)uiColor
{
    return [UIColor colorFromHexString:self.chash];
}

@end
