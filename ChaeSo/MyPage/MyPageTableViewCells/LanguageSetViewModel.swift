import RxSwift
import RxCocoa

class LanguageSetViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let languageSelected = BehaviorRelay<String>(value: LocalizationManager.shared.language)
    
//    var titleText: String{
//        return localizationManager.localizedString(forKey: "언어 설정")
//    }
    var titleText = BehaviorRelay(value: "")
    
    
    var koText: String{
        return localizationManager.localizedString(forKey: "한국어")
    }
    var enText: String{
        return localizationManager.localizedString(forKey: "영어")
    }
    
    
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
                self?.titleText.accept(newTitle)
            })
            .disposed(by: disposeBag)
        
    }

}
