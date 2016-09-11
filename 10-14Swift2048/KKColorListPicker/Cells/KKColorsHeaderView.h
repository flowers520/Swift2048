
#import <UIKit/UIKit.h>

@class KKColorsHeaderView;

@protocol KKColorsHeaderViewDelegate <NSObject>

@required
- (void)didClickCloseButton:(KKColorsHeaderView *)view;

@end

@interface KKColorsHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<KKColorsHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)actionClose:(UIButton *)sender;

@end
