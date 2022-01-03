//
//  ViewController.swift
//  Test-MVVM
//
//  Created by mhs on 02/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    let emailValidator = EmailValidator()
    private let viewModel = LoginViewModel()
    private let dis = DisposeBag()
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var eyeButton: UIButton!
    
    @IBOutlet weak var faceBookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    var isSecureText = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 15.0
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = CGColor(red: 127, green: 212, blue: 28, alpha: 1)
        
        faceBookButton.layer.cornerRadius = 15.0
        faceBookButton.layer.borderWidth = 1.0
        faceBookButton.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        googleButton.layer.cornerRadius = 15.0
        googleButton.layer.borderWidth = 1.0
        googleButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        bindViews()
    }
    
    func bindViews(){
        emailAddressTextField.becomeFirstResponder()
        
        emailAddressTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.emailAddressText).disposed(by: dis)
        passwordTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordText).disposed(by: dis)
        
        viewModel.isValid().bind(to: signInButton.rx.isEnabled).disposed(by: dis)
        viewModel.isValid().map { $0 ? 1 : 0.1}.bind(to: signInButton.rx.alpha).disposed(by: dis)
        
        signInButton.rx.tap.bind { [self] in
            emailAddressTextField.rx.text
               .orEmpty
               .map(emailValidator.validate)
               .subscribe(onNext: { isValid in
                   if isValid{
                       viewModel.login(username: emailAddressTextField.text!, password: passwordTextField.text!)
                   }
               })
               .disposed(by: dis)
        }.disposed(by: dis)
        
        eyeButton.rx.tap.bind { [self] in
            if isSecureText {
                passwordTextField.isSecureTextEntry = false
            } else {
                passwordTextField.isSecureTextEntry = true
            }
            isSecureText.toggle()
        }.disposed(by: dis)
    }
}

