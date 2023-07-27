import RxSwift
import RxCocoa

class VeganStoryViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let veganStoryText = BehaviorRelay<String>(value: "")

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()

    }
    
    private func updateLocalization() {
        veganStoryText.accept(localizationManager.localizedString(forKey: "Vegan Story"))
    }

}
