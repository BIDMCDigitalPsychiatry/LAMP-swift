# TypeAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**typeGetAttachment**](TypeAPI.md#typegetattachment) | **GET** /type/{type_id}/attachment/{attachment_key} | 
[**typeGetDynamicAttachment**](TypeAPI.md#typegetdynamicattachment) | **GET** /type/{type_id}/attachment/dynamic/{attachment_key} | 
[**typeListAttachments**](TypeAPI.md#typelistattachments) | **GET** /type/{type_id}/attachment | 
[**typeParent**](TypeAPI.md#typeparent) | **GET** /type/{type_id}/parent | Find the owner(s) of the resource.
[**typeSetAttachment**](TypeAPI.md#typesetattachment) | **PUT** /type/{type_id}/attachment/{attachment_key}/{target} | 
[**typeSetDynamicAttachment**](TypeAPI.md#typesetdynamicattachment) | **PUT** /type/{type_id}/attachment/dynamic/{attachment_key}/{target} | 


# **typeGetAttachment**
```swift
    open class func typeGetAttachment(typeId: String, attachmentKey: String, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let attachmentKey = "attachmentKey_example" // String | 

TypeAPI.typeGetAttachment(typeId: typeId, attachmentKey: attachmentKey) { (response, error) in
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
 **typeId** | **String** |  | 
 **attachmentKey** | **String** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **typeGetDynamicAttachment**
```swift
    open class func typeGetDynamicAttachment(typeId: String, attachmentKey: String, invokeAlways: Bool, includeLogs: Bool, ignoreOutput: Bool, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let attachmentKey = "attachmentKey_example" // String | 
let invokeAlways = true // Bool | 
let includeLogs = true // Bool | 
let ignoreOutput = true // Bool | 

TypeAPI.typeGetDynamicAttachment(typeId: typeId, attachmentKey: attachmentKey, invokeAlways: invokeAlways, includeLogs: includeLogs, ignoreOutput: ignoreOutput) { (response, error) in
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
 **typeId** | **String** |  | 
 **attachmentKey** | **String** |  | 
 **invokeAlways** | **Bool** |  | 
 **includeLogs** | **Bool** |  | 
 **ignoreOutput** | **Bool** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **typeListAttachments**
```swift
    open class func typeListAttachments(typeId: String, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 

TypeAPI.typeListAttachments(typeId: typeId) { (response, error) in
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
 **typeId** | **String** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **typeParent**
```swift
    open class func typeParent(typeId: String, transform: String? = nil, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Find the owner(s) of the resource.

Get the parent type identifier of the data structure referenced by the identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Find the owner(s) of the resource.
TypeAPI.typeParent(typeId: typeId, transform: transform) { (response, error) in
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
 **typeId** | **String** |  | 
 **transform** | **String** |  | [optional] 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **typeSetAttachment**
```swift
    open class func typeSetAttachment(typeId: String, target: String, attachmentKey: String, body: Any, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let target = "target_example" // String | 
let attachmentKey = "attachmentKey_example" // String | 
let body = 987 // Any | 

TypeAPI.typeSetAttachment(typeId: typeId, target: target, attachmentKey: attachmentKey, body: body) { (response, error) in
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
 **typeId** | **String** |  | 
 **target** | **String** |  | 
 **attachmentKey** | **String** |  | 
 **body** | **Any** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **typeSetDynamicAttachment**
```swift
    open class func typeSetDynamicAttachment(typeId: String, target: String, attachmentKey: String, invokeOnce: Bool, dynamicAttachment: DynamicAttachment, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let target = "target_example" // String | 
let attachmentKey = "attachmentKey_example" // String | 
let invokeOnce = true // Bool | 
let dynamicAttachment = DynamicAttachment(key: "key_example", from: "from_example", to: "to_example", triggers: [123], language: "language_example", contents: "contents_example", requirements: [123]) // DynamicAttachment | 

TypeAPI.typeSetDynamicAttachment(typeId: typeId, target: target, attachmentKey: attachmentKey, invokeOnce: invokeOnce, dynamicAttachment: dynamicAttachment) { (response, error) in
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
 **typeId** | **String** |  | 
 **target** | **String** |  | 
 **attachmentKey** | **String** |  | 
 **invokeOnce** | **Bool** |  | 
 **dynamicAttachment** | [**DynamicAttachment**](DynamicAttachment.md) |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

