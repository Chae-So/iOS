import UIKit
import RxCocoa
import RxSwift

class NicknameViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    // Input
    let NkText = BehaviorRelay<String>(value: "")
    let NkTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let NkValidFirstText = BehaviorRelay<String>(value: "")
    let NkValidSecondText = BehaviorRelay<String>(value: "")
    
    let NkInput = BehaviorRelay<String>(value: "")
    // Output
    var nkLengthValid = Observable<Bool>.just(false)
    var nkCheckValid = Observable<Bool>.just(true)
    var allValid = Observable<Bool>.just(false)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        nkLengthValid = NkInput.map{ $0.count >= 2 && $0.count <= 10}
        
        allValid = Observable.combineLatest(nkLengthValid,nkCheckValid).map{ $0 && $1 }
    }
    
    private func updateLocalization() {
        NkText.accept(localizationManager.localizedString(forKey: "Nickname"))
        NkTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your nickname"))
        NkValidFirstText.accept(localizationManager.localizedString(forKey: "Please enter 2~10 letters"))
        NkValidSecondText.accept(localizationManager.localizedString(forKey: "Please click Duplicate Check"))
        
    }
}
