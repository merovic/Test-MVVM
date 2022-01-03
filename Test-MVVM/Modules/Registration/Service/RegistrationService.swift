//
//  RegistrationService.swift
//  Test-MVVM
//
//  Created by Amir Ahmed on 03/01/2022.
//

import Foundation
import Alamofire

protocol RegistrationService {
    func registration(action: String, firstName: String, lastName: String, username:String,  phoneNumber:String, userCountryCode:String, password:String, referralCode:String, completion:@escaping (Result<String,Error>)->Void)
}

class AppRegistrationService: RegistrationService {
    func registration(action: String, firstName: String, lastName: String, username: String, phoneNumber: String, userCountryCode: String, password: String, referralCode: String, completion: @escaping (Result<String, Error>) -> Void) {
        APIClient.performDecodableRequest(route: APIRouter.registration(action: action, firstName: firstName, lastName: lastName, userName: username, phoneNumber: phoneNumber, countryCode: userCountryCode, password: password, referralCode: referralCode), completion: completion)
    }
}

