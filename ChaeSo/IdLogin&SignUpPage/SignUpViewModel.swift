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
    let idText = BehaviorRelay<String>(value: "")
    let checkText = BehaviorRelay<String>(value: "")
    let idTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let pwText = BehaviorRelay<String>(value: "")
    let pwTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let pwConfirmText = BehaviorRelay<String>(value: "")
    let pwConfirmTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    
    let idInput = BehaviorRelay<String>(value: "")
    let pwInput = BehaviorRelay<String>(value: "")
    let pwConfirmInput = BehaviorRelay<String>(value: "")
    
    let loginIdInput = BehaviorRelay<String>(value: "")
    let loginPwInput = BehaviorRelay<String>(value: "")
    
    let idLengthValidText = BehaviorRelay<String>(value: "")
    let idValidText = BehaviorRelay<String>(value: "")
    let idCheckValidText = BehaviorRelay<String>(value: "")
    let pwValidText = BehaviorRelay<String>(value: "")
    let pwLengthValidText = BehaviorRelay<String>(value: "")
    let pwConfirmValidText = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
    var idLengthValid: Observable<Bool> = Observable.just(false)
    var idValid: Observable<Bool> = Observable.just(false)
    var idCheckValid: Observable<Bool> = Observable.just(false)
    var idIsValid: Observable<Bool> = Observable.just(false)
    
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
        
        idLengthValid = idInput
            .map { [weak self] in self?.validator.validateLengthId($0) ?? false}
        
        idValid = idInput
            .map { [weak self] in self?.validator.validateId($0) ?? false}
        
        
        
        idIsValid = Observable.combineLatest(idLengthValid, idValid)
            .map{ $0 && $1 }
        
        pwLengthValid = pwInput
            .map { [weak self] in self?.validator.validateLengthPassword($0) ?? false}
            
        pwValid = pwInput
            .map { [weak self] in self?.validator.validatePassword($0) ?? false}
        
        pwIsValid = Observable.combineLatest(pwLengthValid, pwValid)
            .map{ $0 && $1 }
        
        pwConfirmValid = pwConfirmInput.withLatestFrom(pwInput){ ($0, $1) }
            .map { $0 == $1 && $0 != "" }
        
        allValid = Observable.combineLatest(idIsValid, pwIsValid, pwConfirmValid)
            .map { $0 && $1 && $2 }
            
        
        loginValid = Observable.combineLatest(loginIdInput,loginPwInput)
            .map{ $0 != "" && $1 != "" }
            
    }
    
    private func updateLocalization() {
        loginText.accept(localizationManager.localizedString(forKey: "Login"))
        signUpText.accept(localizationManager.localizedString(forKey: "Sign Up"))
        
        idText.accept(localizationManager.localizedString(forKey: "ID"))
        checkText.accept(localizationManager.localizedString(forKey: "Check"))
        idTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your ID"))
        idLengthValidText.accept(localizationManager.localizedString(forKey: "Please enter 5-12 letters"))
        idValidText.accept(localizationManager.localizedString(forKey: "Use only English and number"))
        idCheckValidText.accept(localizationManager.localizedString(forKey: "Please click Duplicate Check"))
        
        pwText.accept(localizationManager.localizedString(forKey: "Password"))
        pwTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your password"))
        pwLengthValidText.accept(localizationManager.localizedString(forKey: "Please enter 8-15 characters"))
        pwValidText.accept(localizationManager.localizedString(forKey: "Use only English, number and special characters"))
        
        pwConfirmText.accept(localizationManager.localizedString(forKey: "Confirm Password"))
        pwConfirmTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your password again"))
        pwConfirmValidText.accept(localizationManager.localizedString(forKey: "Please enter the same password"))
    }
}
