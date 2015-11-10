#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>

@interface SEGLocalyticsIntegrationFactory : NSObject<SEGIntegrationFactory>

+ (id)instance;

@end