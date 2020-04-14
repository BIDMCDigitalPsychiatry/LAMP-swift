# SensorAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**sensorAll**](SensorAPI.md#sensorall) | **GET** /sensor | Get the set of all sensors.
[**sensorAllByParticipant**](SensorAPI.md#sensorallbyparticipant) | **GET** /participant/{participant_id}/sensor | Get all sensors for a participant.
[**sensorAllByResearcher**](SensorAPI.md#sensorallbyresearcher) | **GET** /researcher/{researcher_id}/sensor | Get all sensors for a researcher.
[**sensorAllByStudy**](SensorAPI.md#sensorallbystudy) | **GET** /study/{study_id}/sensor | View all sensors in a study.
[**sensorCreate**](SensorAPI.md#sensorcreate) | **POST** /study/{study_id}/sensor | Create a new Sensor under the given Study.
[**sensorDelete**](SensorAPI.md#sensordelete) | **DELETE** /sensor/{sensor_id} | Delete a Sensor.
[**sensorUpdate**](SensorAPI.md#sensorupdate) | **PUT** /sensor/{sensor_id} | Update an Sensor&#39;s settings.
[**sensorView**](SensorAPI.md#sensorview) | **GET** /sensor/{sensor_id} | Get a single sensor, by identifier.


# **sensorAll**
```swift
    open class func sensorAll(transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of all sensors.

Get the set of all sensors.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let transform = "transform_example" // String |  (optional)

// Get the set of all sensors.
SensorAPI.sensorAll(transform: transform) { (response, error) in
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

# **sensorAllByParticipant**
```swift
    open class func sensorAllByParticipant(participantId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all sensors for a participant.

Get the set of all sensors available to a participant, by participant  identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let participantId = "participantId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get all sensors for a participant.
SensorAPI.sensorAllByParticipant(participantId: participantId, transform: transform) { (response, error) in
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

# **sensorAllByResearcher**
```swift
    open class func sensorAllByResearcher(researcherId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all sensors for a researcher.

Get the set of all sensors available to participants of any study conducted  by a researcher, by researcher identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get all sensors for a researcher.
SensorAPI.sensorAllByResearcher(researcherId: researcherId, transform: transform) { (response, error) in
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

# **sensorAllByStudy**
```swift
    open class func sensorAllByStudy(studyId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

View all sensors in a study.

Get the set of all sensors available to participants of a single  study, by study identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let transform = "transform_example" // String |  (optional)

// View all sensors in a study.
SensorAPI.sensorAllByStudy(studyId: studyId, transform: transform) { (response, error) in
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

# **sensorCreate**
```swift
    open class func sensorCreate(studyId: String, sensor: Sensor, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new Sensor under the given Study.

Create a new Sensor under the given Study.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let sensor = Sensor(_id: "_id_example", spec: "spec_example", name: "name_example", settings: 123) // Sensor | 

// Create a new Sensor under the given Study.
SensorAPI.sensorCreate(studyId: studyId, sensor: sensor) { (response, error) in
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
 **sensor** | [**Sensor**](Sensor.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sensorDelete**
```swift
    open class func sensorDelete(sensorId: String, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete a Sensor.

Delete a Sensor.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let sensorId = "sensorId_example" // String | 

// Delete a Sensor.
SensorAPI.sensorDelete(sensorId: sensorId) { (response, error) in
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
 **sensorId** | **String** |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sensorUpdate**
```swift
    open class func sensorUpdate(sensorId: String, sensor: Sensor, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Update an Sensor's settings.

Update an Sensor's settings.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let sensorId = "sensorId_example" // String | 
let sensor = Sensor(_id: "_id_example", spec: "spec_example", name: "name_example", settings: 123) // Sensor | 

// Update an Sensor's settings.
SensorAPI.sensorUpdate(sensorId: sensorId, sensor: sensor) { (response, error) in
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
 **sensorId** | **String** |  | 
 **sensor** | [**Sensor**](Sensor.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sensorView**
```swift
    open class func sensorView(sensorId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get a single sensor, by identifier.

Get a single sensor, by identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let sensorId = "sensorId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get a single sensor, by identifier.
SensorAPI.sensorView(sensorId: sensorId, transform: transform) { (response, error) in
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
 **sensorId** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

