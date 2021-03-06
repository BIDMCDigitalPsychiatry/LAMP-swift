//
// ActivityAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import Combine



open class ActivityAPI {
    
    public struct Response: Decodable {
        public let data: [Activity]
    }
    /**
     Get the set of all activities.
     
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityAll(transform: String? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<[Any], Error> {
        return Future<[Any], Error>.init { promise in
            activityAllWithRequestBuilder(transform: transform).execute(apiResponseQueue) { result -> Void in
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
     Get the set of all activities.
     - GET /activity
     - Get the set of all activities.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityAllWithRequestBuilder(transform: String? = nil) -> RequestBuilder<[AnyCodable]> {
        let path = "/activity"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:AnyCodable]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[AnyCodable]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get all activities for a participant.
     
     - parameter participantId: (path)  
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityAllByParticipant(participantId: String, transform: String? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<ActivityAPI.Response, Error> {
        return Future<ActivityAPI.Response, Error>.init { promise in
            activityAllByParticipantWithRequestBuilder(participantId: participantId, transform: transform).execute(apiResponseQueue) { result -> Void in
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
     Get all activities for a participant.
     - GET /participant/{participant_id}/activity
     - Get the set of all activities available to a participant, by  participant identifier.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter participantId: (path)  
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityAllByParticipantWithRequestBuilder(participantId: String, transform: String? = nil) -> RequestBuilder<ActivityAPI.Response> {
        var path = "/participant/{participant_id}/activity"
        let participantIdPreEscape = "\(APIHelper.mapValueToPathItem(participantId))"
        let participantIdPostEscape = participantIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{participant_id}", with: participantIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:AnyCodable]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "ignore_binary": true
        ])
        let requestBuilder: RequestBuilder<ActivityAPI.Response>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get all activities for a researcher.
     
     - parameter researcherId: (path)  
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityAllByResearcher(researcherId: String, transform: String? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<[Any], Error> {
        return Future<[Any], Error>.init { promise in
            activityAllByResearcherWithRequestBuilder(researcherId: researcherId, transform: transform).execute(apiResponseQueue) { result -> Void in
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
     Get all activities for a researcher.
     - GET /researcher/{researcher_id}/activity
     - Get the set of all activities available to participants of any study  conducted by a researcher, by researcher identifier.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter researcherId: (path)  
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityAllByResearcherWithRequestBuilder(researcherId: String, transform: String? = nil) -> RequestBuilder<[AnyCodable]> {
        var path = "/researcher/{researcher_id}/activity"
        let researcherIdPreEscape = "\(APIHelper.mapValueToPathItem(researcherId))"
        let researcherIdPostEscape = researcherIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{researcher_id}", with: researcherIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:AnyCodable]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[AnyCodable]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get all activities in a study.
     
     - parameter studyId: (path)  
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityAllByStudy(studyId: String, transform: String? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<[Any], Error> {
        return Future<[Any], Error>.init { promise in
            activityAllByStudyWithRequestBuilder(studyId: studyId, transform: transform).execute(apiResponseQueue) { result -> Void in
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
     Get all activities in a study.
     - GET /study/{study_id}/activity
     - Get the set of all activities available to  participants of a single  study, by study identifier.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter studyId: (path)  
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityAllByStudyWithRequestBuilder(studyId: String, transform: String? = nil) -> RequestBuilder<[AnyCodable]> {
        var path = "/study/{study_id}/activity"
        let studyIdPreEscape = "\(APIHelper.mapValueToPathItem(studyId))"
        let studyIdPostEscape = studyIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{study_id}", with: studyIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:AnyCodable]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[AnyCodable]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Create a new Activity under the given Study.
     
     - parameter studyId: (path)  
     - parameter activity: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<String, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityCreate(studyId: String, activity: Activity, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<String, Error> {
        return Future<String, Error>.init { promise in
            activityCreateWithRequestBuilder(studyId: studyId, activity: activity).execute(apiResponseQueue) { result -> Void in
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
     Create a new Activity under the given Study.
     - POST /study/{study_id}/activity
     - Create a new Activity under the given Study.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter studyId: (path)  
     - parameter activity: (body)  
     - returns: RequestBuilder<String> 
     */
    open class func activityCreateWithRequestBuilder(studyId: String, activity: Activity) -> RequestBuilder<String> {
        var path = "/study/{study_id}/activity"
        let studyIdPreEscape = "\(APIHelper.mapValueToPathItem(studyId))"
        let studyIdPostEscape = studyIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{study_id}", with: studyIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: activity)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<String>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Delete an Activity.
     
     - parameter activityId: (path)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<String, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityDelete(activityId: String, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<String, Error> {
        return Future<String, Error>.init { promise in
            activityDeleteWithRequestBuilder(activityId: activityId).execute(apiResponseQueue) { result -> Void in
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
     Delete an Activity.
     - DELETE /activity/{activity_id}
     - Delete an Activity.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter activityId: (path)  
     - returns: RequestBuilder<String> 
     */
    open class func activityDeleteWithRequestBuilder(activityId: String) -> RequestBuilder<String> {
        var path = "/activity/{activity_id}"
        let activityIdPreEscape = "\(APIHelper.mapValueToPathItem(activityId))"
        let activityIdPostEscape = activityIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{activity_id}", with: activityIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<String>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update an Activity's settings.
     
     - parameter activityId: (path)  
     - parameter activity: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<String, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityUpdate(activityId: String, activity: Activity, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<String, Error> {
        return Future<String, Error>.init { promise in
            activityUpdateWithRequestBuilder(activityId: activityId, activity: activity).execute(apiResponseQueue) { result -> Void in
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
     Update an Activity's settings.
     - PUT /activity/{activity_id}
     - Update an Activity's settings.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter activityId: (path)  
     - parameter activity: (body)  
     - returns: RequestBuilder<String> 
     */
    open class func activityUpdateWithRequestBuilder(activityId: String, activity: Activity) -> RequestBuilder<String> {
        var path = "/activity/{activity_id}"
        let activityIdPreEscape = "\(APIHelper.mapValueToPathItem(activityId))"
        let activityIdPostEscape = activityIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{activity_id}", with: activityIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: activity)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<String>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Get a single activity, by identifier.
     
     - parameter activityId: (path)  
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityView(activityId: String, transform: String? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<[Any], Error> {
        return Future<[Any], Error>.init { promise in
            activityViewWithRequestBuilder(activityId: activityId, transform: transform).execute(apiResponseQueue) { result -> Void in
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
     Get a single activity, by identifier.
     - GET /activity/{activity_id}
     - Get a single activity, by identifier.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter activityId: (path)  
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityViewWithRequestBuilder(activityId: String, transform: String? = nil) -> RequestBuilder<[AnyCodable]> {
        var path = "/activity/{activity_id}"
        let activityIdPreEscape = "\(APIHelper.mapValueToPathItem(activityId))"
        let activityIdPostEscape = activityIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{activity_id}", with: activityIdPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:AnyCodable]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[AnyCodable]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
