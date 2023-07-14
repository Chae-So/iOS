import UIKit
import RxCocoa
import RxSwift

class VeganViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    // Input
    let veganText = BehaviorRelay<String>(value: "")
    let LactoText = BehaviorRelay<String>(value: "")
    let OvoText = BehaviorRelay<String>(value: "")
    let PolloText = BehaviorRelay<String>(value: "")
    let PescoText = BehaviorRelay<String>(value: "")
    let isFirstVisitLabelText = BehaviorRelay<String>(value: "")
    let signupButtonText = BehaviorRelay<String>(value: "")
    
    // Output
    let titleText = BehaviorRelay<String>(value: "")
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        
        
    }
    
    private func updateLocalization() {
        veganText.accept(localizationManager.localizedString(forKey: "Vegan"))
        LactoText.accept(localizationManager.localizedString(forKey: "Lacto"))
        OvoText.accept(localizationManager.localizedString(forKey: "Ovo"))
        PolloText.accept(localizationManager.localizedString(forKey: "Pollo"))
        PescoText.accept(localizationManager.localizedString(forKey: "Pesco"))

    }
}


