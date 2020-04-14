# DynamicAttachment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**key** | **String** | The key. | [optional] 
**from** | **String** | A globally unique reference for objects. | [optional] 
**to** | **String** | Either \&quot;me\&quot; to apply to the attachment owner only, the ID of an object owned  by the attachment owner, or a string representing the child object type to apply to. | [optional] 
**triggers** | **[Any]** | The API triggers that activate script execution. These will be event stream types  or object types in the API, or, if scheduling execution periodically, a cron-job string  prefixed with \&quot;!\&quot; (exclamation point). | [optional] 
**language** | **String** | The script language. | [optional] 
**contents** | **String** | The script contents. | [optional] 
**requirements** | **[Any]** | The script requirements. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


