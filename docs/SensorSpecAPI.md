# SensorSpecAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**sensorSpecAll**](SensorSpecAPI.md#sensorspecall) | **GET** /sensor_spec | Get all SensorSpecs registered.
[**sensorSpecCreate**](SensorSpecAPI.md#sensorspeccreate) | **POST** /sensor_spec | Create a new SensorSpec.
[**sensorSpecDelete**](SensorSpecAPI.md#sensorspecdelete) | **DELETE** /sensor_spec/{sensor_spec_name} | Delete an SensorSpec.
[**sensorSpecUpdate**](SensorSpecAPI.md#sensorspecupdate) | **PUT** /sensor_spec/{sensor_spec_name} | Update an SensorSpec.
[**sensorSpecView**](SensorSpecAPI.md#sensorspecview) | **GET** /sensor_spec/{sensor_spec_name} | Get a SensorSpec.


# **sensorSpecAll**
```swift
    open class func sensorSpecAll(transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all SensorSpecs registered.

Get all SensorSpecs registered by any Researcher.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let transform = "transform_example" // String |  (optional)

// Get all SensorSpecs registered.
SensorSpecAPI.sensorSpecAll(transform: transform) { (response, error) in
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

# **sensorSpecCreate**
```swift
    open class func sensorSpecCreate(sensorSpec: SensorSpec, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new SensorSpec.

Create a new SensorSpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let sensorSpec = SensorSpec(name: "name_example", settingsSchema: 123) // SensorSpec | 

// Create a new SensorSpec.
SensorSpecAPI.sensorSpecCreate(sensorSpec: sensorSpec) { (response, error) in
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
 **sensorSpec** | [**SensorSpec**](SensorSpec.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sensorSpecDelete**
```swift
    open class func sensorSpecDelete(sensorSpecName: String, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete an SensorSpec.

Delete an SensorSpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let sensorSpecName = "sensorSpecName_example" // String | 

// Delete an SensorSpec.
SensorSpecAPI.sensorSpecDelete(sensorSpecName: sensorSpecName) { (response, error) in
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
 **sensorSpecName** | **String** |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sensorSpecUpdate**
```swift
    open class func sensorSpecUpdate(sensorSpecName: String, sensorSpec: SensorSpec, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Update an SensorSpec.

Update an SensorSpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let sensorSpecName = "sensorSpecName_example" // String | 
let sensorSpec = SensorSpec(name: "name_example", settingsSchema: 123) // SensorSpec | 

// Update an SensorSpec.
SensorSpecAPI.sensorSpecUpdate(sensorSpecName: sensorSpecName, sensorSpec: sensorSpec) { (response, error) in
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
 **sensorSpecName** | **String** |  | 
 **sensorSpec** | [**SensorSpec**](SensorSpec.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sensorSpecView**
```swift
    open class func sensorSpecView(sensorSpecName: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get a SensorSpec.

Get a SensorSpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let sensorSpecName = "sensorSpecName_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get a SensorSpec.
SensorSpecAPI.sensorSpecView(sensorSpecName: sensorSpecName, transform: transform) { (response, error) in
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
 **sensorSpecName** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**[Any]**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

