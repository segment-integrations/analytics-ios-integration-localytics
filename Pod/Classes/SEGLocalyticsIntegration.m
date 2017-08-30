#import "SEGLocalyticsIntegration.h"
#import <Localytics/Localytics.h>
#import <Analytics/SEGAnalyticsUtils.h>

@implementation SEGLocalyticsIntegration

#pragma mark - Initialization

- (id)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]) {
        self.settings = settings;
        
        NSString *appKey = [settings objectForKey:@"appKey"];
        [Localytics integrate:appKey];
        
        NSNumber *sessionTimeoutInterval = [settings objectForKey:@"sessionTimeoutInterval"];
        if (sessionTimeoutInterval != nil &&
            [sessionTimeoutInterval floatValue] > 0) {
            [Localytics setOptions:@{@"session_timeout":sessionTimeoutInterval}];
        } else { [Localytics setOptions:@{@"session_timeout": @30}]; };
    }
    return self;
}

- (void)setCustomDimensions:(NSDictionary *)dictionary
{
    NSDictionary *customDimensions = self.settings[@"dimensions"];
    
    for (NSString *key in dictionary) {
        if ([customDimensions objectForKey:key] != nil) {
            NSString *dimension = [customDimensions objectForKey:key];
            [Localytics setValue:[dictionary objectForKey:key]
                        forCustomDimension:[dimension integerValue]];
        }
    }
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    if (payload.userId) {
        [Localytics setCustomerId:payload.userId];
        SEGLog(@"[Localytics setCustomerId:%@];", payload.userId);
    }
    
    NSString *email = [payload.traits objectForKey:@"email"];
    if (email) {
        [Localytics setValue:email forIdentifier:@"email"];
        SEGLog(@"[Localytics setValue:%@ forIdentifier:@'email']", email);
        
        [Localytics setCustomerEmail:email];
        SEGLog(@"[Localytics setCustomerEmail:%@];", email);
    }
    
    NSString *name = [payload.traits objectForKey:@"name"];
    if (name) {
        [Localytics setValue:name forIdentifier:@"customer_name"];
        SEGLog(@"[Localytics setValue:%@ forIdentifier:@'customer_name']", name);
        
        [Localytics setCustomerFullName:name];
        SEGLog(@"[Localytics setCustomerFullName:%@];", name);
    }
    
    NSString *firstName = [payload.traits objectForKey:@"first_name"];
    if (firstName) {
        [Localytics setCustomerFirstName:firstName];
        SEGLog(@"[Localytics setCustomerFirstName:%@];", firstName);
    }
    
    NSString *lastName = [payload.traits objectForKey:@"last_name"];
    if (lastName) {
        [Localytics setCustomerLastName:lastName];
        SEGLog(@"[Localytics setCustomerLastName:%@];", lastName);
    }
    
    [self setCustomDimensions:payload.traits];
    
    // Allow users to specify whether attributes should be Org or Application Scoped.
    NSInteger attributeScope;
    if ([self setOrganizationScope]) {
        attributeScope = LLProfileScopeOrganization;
    } else {
        attributeScope = LLProfileScopeApplication;
    }
    
    // Other traits. Iterate over all the traits and set them.
    for (NSString *key in payload.traits) {
        NSString *traitValue =
        [NSString stringWithFormat:@"%@", [payload.traits objectForKey:key]];
        [Localytics setValue:traitValue
                   forProfileAttribute:key
                             withScope:attributeScope];
    }
}

+ (NSNumber *)extractRevenue:(NSDictionary *)dictionary withKey:(NSString *)revenueKey
{
    id revenueProperty = nil;
    
    for (NSString *key in dictionary.allKeys) {
        if ([key caseInsensitiveCompare:revenueKey] == NSOrderedSame) {
            revenueProperty = dictionary[key];
            break;
        }
    }
    
    if (revenueProperty) {
        if ([revenueProperty isKindOfClass:[NSString class]]) {
            // Format the revenue.
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            return [formatter numberFromString:revenueProperty];
        } else if ([revenueProperty isKindOfClass:[NSNumber class]]) {
            return revenueProperty;
        }
    }
    return nil;
}

- (void)track:(SEGTrackPayload *)payload
{
    // TODO add support for value
    
    // Backgrounded? Restart the session to add this event.
    BOOL isBackgrounded = [[UIApplication sharedApplication] applicationState] !=
    UIApplicationStateActive;
    if (isBackgrounded) {
        [Localytics openSession];
    }
    
    NSNumber *revenue = [SEGLocalyticsIntegration extractRevenue:payload.properties withKey:@"revenue"];
    if (revenue) {
        [Localytics tagEvent:payload.event
                            attributes:payload.properties
                 customerValueIncrease:@([revenue intValue] * 100)];
    } else {
        [Localytics tagEvent:payload.event attributes:payload.properties];
    }
    
    [self setCustomDimensions:payload.properties];
    
    // Backgrounded? Close the session again after the event.
    if (isBackgrounded) {
        [Localytics closeSession];
    }
}

- (void)screen:(SEGScreenPayload *)payload
{
    [Localytics tagScreen:payload.name];
}

- (void)registeredForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [Localytics setPushToken:deviceToken];
}

- (void)receivedRemoteNotification:(NSDictionary *)userInfo
{
    [Localytics handleNotification:userInfo];
}

- (BOOL)setOrganizationScope
{
    return [(NSNumber *)[self.settings objectForKey:@"setOrganizationScope"] boolValue];
}

- (void)flush
{
    [Localytics upload];
}

#pragma mark - Callbacks for app state changes

- (void)applicationDidEnterBackground
{
    [Localytics dismissCurrentInAppMessage];
    [Localytics closeSession];
    [Localytics upload];
}

- (void)applicationWillEnterForeground
{
    [Localytics openSession];
    [Localytics upload];
}

- (void)applicationWillTerminate
{
    [Localytics closeSession];
    [Localytics upload];
}
- (void)applicationWillResignActive
{
    [Localytics dismissCurrentInAppMessage];
    [Localytics closeSession];
    [Localytics upload];
}
- (void)applicationDidBecomeActive
{
    [Localytics openSession];
    [Localytics upload];
}

@end
