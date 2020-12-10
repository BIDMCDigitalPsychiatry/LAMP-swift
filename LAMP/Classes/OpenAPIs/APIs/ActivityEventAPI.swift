//
// ActivityEventAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import Combine

extension LAMPAPI {


@objc open class ActivityEventAPI : NSObject {
    /**
     Get all activity events for a participant.
     
     - parameter participantId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityEventAllByParticipant(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, apiResponseQueue: DispatchQueue = LAMPAPI.apiResponseQueue) -> AnyPublisher<[Any], Error> {
        return Future<[Any], Error>.init { promisse in
            activityEventAllByParticipantWithRequestBuilder(participantId: participantId, origin: origin, from: from, to: to, transform: transform).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promisse(.success(response.body!))
                case let .failure(error):
                    promisse(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     Get all activity events for a participant.
     - GET /participant/{participant_id}/activity_event
     - Get the set of all activity events produced by a given participant,  by identifier.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter participantId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityEventAllByParticipantWithRequestBuilder(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil) -> RequestBuilder<[Any]> {
        var path = "/participant/{participant_id}/activity_event"
        let participantIdPreEscape = "\(APIHelper.mapValueToPathItem(participantId))"
        let participantIdPostEscape = participantIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{participant_id}", with: participantIdPostEscape, options: .literal, range: nil)
        let URLString = LAMPAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "origin": origin?.encodeToJSON(), 
            "from": from?.encodeToJSON(), 
            "to": to?.encodeToJSON(), 
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[Any]>.Type = LAMPAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get all activity events for a researcher by participant.
     
     - parameter researcherId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityEventAllByResearcher(researcherId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, apiResponseQueue: DispatchQueue = LAMPAPI.apiResponseQueue) -> AnyPublisher<[Any], Error> {
        return Future<[Any], Error>.init { promisse in
            activityEventAllByResearcherWithRequestBuilder(researcherId: researcherId, origin: origin, from: from, to: to, transform: transform).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promisse(.success(response.body!))
                case let .failure(error):
                    promisse(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     Get all activity events for a researcher by participant.
     - GET /researcher/{researcher_id}/activity_event
     - Get the set of all activity events produced by participants of any  study conducted by a researcher, by researcher identifier.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter researcherId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityEventAllByResearcherWithRequestBuilder(researcherId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil) -> RequestBuilder<[Any]> {
        var path = "/researcher/{researcher_id}/activity_event"
        let researcherIdPreEscape = "\(APIHelper.mapValueToPathItem(researcherId))"
        let researcherIdPostEscape = researcherIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{researcher_id}", with: researcherIdPostEscape, options: .literal, range: nil)
        let URLString = LAMPAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "origin": origin?.encodeToJSON(), 
            "from": from?.encodeToJSON(), 
            "to": to?.encodeToJSON(), 
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[Any]>.Type = LAMPAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get all activity events for a study by participant.
     
     - parameter studyId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<[Any], Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityEventAllByStudy(studyId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, apiResponseQueue: DispatchQueue = LAMPAPI.apiResponseQueue) -> AnyPublisher<[Any], Error> {
        return Future<[Any], Error>.init { promisse in
            activityEventAllByStudyWithRequestBuilder(studyId: studyId, origin: origin, from: from, to: to, transform: transform).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promisse(.success(response.body!))
                case let .failure(error):
                    promisse(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     Get all activity events for a study by participant.
     - GET /study/{study_id}/activity_event
     - Get the set of all activity events produced by participants of a  single study, by study identifier.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter studyId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<[Any]> 
     */
    open class func activityEventAllByStudyWithRequestBuilder(studyId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil) -> RequestBuilder<[Any]> {
        var path = "/study/{study_id}/activity_event"
        let studyIdPreEscape = "\(APIHelper.mapValueToPathItem(studyId))"
        let studyIdPostEscape = studyIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{study_id}", with: studyIdPostEscape, options: .literal, range: nil)
        let URLString = LAMPAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "origin": origin?.encodeToJSON(), 
            "from": from?.encodeToJSON(), 
            "to": to?.encodeToJSON(), 
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[Any]>.Type = LAMPAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Create a new ActivityEvent for the given Participant.
     
     - parameter participantId: (path)  
     - parameter activityEvent: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<String, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityEventCreate(participantId: String, activityEvent: ActivityEvent, apiResponseQueue: DispatchQueue = LAMPAPI.apiResponseQueue) -> AnyPublisher<String, Error> {
        return Future<String, Error>.init { promisse in
            activityEventCreateWithRequestBuilder(participantId: participantId, activityEvent: activityEvent).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promisse(.success(response.body!))
                case let .failure(error):
                    promisse(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     Create a new ActivityEvent for the given Participant.
     - POST /participant/{participant_id}/activity_event
     - Create a new ActivityEvent for the given Participant.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter participantId: (path)  
     - parameter activityEvent: (body)  
     - returns: RequestBuilder<String> 
     */
    open class func activityEventCreateWithRequestBuilder(participantId: String, activityEvent: ActivityEvent) -> RequestBuilder<String> {
        var path = "/participant/{participant_id}/activity_event"
        let participantIdPreEscape = "\(APIHelper.mapValueToPathItem(participantId))"
        let participantIdPostEscape = participantIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{participant_id}", with: participantIdPostEscape, options: .literal, range: nil)
        let URLString = LAMPAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: activityEvent)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<String>.Type = LAMPAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Delete a ActivityEvent.
     
     - parameter participantId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: AnyPublisher<String, Error>
     */
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func activityEventDelete(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil, apiResponseQueue: DispatchQueue = LAMPAPI.apiResponseQueue) -> AnyPublisher<String, Error> {
        return Future<String, Error>.init { promisse in
            activityEventDeleteWithRequestBuilder(participantId: participantId, origin: origin, from: from, to: to, transform: transform).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promisse(.success(response.body!))
                case let .failure(error):
                    promisse(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    /**
     Delete a ActivityEvent.
     - DELETE /participant/{participant_id}/activity_event
     - Delete a ActivityEvent.
     - API Key:
       - type: apiKey Authorization 
       - name: Authorization
     - parameter participantId: (path)  
     - parameter origin: (query)  (optional)
     - parameter from: (query)  (optional)
     - parameter to: (query)  (optional)
     - parameter transform: (query)  (optional)
     - returns: RequestBuilder<String> 
     */
    open class func activityEventDeleteWithRequestBuilder(participantId: String, origin: String? = nil, from: Double? = nil, to: Double? = nil, transform: String? = nil) -> RequestBuilder<String> {
        var path = "/participant/{participant_id}/activity_event"
        let participantIdPreEscape = "\(APIHelper.mapValueToPathItem(participantId))"
        let participantIdPostEscape = participantIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{participant_id}", with: participantIdPostEscape, options: .literal, range: nil)
        let URLString = LAMPAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "origin": origin?.encodeToJSON(), 
            "from": from?.encodeToJSON(), 
            "to": to?.encodeToJSON(), 
            "transform": transform?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<String>.Type = LAMPAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
}