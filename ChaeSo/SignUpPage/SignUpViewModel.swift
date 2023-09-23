import UIKit
import RxSwift
import RxCocoa

class SignUpViewModel{
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    let validator:Validator = Validator()
    
    //MARK: - Input
    let loginText = BehaviorRelay<String>(value: "")
    let signUpText = BehaviorRelay<String>(value: "")
    let emailText = BehaviorRelay<String>(value: "")
    let checkText = BehaviorRelay<String>(value: "")
    let emailTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let pwText = BehaviorRelay<String>(value: "")
    let pwTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let pwConfirmText = BehaviorRelay<String>(value: "")
    let pwConfirmTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let nextText = BehaviorRelay<String>(value: "")
    
    let emailInput = BehaviorRelay<String>(value: "")
    let pwInput = BehaviorRelay<String>(value: "")
    let pwConfirmInput = BehaviorRelay<String>(value: "")

    let emailFormatValidText = BehaviorRelay<String>(value: "")
    let emailCheckValidText = BehaviorRelay<String>(value: "")
    let pwValidText = BehaviorRelay<String>(value: "")
    let pwLengthValidText = BehaviorRelay<String>(value: "")
    let pwConfirmValidText = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
    var emailFormatValid: Observable<Bool> = Observable.just(false)
    var emailCheckValid: Observable<Bool> = Observable.just(false)
    var emailIsValid: Observable<Bool> = Observable.just(false)
    
    var pwValid: Observable<Bool> = Observable.just(false)
    var pwLengthValid: Observable<Bool> = Observable.just(false)
    var pwIsValid: Observable<Bool> = Observable.just(false)
    
    var pwConfirmValid: Observable<Bool> = Observable.just(false)
    var allValid: Observable<Bool> = Observable.just(false)
    
    var loginValid: Observable<Bool> = Observable.just(false)
    
    // MARK: - Initializer
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        
        updateLocalization()
        
        emailFormatValid = emailInput
            .map { [weak self] in self?.validator.validateEmail($0) ?? false}
        
        emailIsValid = emailFormatValid
        
//        emailIsValid = Observable.combineLatest(emailFormatValid)
//            .map{ $0 }
        
        pwLengthValid = pwInput
            .map { [weak self] in self?.validator.validateLengthPassword($0) ?? false}
            
        pwValid = pwInput
            .map { [weak self] in self?.validator.validatePassword($0) ?? false}
        
        pwIsValid = Observable.combineLatest(pwLengthValid, pwValid)
            .map{ $0 && $1 }
        
        pwConfirmValid = pwConfirmInput.withLatestFrom(pwInput){ ($0, $1) }
            .map { $0 == $1 && $0 != "" }
        
        allValid = Observable.combineLatest(emailIsValid, pwIsValid, pwConfirmValid)
            .map { $0 && $1 && $2 }
            
            
    }
    
    private func updateLocalization() {
        loginText.accept(localizationManager.localizedString(forKey: "Login"))
        signUpText.accept(localizationManager.localizedString(forKey: "Sign Up"))
        
        emailText.accept(localizationManager.localizedString(forKey: "Email"))
        checkText.accept(localizationManager.localizedString(forKey: "Check"))
        emailTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your email"))
        emailFormatValidText.accept(localizationManager.localizedString(forKey: "Please enter in email format"))
        emailCheckValidText.accept(localizationManager.localizedString(forKey: "Please click Duplicate Check"))
        
        pwText.accept(localizationManager.localizedString(forKey: "Password"))
        pwTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your password"))
        pwLengthValidText.accept(localizationManager.localizedString(forKey: "Please enter 8~15 characters"))
        pwValidText.accept(localizationManager.localizedString(forKey: "Use only English, number and special characters"))
        
        pwConfirmText.accept(localizationManager.localizedString(forKey: "Confirm Password"))
        pwConfirmTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your password again"))
        pwConfirmValidText.accept(localizationManager.localizedString(forKey: "Please enter the same password"))
        nextText.accept(localizationManager.localizedString(forKey: "Next"))
    }
}
