#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>


@interface SEGLocalyticsIntegrationFactory : NSObject <SEGIntegrationFactory>

+ (instancetype)instance;

@end
