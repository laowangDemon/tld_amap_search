#import <Flutter/Flutter.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface TldAmapsearchPlugin : NSObject<FlutterPlugin,AMapSearchDelegate>
@property (nonatomic,retain) AMapSearchAPI* search;
@property (nonatomic,retain) FlutterResult result;
@end
