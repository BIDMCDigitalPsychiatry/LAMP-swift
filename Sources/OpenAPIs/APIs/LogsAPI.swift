//
// SensorEventAPI.swift
//

import Foundation
import Combine

public enum LogsLevel: String {
    case info
    case warning
    case error
    case fatal
    
    public var levelValue: Int {
        switch self {
            
        case .info:
            return 1
        case .warning:
            return 2
        case .error:
            return 3
        case .fatal:
            return 4
        }
    }
}

extension LogsLevel: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

public struct LogsData {
    
    public struct Request: Codable {
        public let dataBody: Body
        public let urlParams: Params
        public init(dataBody: Body, urlParams: Params) {
            self.dataBody = dataBody
            self.urlParams = urlParams
        }
    }
    
    public struct Response: Codable {
    }
}

extension LogsData {
    
    public struct Body: Codable {
        let userId: String?
        let userAgent: String
        let message: String?
        
        public init(userId: String?, userAgent: String, message: String?) {
            self.userId = userId
            self.userAgent = userAgent
            self.message = message
        }
    }

    public struct Params: Codable {
        let origin: String
        let level: LogsLevel
        public init(origin: String, level: LogsLevel) {
            self.origin = origin
            self.level = level
        }
    }
}


public struct LogsAPI {

    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func logsCreate(participantId: String, logsData: LogsData.Request, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue) -> AnyPublisher<String, Error> {
        return Future<String, Error>.init { promisse in
            logsCreateWithRequestBuilder(participantId: participantId, logsData: logsData).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    promisse(.success(response.body!))
                case let .failure(error):
                    promisse(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public static func logsCreateWithRequestBuilder(participantId: String, logsData: LogsData.Request) -> RequestBuilder<String> {
        let path = "/"
        let URLString = OpenAPIClientAPI.logsBasePath + path
        var parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: logsData.urlParams)
        parameters?[JSONDataEncoding.explicitHttpBody] = logsData.dataBody
        
        let url = URLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<String>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}

