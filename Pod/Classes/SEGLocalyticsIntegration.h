#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>
#import <Localytics/Localytics.h>

@interface SEGLocalyticsIntegration : NSObject<SEGIntegration>

@property(nonatomic, strong) NSDictionary *settings;

- (id)initWithSettings:(NSDictionary *)settings;

@end