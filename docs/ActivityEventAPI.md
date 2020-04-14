# ActivityEventAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**activityEventAllByParticipant**](ActivityEventAPI.md#activityeventallbyparticipant) | **GET** /participant/{participant_id}/activity_event | Get all activity events for a participant.
[**activityEventAllByResearcher**](ActivityEventAPI.md#activityeventallbyresearcher) | **GET** /researcher/{researcher_id}/activity_event | Get all activity events for a researcher by participant.
[**activityEventAllByStudy**](ActivityEventAPI.md#activityeventallbystudy) | **GET** /study/{study_id}/activity_event | Get all activity events for a study by participant.
[**activityEventCreate**](ActivityEventAPI.md#activityeventcreate) | **POST** /participant/{participant_id}/activity_event | Create a new ActivityEvent for the given Participant.
[**activityEventDelete**](ActivityEventAPI.md#activityeventdelete) | **DELETE** /participant/{participant_id}/activity_event | Delete a ActivityEvent.


# **activityEventAllByParticipant**
```swift
    open class func activityEventAllByParticipant(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all activity events for a participant.

Get the set of all activity events produced by a given participant,  by identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)
let transform = "transform_example" // String |  (optional)

// Get all activity events for a participant.
ActivityEventAPI.activityEventAllByParticipant(participantId: participantId, origin: origin, from: from, to: to, transform: transform) { (response, error) in
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
 **origin** | **String** |  | [optional] 
 **from** | **Double** |  | [optional] 
 **to** | **Double** |  | [optional] 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityEventAllByResearcher**
```swift
    open class func activityEventAllByResearcher(researcherId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all activity events for a researcher by participant.

Get the set of all activity events produced by participants of any  study conducted by a researcher, by researcher identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)
let transform = "transform_example" // String |  (optional)

// Get all activity events for a researcher by participant.
ActivityEventAPI.activityEventAllByResearcher(researcherId: researcherId, origin: origin, from: from, to: to, transform: transform) { (response, error) in
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
 **origin** | **String** |  | [optional] 
 **from** | **Double** |  | [optional] 
 **to** | **Double** |  | [optional] 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityEventAllByStudy**
```swift
    open class func activityEventAllByStudy(studyId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all activity events for a study by participant.

Get the set of all activity events produced by participants of a  single study, by study identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)
let transform = "transform_example" // String |  (optional)

// Get all activity events for a study by participant.
ActivityEventAPI.activityEventAllByStudy(studyId: studyId, origin: origin, from: from, to: to, transform: transform) { (response, error) in
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
 **origin** | **String** |  | [optional] 
 **from** | **Double** |  | [optional] 
 **to** | **Double** |  | [optional] 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityEventCreate**
```swift
    open class func activityEventCreate(participantId: String, activityEvent: ActivityEvent, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new ActivityEvent for the given Participant.

Create a new ActivityEvent for the given Participant.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let activityEvent = ActivityEvent(timestamp: 123, duration: 123, activity: "activity_example", data: 123, temporalSlices: [123]) // ActivityEvent | 

// Create a new ActivityEvent for the given Participant.
ActivityEventAPI.activityEventCreate(participantId: participantId, activityEvent: activityEvent) { (response, error) in
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
 **activityEvent** | [**ActivityEvent**](ActivityEvent.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activityEventDelete**
```swift
    open class func activityEventDelete(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete a ActivityEvent.

Delete a ActivityEvent.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)
let transform = "transform_example" // String |  (optional)

// Delete a ActivityEvent.
ActivityEventAPI.activityEventDelete(participantId: participantId, origin: origin, from: from, to: to, transform: transform) { (response, error) in
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
 **origin** | **String** |  | [optional] 
 **from** | **Double** |  | [optional] 
 **to** | **Double** |  | [optional] 
 **transform** | **String** |  | [optional] 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

