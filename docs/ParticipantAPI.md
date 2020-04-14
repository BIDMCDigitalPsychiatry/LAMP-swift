# ParticipantAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**participantAll**](ParticipantAPI.md#participantall) | **GET** /participant | Get the set of all participants.
[**participantAllByResearcher**](ParticipantAPI.md#participantallbyresearcher) | **GET** /researcher/{researcher_id}/participant | Get the set of all participants under a single researcher.
[**participantAllByStudy**](ParticipantAPI.md#participantallbystudy) | **GET** /study/{study_id}/participant | Get the set of all participants in a single study.
[**participantCreate**](ParticipantAPI.md#participantcreate) | **POST** /study/{study_id}/participant | Create a new Participant for the given Study.
[**participantDelete**](ParticipantAPI.md#participantdelete) | **DELETE** /participant/{participant_id} | Delete a participant AND all owned data or event streams.
[**participantUpdate**](ParticipantAPI.md#participantupdate) | **PUT** /participant/{participant_id} | Update a Participant&#39;s settings.
[**participantView**](ParticipantAPI.md#participantview) | **GET** /participant/{participant_id} | Get a single participant, by identifier.


# **participantAll**
```swift
    open class func participantAll(transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of all participants.

Get the set of all participants.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let transform = "transform_example" // String |  (optional)

// Get the set of all participants.
ParticipantAPI.participantAll(transform: transform) { (response, error) in
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

# **participantAllByResearcher**
```swift
    open class func participantAllByResearcher(researcherId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of all participants under a single researcher.

Get the set of all participants under a single researcher.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get the set of all participants under a single researcher.
ParticipantAPI.participantAllByResearcher(researcherId: researcherId, transform: transform) { (response, error) in
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

# **participantAllByStudy**
```swift
    open class func participantAllByStudy(studyId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of all participants in a single study.

Get the set of all participants in a single study.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get the set of all participants in a single study.
ParticipantAPI.participantAllByStudy(studyId: studyId, transform: transform) { (response, error) in
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

# **participantCreate**
```swift
    open class func participantCreate(studyId: String, participant: Participant, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new Participant for the given Study.

Create a new Participant for the given Study.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let participant = Participant(_id: "_id_example", studyCode: "studyCode_example", language: "language_example", theme: "theme_example", emergencyContact: "emergencyContact_example", helpline: "helpline_example") // Participant | 

// Create a new Participant for the given Study.
ParticipantAPI.participantCreate(studyId: studyId, participant: participant) { (response, error) in
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
 **participant** | [**Participant**](Participant.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **participantDelete**
```swift
    open class func participantDelete(participantId: String, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete a participant AND all owned data or event streams.

Delete a participant AND all owned data or event streams.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 

// Delete a participant AND all owned data or event streams.
ParticipantAPI.participantDelete(participantId: participantId) { (response, error) in
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

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **participantUpdate**
```swift
    open class func participantUpdate(participantId: String, participant: Participant, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Update a Participant's settings.

Update a Participant's settings.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let participant = Participant(_id: "_id_example", studyCode: "studyCode_example", language: "language_example", theme: "theme_example", emergencyContact: "emergencyContact_example", helpline: "helpline_example") // Participant | 

// Update a Participant's settings.
ParticipantAPI.participantUpdate(participantId: participantId, participant: participant) { (response, error) in
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
 **participant** | [**Participant**](Participant.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **participantView**
```swift
    open class func participantView(participantId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get a single participant, by identifier.

Get a single participant, by identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get a single participant, by identifier.
ParticipantAPI.participantView(participantId: participantId, transform: transform) { (response, error) in
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

