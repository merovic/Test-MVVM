//
//  RegistrationViewController.swift
//  Test-MVVM
//
//  Created by Amir Ahmed on 02/01/2022.
//

import UIKit
import CountryPickerView
import RxCocoa
import RxSwift

class RegistrationViewController: UIViewController {
    
    let emailValidator = EmailValidator()
    
    private let viewModel = RegistrationViewModel()
    private let disposeBag = DisposeBag()

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var referalCodeTextField: UITextField!
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var countryPicker: CountryPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryPicker.showCountryCodeInView = false
        countryPicker.showCountryNameInView = false
        countryPicker.setCountryByCode("EG")
        countryPicker.font = .systemFont(ofSize: 12)
        
        joinButton.layer.cornerRadius = 20.0
        joinButton.layer.borderWidth = 1.0
        joinButton.layer.borderColor = #colorLiteral(red: 0.3692265153, green: 0.8406668305, blue: 0, alpha: 1)
        
        
    }
    
    func Bind(){
        joinButton.rx.tap.bind { [self] in
            emailAddressTextField.rx.text
               .orEmpty
               .map(emailValidator.validate)
               .subscribe(onNext: { isValid in
                   if isValid{
                       viewModel.registration(action: "CustomerSignUp", firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, username: emailAddressTextField.text!, phoneNumber: phoneNumberTextField.text!, userCountryCode: countryPicker.selectedCountry.code, password: passwordTextField.text!, referralCode: referalCodeTextField.text!)
                   }
               })
               .disposed(by: disposeBag)
        }.disposed(by: disposeBag)
    }
    
}
