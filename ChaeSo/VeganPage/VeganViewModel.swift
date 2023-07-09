import UIKit
import RxCocoa
import RxSwift

class VeganViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    // Input
    let loginText = BehaviorRelay<String>(value: "")
    let appleLoginButtonText = BehaviorRelay<String>(value: "")
    let googleLoginButtonText = BehaviorRelay<String>(value: "")
    let kakaoLoginButtonText = BehaviorRelay<String>(value: "")
    let tomatoLoginButtonText = BehaviorRelay<String>(value: "")
    let isFirstVisitLabelText = BehaviorRelay<String>(value: "")
    let signupButtonText = BehaviorRelay<String>(value: "")
    
    // Output
    let titleText = BehaviorRelay<String>(value: "")
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()

        
    }
    
    private func updateLocalization() {
        loginText.accept(localizationManager.localizedString(forKey: "Login"))
        appleLoginButtonText.accept(localizationManager.localizedString(forKey: "Sign in with Apple"))
        googleLoginButtonText.accept(localizationManager.localizedString(forKey: "Sign in with Google"))
        kakaoLoginButtonText.accept(localizationManager.localizedString(forKey: "Sign in with Kakao"))
        tomatoLoginButtonText.accept(localizationManager.localizedString(forKey: "Login in with ID"))

        isFirstVisitLabelText.accept(localizationManager.localizedString(forKey: "Is this your first visit to CHAESO?"))
        signupButtonText.accept(localizationManager.localizedString(forKey: "Sign Up"))
    }
}

