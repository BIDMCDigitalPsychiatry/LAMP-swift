# ActivityAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**activityAll**](ActivityAPI.md#activityall) | **GET** /activity | Get the set of all activities.
[**activityAllByParticipant**](ActivityAPI.md#activityallbyparticipant) | **GET** /participant/{participant_id}/activity | Get all activities for a participant.
[**activityAllByResearcher**](ActivityAPI.md#activityallbyresearcher) | **GET** /researcher/{researcher_id}/activity | Get all activities for a researcher.
[**activityAllByStudy**](ActivityAPI.md#activityallbystudy) | **GET** /study/{study_id}/activity | Get all activities in a study.
[**activityCreate**](ActivityAPI.md#activitycreate) | **POST** /study/{study_id}/activity | Create a new Activity under the given Study.
[**activityDelete**](ActivityAPI.md#activitydelete) | **DELETE** /activity/{activity_id} | Delete an Activity.
[**activityUpdate**](ActivityAPI.md#activityupdate) | **PUT** /activity/{activity_id} | Update an Activity&#39;s settings.
[**activityView**](ActivityAPI.md#activityview) | **GET** /activity/{activity_id} | Get a single activity, by identifier.


# **activityAll**
```swift
    open class func activityAll(transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of all activities.

Get the set of all activities.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let transform = "transform_example" // String |  (optional)

// Get the set of all activities.
ActivityAPI.activityAll(transform: transform) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityAllByParticipant**
```swift
    open class func activityAllByParticipant(participantId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all activities for a participant.

Get the set of all activities available to a participant, by  participant identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get all activities for a participant.
ActivityAPI.activityAllByParticipant(participantId: participantId, transform: transform) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **participantId** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityAllByResearcher**
```swift
    open class func activityAllByResearcher(researcherId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all activities for a researcher.

Get the set of all activities available to participants of any study  conducted by a researcher, by researcher identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get all activities for a researcher.
ActivityAPI.activityAllByResearcher(researcherId: researcherId, transform: transform) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **researcherId** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityAllByStudy**
```swift
    open class func activityAllByStudy(studyId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all activities in a study.

Get the set of all activities available to  participants of a single  study, by study identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get all activities in a study.
ActivityAPI.activityAllByStudy(studyId: studyId, transform: transform) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studyId** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityCreate**
```swift
    open class func activityCreate(studyId: String, activity: Activity, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new Activity under the given Study.

Create a new Activity under the given Study.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let activity = Activity(_id: "_id_example", spec: "spec_example", name: "name_example", schedule: DurationIntervalLegacy(repeatType: "repeatType_example", date: 123, customTimes: [123]), settings: 123) // Activity | 

// Create a new Activity under the given Study.
ActivityAPI.activityCreate(studyId: studyId, activity: activity) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studyId** | **String** |  | 
 **activity** | [**Activity**](Activity.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityDelete**
```swift
    open class func activityDelete(activityId: String, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete an Activity.

Delete an Activity.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let activityId = "activityId_example" // String | 

// Delete an Activity.
ActivityAPI.activityDelete(activityId: activityId) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **activityId** | **String** |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityUpdate**
```swift
    open class func activityUpdate(activityId: String, activity: Activity, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Update an Activity's settings.

Update an Activity's settings.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let activityId = "activityId_example" // String | 
let activity = Activity(_id: "_id_example", spec: "spec_example", name: "name_example", schedule: DurationIntervalLegacy(repeatType: "repeatType_example", date: 123, customTimes: [123]), settings: 123) // Activity | 

// Update an Activity's settings.
ActivityAPI.activityUpdate(activityId: activityId, activity: activity) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **activityId** | **String** |  | 
 **activity** | [**Activity**](Activity.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityView**
```swift
    open class func activityView(activityId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get a single activity, by identifier.

Get a single activity, by identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let activityId = "activityId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get a single activity, by identifier.
ActivityAPI.activityView(activityId: activityId, transform: transform) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **activityId** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

