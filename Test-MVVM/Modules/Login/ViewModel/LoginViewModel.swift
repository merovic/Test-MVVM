//
//  LoginViewModel.swift
//  Test-MVVM
//
//  Created by Amir Ahmed on 03/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let emailAddressText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    let dataService: LoginService
    
    init(dataService: LoginService = AppLoginService()) {
        self.dataService = dataService
    }
    
    func login(username: String, password: String){
        DispatchQueue.global(qos: .userInteractive).async {
            self.dataService.login(username: username, password: password, deviceID: "FirebaseToken", deviceType: "iOS", completion: { result  in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }

    func isValid() -> Observable<Bool> {
        Observable.combineLatest(emailAddressText.asObservable().startWith(""), passwordText.asObservable().startWith("")).map { username, password in
            return username.count > 3 && password.count > 3
        }.startWith(false)
    }
}
