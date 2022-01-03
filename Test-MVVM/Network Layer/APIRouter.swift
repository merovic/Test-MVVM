//
//  APIRouter.swift
//  swiftui-mvvm
//
//  Created by Apple on 28/09/2021.
//

import Alamofire

public enum RequestParameterMethod: String {
    case pathParam   = "pathParam"
    case queryParam  = "queryParam"
    case formParam   = "formParam"
}

enum APIRouter: URLRequestConvertible {
    
    case login(username:String, password:String, deviceID:String, deviceType:String)
    case registration(action:String, firstName:String, lastName:String, userName:String, phoneNumber:String, countryCode:String, password:String, referralCode:String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login, .registration:
            return .post
        }
    }
    
    
    // MARK: - EndPoint
    private var endpoint: String {
        switch self {
        case .login, .registration:
            return K.ProductionServer.baseURL
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "CustomerLogin"
        case .registration:
            return "CustomerSignUp"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(username: let username, password: let password, deviceID: let deviceID, deviceType: let deviceType):
            return [K.APIParameterKeyLogin.username: username,K.APIParameterKeyLogin.password: password,K.APIParameterKeyLogin.deviceId: deviceID,K.APIParameterKeyLogin.deviceType: deviceType]
        case .registration(action: let action, firstName: let firstName, lastName: let lastName, userName: let userName, phoneNumber: let phoneNumber, countryCode: let countryCode, password: let password, referralCode: let referralCode):
            return [K.APIParameterKeyRegistration.action: action,K.APIParameterKeyRegistration.firstName: firstName,K.APIParameterKeyRegistration.lastName: lastName,K.APIParameterKeyRegistration.username: userName,K.APIParameterKeyRegistration.phoneNumber: phoneNumber,K.APIParameterKeyRegistration.userCountryCode: countryCode,K.APIParameterKeyRegistration.password: password,K.APIParameterKeyRegistration.referralCode: referralCode]
        }
    }
    
    // MARK: - RequestParameterMethod
    private var requestParameter: RequestParameterMethod {
        switch self {
        case .login,.registration:
            return .formParam
        }
    }
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = try endpoint.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTPMethod
        urlRequest.httpMethod = method.rawValue
        
        // Header
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        //-------------
        
        //urlRequest.setValue("Bearer " + "", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        // Parameters
        switch requestParameter {
        case .queryParam:
            if let parameters = parameters {
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)} else{
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)
            }
        case .pathParam:
            break
        case .formParam:
            if let parameters = parameters {
                do {urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])} catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))}
            }
        }
       
        return urlRequest
    }
}


