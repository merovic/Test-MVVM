//
//  LoginService.swift
//  Test-MVVM
//
//  Created by Amir Ahmed on 03/01/2022.
//

import Foundation
import Alamofire

protocol LoginService {
    func login(username: String, password: String, deviceID: String, deviceType:String, completion:@escaping (Result<String,Error>)->Void)
}

class AppLoginService: LoginService {
    func login(username: String, password: String, deviceID: String, deviceType:String,  completion: @escaping (Result<String, Error>) -> Void) {
        APIClient.performDecodableRequest(route: APIRouter.login(username: username, password: password, deviceID: deviceID, deviceType: deviceType), completion: completion)
    }
}
