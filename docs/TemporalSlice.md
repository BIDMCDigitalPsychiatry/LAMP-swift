# TemporalSlice

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**item** | [**Any**](.md) | The item that was interacted with; for example, in a Jewels game, the  corresponding alphabet, or in a survey, the question index. | [optional] 
**value** | [**Any**](.md) | The value of the item that was interacted with; in most games,  this field is  &#x60;null&#x60;, but in a survey, this field is the question  choice index. | [optional] 
**type** | **String** | The type of interaction that for this detail; for example, in  a Jewels game,  &#x60;none&#x60; if the tapped jewel was  incorrect, or &#x60;correct&#x60; if it was correct, or in  a  survey, this field will be &#x60;null&#x60;. | [optional] 
**duration** | **Int64** | The time difference from the previous detail or the  start of the parent result. | [optional] 
**level** | **Int64** | The level of activity for this detail; for example, in  games with multiple  levels, this field might be &#x60;2&#x60; or  &#x60;4&#x60;, but for surveys and other games this field  will be &#x60;null&#x60;. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


