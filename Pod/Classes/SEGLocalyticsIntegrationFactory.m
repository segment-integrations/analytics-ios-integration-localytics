#import "SEGLocalyticsIntegrationFactory.h"
#import "SEGLocalyticsIntegration.h"

@implementation SEGLocalyticsIntegrationFactory

+ (id)instance
{
    static dispatch_once_t once;
    static SEGLocalyticsIntegration *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    return self;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
    return [[SEGLocalyticsIntegration alloc] initWithSettings:settings];
}

- (NSString *)key
{
    return @"Localytics";
}

@end