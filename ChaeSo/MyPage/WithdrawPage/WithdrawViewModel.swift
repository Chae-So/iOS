import RxSwift
import RxCocoa

class WithdrawViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let withdrawText = BehaviorRelay(value: "")
    let firstText = BehaviorRelay(value: "")
    let secondText = BehaviorRelay(value: "")
    let thirdText = BehaviorRelay(value: "")

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        withdrawText.accept(localizationManager.localizedString(forKey: "withdraw"))
        firstText.accept(localizationManager.localizedString(forKey: "Are you sure you want to delete the account?"))
        secondText.accept(localizationManager.localizedString(forKey: "If you delete your account,"))
        thirdText.accept(localizationManager.localizedString(forKey: "your profile and all your contents is deleted permanently immediately and cannot be recovered again."))
    }

}
