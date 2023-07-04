import UIKit
import RxCocoa
import RxSwift

class LoginViewModel{
    let disposeBag = DisposeBag()
    
    
    var localizationManager: LocalizationManager
    
    // Input
    let isFirstVisitLabelText = BehaviorRelay<String>(value: "")
    let signupButtonText = BehaviorRelay<String>(value: "")
    
    // Output
    let titleText = BehaviorRelay<String>(value: "")
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        print(localizationManager.language,345)
        self.updateLocalization()

        
    }
    
    private func updateLocalization() {
        isFirstVisitLabelText.accept(localizationManager.localizedString(forKey: "Is_this_your_first_visit_to_CHAESO?"))
        signupButtonText.accept(localizationManager.localizedString(forKey: "Sign_Up"))
    }
}
