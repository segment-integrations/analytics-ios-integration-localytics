Change Log
==========

Version 1.3.0 *(27th February, 2018)*
-------------------------------------------
*(Supports Localytics 5.0+)*

 * [Update](https://github.com/segment-integrations/analytics-ios-integration-localytics/pull/24):The one change here is that when configuring the `appKey`, the Localytics `integrate` method takes an additional argument to add flexibility on when/how to upload user data. Localytics will default to uploading data periodically based on the state of a user's network connection. The default behavior occurs when passing `nil` to `withLocalyticsOptions`. [Relevant Docs](https://docs.localytics.com/dev/ios.html#initialize-sdk-ios).

Version 1.2.0 *(30th August, 2017)*
-------------------------------------------
*(Supports Localytics 4.0)*

 * [New](https://github.com/segment-integrations/analytics-ios-integration-localytics/pull/19): Maps to Localytics Org level reserved traits $first_name, $last_name, $email, and $full_name.  

Version 1.0.4 *(17th August, 2016)*
-------------------------------------------
*(Supports Localytics 4.0)*

Adds support for changing `profileScope` of user Attributes

Version 1.0.3 *(23rd June, 2016)*
-------------------------------------------
*(Supports Localytics 4.0)*

Version 1.0.2 *(7th June, 2016)*
-------------------------------------------
*(Supports analytics-ios 3.0 - < 4.0)*

Version 1.0.1 *(11th May, 2016)*
-------------------------------------------
*(Supports Localytics 3.8+)*

Version 1.0.0 *(24th November, 2015)*
-------------------------------------------
*(Supports analytics-ios 3.0.+ and Localytics 3.5.1+)*

Initial stable release.


Version 1.0.0-alpha *(18th November, 2015)*
-------------------------------------------
*(Supports analytics-ios 3.0.+ and Localytics 3.5.1+)*

Initial release.
