//
//  APIManager.swift
//  XM_APIManager
//
//  Created by  Kalpesh on 18/03/24.
//

import Foundation

// APIManager is a singleton class that manages API requests.
class APIManager {
    // Shared instance of APIManager.
    static let shared = APIManager()
    
    // Private initializer to ensure only one instance of APIManager is created.
    private init() {}
    
    // Function to send a request to a given URL with optional parameters.
    // The completion handler returns a Result type that contains either the JSON response or an Error.
    func makeSOAPRequest(soapMessage: String, url: URL, method: HTTPMethod = .get, parameters: [String: Any]? = nil, isShowLoader: Bool = true, completion: @escaping (Result<Data, Error>) -> Void) {
        
        if isShowLoader {
            // show loader
        }
        
        // Create a URLRequest object with the given URL.
        var request = URLRequest(url: url)
        // Set the HTTP method of the request.
        request.httpMethod = method.rawValue
        request.httpBody = soapMessage.data(using: .utf8)
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        // Create a data task with the request and a completion handler.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if isShowLoader {
                // hide loader
            }
            
            // If an error occurred, pass the error to the completion handler.
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure the response is an HTTPURLResponse, otherwise pass an error to the completion handler.
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            // Handle the HTTP status code of the response.
            switch httpResponse.statusCode {
            case 200...299:
                // If the status code is 2xx, try to parse the data as JSON.
                if let data = data {
                    completion(.success(data))
                }
                else {
                    completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                }
            default:
                // If the status code is not in the 2xx range, create an error with the appropriate message.
                let errorMessage = self.errorMessage(forStatusCode: httpResponse.statusCode)
                completion(.failure(NSError(domain: errorMessage, code: httpResponse.statusCode, userInfo: nil)))
            }
        }
        
        // Start the data task.
        task.resume()
    }
    
    // Function to return error message for a given status code.
    private func errorMessage(forStatusCode statusCode: Int) -> String {
        switch statusCode {
        case 400:
            return ConstantMessage.badRequest
        case 401:
            return ConstantMessage.unauthorized
        case 403:
            return ConstantMessage.forbidden
        case 404:
            return ConstantMessage.notFound
        case 405:
            return ConstantMessage.methodNotAllowed
        case 500:
            return ConstantMessage.internalServerError
        case 501:
            return ConstantMessage.notImplemented
        case 502:
            return ConstantMessage.badGateway
        case 503:
            return ConstantMessage.serviceUnavailable
        case 504:
            return ConstantMessage.gatewayTimeout
        default:
            return ConstantMessage.unknownError
        }
    }

}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    // Add other HTTP methods as needed
}

