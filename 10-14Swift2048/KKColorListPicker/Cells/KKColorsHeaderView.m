
#import "KKColorsHeaderView.h"

@interface KKColorsHeaderView()

@end

@implementation KKColorsHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)actionClose:(UIButton *)sender
{
    if (self.delegate) {
        [self.delegate didClickCloseButton:self];
    }
}

@end
