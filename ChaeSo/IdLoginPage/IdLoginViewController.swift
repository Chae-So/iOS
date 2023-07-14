import UIKit
import RxSwift
import RxCocoa

class IdLoginViewModel{
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    let validator:Validator = Validator()
    
    //MARK: - Input
    let loginText = BehaviorRelay<String>(value: "")
    let idText = BehaviorRelay<String>(value: "")
    let idTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let pwText = BehaviorRelay<String>(value: "")
    let pwTextFieldPlaceholder = BehaviorRelay<String>(value: "")

    
    let idInput = BehaviorRelay<String>(value: "")
    let pwInput = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
    
    
    // MARK: - Initializer
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        
        updateLocalization()
        
            

            
    }
    
    private func updateLocalization() {
        loginText.accept(localizationManager.localizedString(forKey: "Sign Up"))
        
        idText.accept(localizationManager.localizedString(forKey: "ID"))
        idTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your ID"))
       
        pwText.accept(localizationManager.localizedString(forKey: "Password"))
        pwTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your password"))
    }
}
