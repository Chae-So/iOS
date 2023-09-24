import RxSwift
import RxCocoa

class LanguageSetViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let languageSelected = BehaviorRelay<String>(value: LocalizationManager.shared.language)
    

    var titleText = BehaviorRelay(value: "")
    var koText = BehaviorRelay(value: "")
    var enText = BehaviorRelay(value: "")
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        languageSelected
            .subscribe(onNext: { [weak self] language in
                if(language == "ko"){
                    self?.localizationManager.language = "ko"
                    self?.localizationManager.rxLanguage.accept("ko")
                }
                else{
                    self?.localizationManager.language = "en"
                    self?.localizationManager.rxLanguage.accept("en")
                }
            })
            .disposed(by: disposeBag)
        
        LocalizationManager.shared.rxLanguage
            .subscribe(onNext: { [weak self] language in
                let newTitle = localizationManager.localizedString(forKey: "언어 설정")
                let koTitle = localizationManager.localizedString(forKey: "한국어")
                let enTitle = localizationManager.localizedString(forKey: "영어")
                self?.titleText.accept(newTitle)
                self?.koText.accept(koTitle)
                self?.enText.accept(enTitle)
            })
            .disposed(by: disposeBag)
        
    }

}
