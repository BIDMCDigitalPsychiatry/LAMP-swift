# SensorEventAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**sensorEventAllByParticipant**](SensorEventAPI.md#sensoreventallbyparticipant) | **GET** /participant/{participant_id}/sensor_event | Get all sensor events for a participant.
[**sensorEventAllByResearcher**](SensorEventAPI.md#sensoreventallbyresearcher) | **GET** /researcher/{researcher_id}/sensor_event | Get all sensor events for a researcher by participant.
[**sensorEventAllByStudy**](SensorEventAPI.md#sensoreventallbystudy) | **GET** /study/{study_id}/sensor_event | Get all sensor events for a study by participant.
[**sensorEventCreate**](SensorEventAPI.md#sensoreventcreate) | **POST** /participant/{participant_id}/sensor_event | Create a new SensorEvent for the given Participant.
[**sensorEventDelete**](SensorEventAPI.md#sensoreventdelete) | **DELETE** /participant/{participant_id}/sensor_event | Delete a sensor event.


# **sensorEventAllByParticipant**
```swift
    open class func sensorEventAllByParticipant(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all sensor events for a participant.

Get the set of all sensor events produced by the given participant.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)
let transform = "transform_example" // String |  (optional)

// Get all sensor events for a participant.
SensorEventAPI.sensorEventAllByParticipant(participantId: participantId, origin: origin, from: from, to: to, transform: transform) { (response, error) in
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

# **sensorEventAllByResearcher**
```swift
    open class func sensorEventAllByResearcher(researcherId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all sensor events for a researcher by participant.

Get the set of all sensor events produced by participants of any  study conducted by a researcher, by researcher identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)
let transform = "transform_example" // String |  (optional)

// Get all sensor events for a researcher by participant.
SensorEventAPI.sensorEventAllByResearcher(researcherId: researcherId, origin: origin, from: from, to: to, transform: transform) { (response, error) in
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

# **sensorEventAllByStudy**
```swift
    open class func sensorEventAllByStudy(studyId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all sensor events for a study by participant.

Get the set of all sensor events produced by participants of a  single study, by study identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)
let transform = "transform_example" // String |  (optional)

// Get all sensor events for a study by participant.
SensorEventAPI.sensorEventAllByStudy(studyId: studyId, origin: origin, from: from, to: to, transform: transform) { (response, error) in
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

# **sensorEventCreate**
```swift
    open class func sensorEventCreate(participantId: String, sensorEvent: SensorEvent, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new SensorEvent for the given Participant.

Create a new SensorEvent for the given Participant.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let sensorEvent = SensorEvent(timestamp: 123, sensor: "sensor_example", data: 123) // SensorEvent | 

// Create a new SensorEvent for the given Participant.
SensorEventAPI.sensorEventCreate(participantId: participantId, sensorEvent: sensorEvent) { (response, error) in
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
 **sensorEvent** | [**SensorEvent**](SensorEvent.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sensorEventDelete**
```swift
    open class func sensorEventDelete(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete a sensor event.

Delete a sensor event.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let origin = "origin_example" // String |  (optional)
let from = 987 // Double |  (optional)
let to = 987 // Double |  (optional)

// Delete a sensor event.
SensorEventAPI.sensorEventDelete(participantId: participantId, origin: origin, from: from, to: to) { (response, error) in
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

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

