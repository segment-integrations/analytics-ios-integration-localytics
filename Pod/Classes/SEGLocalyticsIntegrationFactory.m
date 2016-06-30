#import "SEGLocalyticsIntegrationFactory.h"
#import "SEGLocalyticsIntegration.h"

@implementation SEGLocalyticsIntegrationFactory

+ (instancetype)instance
{
    static dispatch_once_t once;
    static SEGLocalyticsIntegrationFactory *sharedInstance;
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
