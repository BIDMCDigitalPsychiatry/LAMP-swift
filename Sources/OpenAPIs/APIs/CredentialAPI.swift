//
// CredentialAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import Combine



open class CredentialAPI {
    /**

     - parameter typeId: (path)
     - parameter body: (body)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<Any, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func credentialCreate(typeId: String, body: AnyCodable, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<AnyCodable, Error> {
        return Future<AnyCodable, Error>.init { promise in
            credentialCreateWithRequestBuilder(typeId: typeId, body: body).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promise(.success(response.body!))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     - POST /type/{type_id}/credential
     - API Key:
       - type: apiKey Authorization
       - name: Authorization
     - parameter typeId: (path)
     - parameter body: (body)
     - returns: RequestBuilder<Any>
     */
    open class func credentialCreateWithRequestBuilder(typeId: String, body: AnyCodable) -> RequestBuilder<AnyCodable> {
        var path = "/type/{type_id}/credential"
        let typeIdPreEscape = "\(APIHelper.mapValueToPathItem(typeId))"
        let typeIdPostEscape = typeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{type_id}", with: typeIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<AnyCodable>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**

     - parameter typeId: (path)
     - parameter accessKey: (path)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<Any, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func credentialDelete(typeId: String, accessKey: String, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<Any, Error> {
        return Future<Any, Error>.init { promise in
            credentialDeleteWithRequestBuilder(typeId: typeId, accessKey: accessKey).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promise(.success(response.body!))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     - DELETE /type/{type_id}/credential/{access_key}
     - API Key:
       - type: apiKey Authorization
       - name: Authorization
     - parameter typeId: (path)
     - parameter accessKey: (path)
     - returns: RequestBuilder<Any>
     */
    open class func credentialDeleteWithRequestBuilder(typeId: String, accessKey: String) -> RequestBuilder<AnyCodable> {
        var path = "/type/{type_id}/credential/{access_key}"
        let typeIdPreEscape = "\(APIHelper.mapValueToPathItem(typeId))"
        let typeIdPostEscape = typeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{type_id}", with: typeIdPostEscape, options: .literal, range: nil)
        let accessKeyPreEscape = "\(APIHelper.mapValueToPathItem(accessKey))"
        let accessKeyPostEscape = accessKeyPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{access_key}", with: accessKeyPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:AnyCodable]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<AnyCodable>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter typeId: (path)
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<Any, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func credentialList(typeId: String, transform: String? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<Any, Error> {
        return Future<Any, Error>.init { promise in
            credentialListWithRequestBuilder(typeId: typeId, transform: transform).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promise(.success(response.body!))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     - GET /type/{type_id}/credential
     - API Key:
       - type: apiKey Authorization
       - name: Authorization
     - parameter typeId: (path)
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<Any>
     */
    open class func credentialListWithRequestBuilder(typeId: String, transform: String? = nil) -> RequestBuilder<AnyCodable> {
        var path = "/type/{type_id}/credential"
        let typeIdPreEscape = "\(APIHelper.mapValueToPathItem(typeId))"
        let typeIdPostEscape = typeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{type_id}", with: typeIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:AnyCodable]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<AnyCodable>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter typeId: (path)
     - parameter accessKey: (path)
     - parameter body: (body)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<Any, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func credentialUpdate(typeId: String, accessKey: String, body: AnyCodable, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<AnyCodable, Error> {
        return Future<AnyCodable, Error>.init { promise in
            credentialUpdateWithRequestBuilder(typeId: typeId, accessKey: accessKey, body: body).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promise(.success(response.body!))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     - PUT /type/{type_id}/credential/{access_key}
     - API Key:
       - type: apiKey Authorization
       - name: Authorization
     - parameter typeId: (path)
     - parameter accessKey: (path)
     - parameter body: (body)
     - returns: RequestBuilder<Any>
     */
    open class func credentialUpdateWithRequestBuilder(typeId: String, accessKey: String, body: AnyCodable) -> RequestBuilder<AnyCodable> {
        var path = "/type/{type_id}/credential/{access_key}"
        let typeIdPreEscape = "\(APIHelper.mapValueToPathItem(typeId))"
        let typeIdPostEscape = typeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{type_id}", with: typeIdPostEscape, options: .literal, range: nil)
        let accessKeyPreEscape = "\(APIHelper.mapValueToPathItem(accessKey))"
        let accessKeyPostEscape = accessKeyPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{access_key}", with: accessKeyPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<AnyCodable>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
