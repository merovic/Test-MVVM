//
//  RegistrationViewModel.swift
//  Test-MVVM
//
//  Created by Amir Ahmed on 03/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class RegistrationViewModel {
    let firstNameText = PublishSubject<String>()
    let lastNameText = PublishSubject<String>()
    let emailAddressText = PublishSubject<String>()
    let phoneNumberText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    let confirmPasswordText = PublishSubject<String>()
    let referralCodeText = PublishSubject<String>()
    
    let dataService: RegistrationService
    
    init(dataService: RegistrationService = AppRegistrationService()) {
        self.dataService = dataService
    }
    
    func registration(action: String, firstName: String, lastName: String, username:String,  phoneNumber:String, userCountryCode:String, password:String, referralCode:String){
        DispatchQueue.global(qos: .userInteractive).async {
            self.dataService.registration(action: "", firstName: firstName, lastName: lastName, username: username, phoneNumber: phoneNumber, userCountryCode: userCountryCode, password: password, referralCode: referralCode, completion: { result  in
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


final class EmailValidator {

    func validate(_ input: String) -> Bool {
        guard
            let regex = try? NSRegularExpression(
                pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                options: [.caseInsensitive]
            )
        else {
            assertionFailure("Regex not valid")
            return false
        }

        let regexFirstMatch = regex
            .firstMatch(
                in: input,
                options: [],
                range: NSRange(location: 0, length: input.count)
            )

        return regexFirstMatch != nil
    }
}

