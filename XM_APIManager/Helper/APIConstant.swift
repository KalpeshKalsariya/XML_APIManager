//
//  APIConstant.swift
//  XM_APIManager
//
//  Created by  Kalpesh on 18/03/24.
//

import Foundation

import UIKit

struct APIConstants {
    static let baseURL = "" // put your base url
    static let getCustomersEndpoint = "" // put your API end point
}

struct ConstantMessage {
    static let badRequest = "Bad Request: The server could not understand the request."
    static let unauthorized = "Unauthorized: Authentication is required to access this resource."
    static let forbidden = "Forbidden: You do not have permission to access this resource."
    static let notFound = "Not Found: The requested resource was not found on the server."
    static let methodNotAllowed = "Method Not Allowed: The requested HTTP method is not supported for this resource."
    static let internalServerError = "Internal Server Error: An unexpected error occurred on the server."
    static let notImplemented = "Not Implemented: The server does not support the functionality required to fulfill the request."
    static let badGateway = "Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from the upstream server."
    static let serviceUnavailable = "Service Unavailable: The server is currently unable to handle the request due to temporary overloading or maintenance of the server."
    static let gatewayTimeout = "Gateway Timeout: The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server."
    static let unknownError = "Unknown Error: An unexpected error occurred."
}
