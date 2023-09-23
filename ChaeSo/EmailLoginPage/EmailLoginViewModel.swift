import UIKit
import RxSwift
import RxCocoa

class EmailLoginViewModel{
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    let validator:Validator = Validator()
    
    let loginText = BehaviorRelay<String>(value: "")
    let emailText = BehaviorRelay<String>(value: "")
    let emailTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let pwText = BehaviorRelay<String>(value: "")
    let pwTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    
    let emailInput = BehaviorRelay<String>(value: "")
    let pwInput = BehaviorRelay<String>(value: "")
    var enableLoginButton = Observable<Bool>.just(false)
    
    let loginButtonTapped = PublishRelay<Void>()

    

    
    // MARK: - Initializer
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        
        updateLocalization()
        
        let emailValid = emailInput
            .map { [weak self] in self?.validator.validateEmail($0) ?? false }

        let passwordValid = pwInput
            .map { $0.count > 0 }
        
        enableLoginButton = Observable.combineLatest(emailValid, passwordValid) { emailIsValid, passwordIsValid in
            return emailIsValid && passwordIsValid
        }
            
    }
    
    private func updateLocalization() {
        loginText.accept(localizationManager.localizedString(forKey: "Login"))
        
        emailText.accept(localizationManager.localizedString(forKey: "Email"))
        emailTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your email"))

        pwText.accept(localizationManager.localizedString(forKey: "Password"))
        pwTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your password"))

    }
}
