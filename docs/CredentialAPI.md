# CredentialAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**credentialCreate**](CredentialAPI.md#credentialcreate) | **POST** /type/{type_id}/credential | 
[**credentialDelete**](CredentialAPI.md#credentialdelete) | **DELETE** /type/{type_id}/credential/{access_key} | 
[**credentialList**](CredentialAPI.md#credentiallist) | **GET** /type/{type_id}/credential | 
[**credentialUpdate**](CredentialAPI.md#credentialupdate) | **PUT** /type/{type_id}/credential/{access_key} | 


# **credentialCreate**
```swift
    open class func credentialCreate(typeId: String, body: Any, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let body = 987 // Any | 

CredentialAPI.credentialCreate(typeId: typeId, body: body) { (response, error) in
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
 **body** | **Any** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **credentialDelete**
```swift
    open class func credentialDelete(typeId: String, accessKey: String, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let accessKey = "accessKey_example" // String | 

CredentialAPI.credentialDelete(typeId: typeId, accessKey: accessKey) { (response, error) in
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
 **accessKey** | **String** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **credentialList**
```swift
    open class func credentialList(typeId: String, transform: String? = nil, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let transform = "transform_example" // String |  (optional)

CredentialAPI.credentialList(typeId: typeId, transform: transform) { (response, error) in
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

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **credentialUpdate**
```swift
    open class func credentialUpdate(typeId: String, accessKey: String, body: Any, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let typeId = "typeId_example" // String | 
let accessKey = "accessKey_example" // String | 
let body = 987 // Any | 

CredentialAPI.credentialUpdate(typeId: typeId, accessKey: accessKey, body: body) { (response, error) in
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
 **accessKey** | **String** |  | 
 **body** | **Any** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

