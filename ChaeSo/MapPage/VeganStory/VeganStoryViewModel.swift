import RxSwift
import RxCocoa

class VeganStoryViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let veganStoryText = BehaviorRelay<String>(value: "")
    
    var aa: String{
        return localizationManager.localizedString(forKey: "Vegan Story")
    }

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        print("비건 스토리리리리릴",localizationManager.language)
    }
    
    private func updateLocalization() {
        veganStoryText.accept(localizationManager.localizedString(forKey: "Vegan Story"))
    }

}
