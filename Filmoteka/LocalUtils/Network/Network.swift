//
//  Network.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Alamofire
import Miji
import SwiftyJSON

// Singleton
class Network {
    static let PROD = "https://api.themoviedb.org/3/search/movie?api_key=\(Secrets.apiKey)&query=" //&page=1

    private(set) static var mainServer = PROD

    static let shared = Network()

    private let bag = Bag()

    func get(
        address: String,
        headers: Alamofire.HTTPHeaders = ["Content-Type": "application/json"],
        shouldHandleErrors: Bool = true,
        shouldHandleTimeout: Bool = true,
        shouldRefreshToken: Bool = true,
        session: Session = AF,
        legacyCall: Bool = true,
        logging: Bool = true,
        dataTransformer: DataTransformer? = nil,
        completion: ((JSON?, Error?, Int?) -> Void)?
    ) {
        let headers = headers

        session.request(address, method: .get, headers: headers).responseData { response in

            switch response.result {
            case let .success(value):
                var value = value
                if let dataTransformer = dataTransformer,
                   let transformedData = dataTransformer.transform(data: response.data)
                {
                    value = transformedData
                }

                let dataJSON = JSON(value)
                if let statusCode = response.response?.statusCode, statusCode != 200 {
                    let rawLocalizedDescription =
                        dataJSON["message"].string ??
                        dataJSON["error"].stringValue

                    let localizedDescription = rawLocalizedDescription.count > 0 ? rawLocalizedDescription : "Server error: \(address.introOutro) (\(statusCode))"

                    completion?(
                        dataJSON,
                        NSError.error(
                            domain: "Network",
                            code: statusCode,
                            localizedDescription: localizedDescription
                        ),
                        statusCode)
                }
                else if let statusCode = response.response?.statusCode, statusCode == 200 {
                    completion?(dataJSON, nil, statusCode)
                }

            case let .failure(error):
                if shouldHandleTimeout {
                    switch error {
                    case .sessionTaskFailed(error: URLError.timedOut):
                        TimeoutRequestRetryFlowController.performGetIfCan(
                            address: address,
                            headers: headers,
                            shouldHandleErrors: shouldHandleErrors,
                            shouldRefreshToken: shouldRefreshToken,
                            session: session,
                            completion: completion
                        )
                    default:
                        completion?(nil, error, response.response?.statusCode)
                    }
                }
                else {
                    completion?(nil, error, response.response?.statusCode)
                }
            }
        }
    }

    func put(
        address: String,
        parameters: [String: Any] = [:],
        headers: Alamofire.HTTPHeaders = ["Content-Type": "application/json"],
        session: Session = AF,
        legacyCall: Bool = true,
        completion: @escaping (JSON?, Error?, Int?) -> Void
    ) {

        let enc: ParameterEncoding = JSONEncoding.default
        
        session.request(
            address,
            method: .put,
            parameters: parameters,
            encoding: enc,
            headers: headers
        )
        .responseData { response in

            switch response.result {
            case let .success(value):
                let dataJSON = JSON(value)
                completion(dataJSON, nil, response.response?.statusCode)

            case let .failure(error):
                completion(nil, error, response.response?.statusCode)
            }
        }
    }

    func patch(
        address: String,
        parameters: [String: Any] = [:],
        headers: Alamofire.HTTPHeaders = ["Content-Type": "application/json"],
        session: Session = AF,
        legacyCall: Bool = true,
        completion: ((JSON?, Error?, Int?) -> Void)? = nil
    ) {

        let enc: ParameterEncoding = JSONEncoding.default
        session.request(
            address,
            method: .patch,
            parameters: parameters,
            encoding: enc,
            headers: headers
        )
        .responseData { response in

            switch response.result {
            case let .success(value):
                let dataJSON = JSON(value)
                completion?(
                    dataJSON,
                    NSError.errorFrom(json: dataJSON),
                    response.response?.statusCode
                )

            case let .failure(error):
                completion?(nil, error, response.response?.statusCode)
            }
        }
    }

    func post(
        address: String,
        shouldHandleErrors: Bool = true,
        parameters: [String: Any] = [:],
        headers: Alamofire.HTTPHeaders = ["Content-Type": "application/json"],
        sendJSON: Bool = true,
        shouldRefreshToken: Bool = true,
        session: Session = AF,
        legacyCall: Bool = true,
        mockResponseKey: String? = nil,
        timeoutInterval: TimeInterval = 60,
        dataTransformer: DataTransformer? = nil,
        completion: ((JSON?, Error?, Int?) -> Void)?
    ) {
        var headers = headers

        var enc: ParameterEncoding = JSONEncoding.default

        if !sendJSON {
            enc = URLEncoding.default
            headers = ["Content-type": "application/x-www-form-urlencoded"]
        }

        if let mockResponseKey = mockResponseKey,
           UserDefaults.standard.bool(forKey: mockResponseKey)
        {
            let filename = address
                .replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: ":", with: "_")
                .replacingOccurrences(of: ".", with: "_")
                + "_mock_response.json"
            if let json = JSON.from(filename: filename) {
                completion?(json, nil, 200)
            }
        }

        session.request(
            address,
            method: .post,
            parameters: parameters,
            encoding: enc,
            headers: headers
        )
            { $0.timeoutInterval = timeoutInterval }
            .responseData { response in

                switch response.result {
                case let .success(value):
                    var dataJSON = JSON(value)
                    if let dataTransformer = dataTransformer,
                       let transformedData = dataTransformer.transform(data: value)
                    {
                        dataJSON = JSON(transformedData)
                    }
                    
                    let statusCode = response.response?.statusCode
                    if statusCode != 200, statusCode != 201, shouldHandleErrors {
                        completion?(
                            nil,
                            NSError.errorFrom(json: dataJSON, defaultStatusCode: response.response?.statusCode ?? -1),
                            response.response?.statusCode
                        )
                    }
                    else {
                        completion?(dataJSON, nil, response.response?.statusCode)
                    }

                case let .failure(error):
                    debugPrint("Request Error: \(String(describing: error)); address: \(address)")

                    completion?(nil, error, response.response?.statusCode)
                }
            }
    }

    func delete(
        address: String,
        session: Session = AF,
        headers: Alamofire.HTTPHeaders = ["Content-Type": "application/json"],
        completion: ((JSON?, Error?, Int?) -> Void)? = nil
    ) {

        session.request(
            address,
            method: .delete,
            headers: headers
        ).responseData { response in

            switch response.result {
            case let .success(value):
                let dataJSON = JSON(value)
                completion?(dataJSON, NSError.errorFrom(json: dataJSON), response.response?.statusCode)

            case let .failure(error):
                completion?(nil, error, response.response?.statusCode)
            }
        }
    }
}

extension Network: RequestDataSource {
    func requestServerAddress(_: Any) -> String {
        return Network.PROD
    }
}
