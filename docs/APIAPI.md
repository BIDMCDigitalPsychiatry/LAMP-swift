# APIAPI

All URIs are relative to *https://api.lamp.digital*

Method | HTTP request | Description
------------- | ------------- | -------------
[**aPIQuery**](APIAPI.md#apiquery) | **POST** / | Query the LAMP Database.
[**aPISchema**](APIAPI.md#apischema) | **GET** / | View the API schema document.


# **aPIQuery**
```swift
    open class func aPIQuery(body: String, completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```

Query the LAMP Database.

Query the LAMP Database using a transformation document. All GET operations in this API schema document are available by replacing the period with an underscore (i.e. `$Participant_view(...)` instead of `Participant.view(...)`). The `origin`, `from`, and `to` parameters of EventStream functions are preserved but the `transform` parameter is not.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP

let body = "body_example" // String | 

// Query the LAMP Database.
APIAPI.aPIQuery(body: body) { (response, error) in
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
 **body** | **String** |  | 

### Return type

**Any**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: text/plain, application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **aPISchema**
```swift
    open class func aPISchema(completion: @escaping (_ data: Any?, _ error: Error?) -> Void)
```

View the API schema document.

View this API schema document from a live server instance.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import LAMP


// View the API schema document.
APIAPI.aPISchema() { (response, error) in
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
This endpoint does not need any parameter.

### Return type

**Any**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

