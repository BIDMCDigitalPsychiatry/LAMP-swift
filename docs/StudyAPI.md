# StudyAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**studyAll**](StudyAPI.md#studyall) | **GET** /study | Get the set of all studies.
[**studyAllByResearcher**](StudyAPI.md#studyallbyresearcher) | **GET** /researcher/{researcher_id}/study | Get the set of studies for a single researcher.
[**studyCreate**](StudyAPI.md#studycreate) | **POST** /researcher/{researcher_id}/study | Create a new Study for the given Researcher.
[**studyDelete**](StudyAPI.md#studydelete) | **DELETE** /study/{study_id} | Delete a study.
[**studyUpdate**](StudyAPI.md#studyupdate) | **PUT** /study/{study_id} | Update the study.
[**studyView**](StudyAPI.md#studyview) | **GET** /study/{study_id} | Get a single study, by identifier.


# **studyAll**
```swift
    open class func studyAll(transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of all studies.

Get the set of all studies.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let transform = "transform_example" // String |  (optional)

// Get the set of all studies.
StudyAPI.studyAll(transform: transform) { (response, error) in
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

# **studyAllByResearcher**
```swift
    open class func studyAllByResearcher(researcherId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get the set of studies for a single researcher.

Get the set of studies for a single researcher.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get the set of studies for a single researcher.
StudyAPI.studyAllByResearcher(researcherId: researcherId, transform: transform) { (response, error) in
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

# **studyCreate**
```swift
    open class func studyCreate(researcherId: String, study: Study, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Create a new Study for the given Researcher.

Create a new Study for the given Researcher.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let researcherId = "researcherId_example" // String | 
let study = Study(_id: "_id_example", name: "name_example", activities: [123], participants: [123]) // Study | 

// Create a new Study for the given Researcher.
StudyAPI.studyCreate(researcherId: researcherId, study: study) { (response, error) in
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
 **study** | [**Study**](Study.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studyDelete**
```swift
    open class func studyDelete(studyId: String, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Delete a study.

Delete a study.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 

// Delete a study.
StudyAPI.studyDelete(studyId: studyId) { (response, error) in
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

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studyUpdate**
```swift
    open class func studyUpdate(studyId: String, study: Study, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```

Update the study.

Update the study.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let study = Study(_id: "_id_example", name: "name_example", activities: [123], participants: [123]) // Study | 

// Update the study.
StudyAPI.studyUpdate(studyId: studyId, study: study) { (response, error) in
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
 **study** | [**Study**](Study.md) |  | 

### Return type

**String**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studyView**
```swift
    open class func studyView(studyId: String, transform: String? = nil, completion: @escaping (_ data: [Any]?, _ error: Error?) -> Void)
```

Get a single study, by identifier.

Get a single study, by identifier.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let studyId = "studyId_example" // String | 
let transform = "transform_example" // String |  (optional)

// Get a single study, by identifier.
StudyAPI.studyView(studyId: studyId, transform: transform) { (response, error) in
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

