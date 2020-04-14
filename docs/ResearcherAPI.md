# ResearcherAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**researcherAll**](ResearcherAPI.md#researcherall) | **GET** /researcher | Get the set of all researchers.
[**researcherCreate**](ResearcherAPI.md#researchercreate) | **POST** /researcher | Create a new Researcher.
[**researcherDelete**](ResearcherAPI.md#researcherdelete) | **DELETE** /researcher/{researcher_id} | Delete a researcher.
[**researcherUpdate**](ResearcherAPI.md#researcherupdate) | **PUT** /researcher/{researcher_id} | Update a Researcher&#39;s settings.
[**researcherView**](ResearcherAPI.md#researcherview) | **GET** /researcher/{researcher_id} | Get a single researcher, by identifier.


# **researcherAll**
```swift
    open class func researcherAll(transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of all researchers.

Get the set of all researchers.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let transform = "transform_example" // String |  (optional)

// Get the set of all researchers.
ResearcherAPI.researcherAll(transform: transform) { (response, error) in
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

# **researcherCreate**
```swift
    open class func researcherCreate(researcher: Researcher, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new Researcher.

Create a new Researcher.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcher = Researcher(_id: "_id_example", name: "name_example", email: "email_example", address: "address_example", studies: [123]) // Researcher | 

// Create a new Researcher.
ResearcherAPI.researcherCreate(researcher: researcher) { (response, error) in
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
 **researcher** | [**Researcher**](Researcher.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **researcherDelete**
```swift
    open class func researcherDelete(researcherId: String, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete a researcher.

Delete a researcher.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 

// Delete a researcher.
ResearcherAPI.researcherDelete(researcherId: researcherId) { (response, error) in
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

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **researcherUpdate**
```swift
    open class func researcherUpdate(researcherId: String, researcher: Researcher, transform: String? = nil, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Update a Researcher's settings.

Update a Researcher's settings.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let researcher = Researcher(_id: "_id_example", name: "name_example", email: "email_example", address: "address_example", studies: [123]) // Researcher | 
let transform = "transform_example" // String |  (optional)

// Update a Researcher's settings.
ResearcherAPI.researcherUpdate(researcherId: researcherId, researcher: researcher, transform: transform) { (response, error) in
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
 **researcher** | [**Researcher**](Researcher.md) |  | 
 **transform** | **String** |  | [optional] 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **researcherView**
```swift
    open class func researcherView(researcherId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get a single researcher, by identifier.

Get a single researcher, by identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get a single researcher, by identifier.
ResearcherAPI.researcherView(researcherId: researcherId, transform: transform) { (response, error) in
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

