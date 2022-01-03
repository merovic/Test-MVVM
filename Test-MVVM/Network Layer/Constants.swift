//
//  Constants.swift
//  swiftui-mvvm
//
//  Created by Apple on 28/09/2021.
//

import Foundation

struct K {
    
    struct ProductionServer {
        
        static let baseURL = "https://store.zeew.eu/v1/"
    }
    
    struct APIParameterKeyLogin {
        static let username = "username"
        static let password = "password"
        static let deviceId = "device_id"
        static let deviceType = "device_type"
    }
    
    struct APIParameterKeyRegistration {
        static let action = "action"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let username = "username"
        static let phoneNumber = "phone_number"
        static let userCountryCode = "user_country_code"
        static let password = "password"
        static let referralCode = "referral_code"
    }

}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
