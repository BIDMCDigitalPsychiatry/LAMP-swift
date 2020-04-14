# ActivitySpecAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**activitySpecAll**](ActivitySpecAPI.md#activityspecall) | **GET** /activity_spec | Get all ActivitySpecs registered.
[**activitySpecCreate**](ActivitySpecAPI.md#activityspeccreate) | **POST** /activity_spec | Create a new ActivitySpec.
[**activitySpecDelete**](ActivitySpecAPI.md#activityspecdelete) | **DELETE** /activity_spec/{activity_spec_name} | Delete an ActivitySpec.
[**activitySpecUpdate**](ActivitySpecAPI.md#activityspecupdate) | **PUT** /activity_spec/{activity_spec_name} | Update an ActivitySpec.
[**activitySpecView**](ActivitySpecAPI.md#activityspecview) | **GET** /activity_spec/{activity_spec_name} | View an ActivitySpec.


# **activitySpecAll**
```swift
    open class func activitySpecAll(transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get all ActivitySpecs registered.

Get all ActivitySpecs registered.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let transform = "transform_example" // String |  (optional)

// Get all ActivitySpecs registered.
ActivitySpecAPI.activitySpecAll(transform: transform) { (response, error) in
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

# **activitySpecCreate**
```swift
    open class func activitySpecCreate(activitySpec: ActivitySpec, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new ActivitySpec.

Create a new ActivitySpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let activitySpec = ActivitySpec(name: "name_example", helpContents: "helpContents_example", scriptContents: "scriptContents_example", staticDataSchema: 123, temporalEventSchema: 123, settingsSchema: 123) // ActivitySpec | 

// Create a new ActivitySpec.
ActivitySpecAPI.activitySpecCreate(activitySpec: activitySpec) { (response, error) in
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
 **activitySpec** | [**ActivitySpec**](ActivitySpec.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activitySpecDelete**
```swift
    open class func activitySpecDelete(activitySpecName: String, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete an ActivitySpec.

Delete an ActivitySpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let activitySpecName = "activitySpecName_example" // String | 

// Delete an ActivitySpec.
ActivitySpecAPI.activitySpecDelete(activitySpecName: activitySpecName) { (response, error) in
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
 **activitySpecName** | **String** |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activitySpecUpdate**
```swift
    open class func activitySpecUpdate(activitySpecName: String, activitySpec: ActivitySpec, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Update an ActivitySpec.

Update an ActivitySpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let activitySpecName = "activitySpecName_example" // String | 
let activitySpec = ActivitySpec(name: "name_example", helpContents: "helpContents_example", scriptContents: "scriptContents_example", staticDataSchema: 123, temporalEventSchema: 123, settingsSchema: 123) // ActivitySpec | 

// Update an ActivitySpec.
ActivitySpecAPI.activitySpecUpdate(activitySpecName: activitySpecName, activitySpec: activitySpec) { (response, error) in
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
 **activitySpecName** | **String** |  | 
 **activitySpec** | [**ActivitySpec**](ActivitySpec.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **activitySpecView**
```swift
    open class func activitySpecView(activitySpecName: String, transform: String? = nil, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

View an ActivitySpec.

View an ActivitySpec.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let activitySpecName = "activitySpecName_example" // String | 
let transform = "transform_example" // String |  (optional)

// View an ActivitySpec.
ActivitySpecAPI.activitySpecView(activitySpecName: activitySpecName, transform: transform) { (response, error) in
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
 **activitySpecName** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

