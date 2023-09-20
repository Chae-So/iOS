import UIKit
import RxCocoa
import RxSwift

struct Nickname{
    let name: String
}

struct VeganStage{
    let image: UIImage?
    let text: String
}

class VeganViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    var titleText: String{
        return localizationManager.localizedString(forKey: "Hello",arguments: "씩씩한 시금치")
    }
    
    var veganText: String{
        return localizationManager.localizedString(forKey: "Vegan")
    }
    var lactoText: String{
        return localizationManager.localizedString(forKey: "Lacto")
    }
    var ovoText: String{
        return localizationManager.localizedString(forKey: "Ovo")
    }
    var pescoText: String{
        return localizationManager.localizedString(forKey: "Pesco")
    }
    var polloText: String{
        return localizationManager.localizedString(forKey: "Pollo")
    }
    var flexitarianText: String{
        return localizationManager.localizedString(forKey: "Flexitarian")
    }
    let startText = BehaviorRelay<String>(value: "")

    
    // Output
    let itemSelected = PublishRelay<IndexPath?>()
    let startButtonEnabled = PublishRelay<Bool>()
    var cellData = Driver<[VeganStage]>.just([])
    var currentCellData: [VeganStage] = []

    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.startText.accept(localizationManager.localizedString(forKey: "Start"))
        
        cellData = Driver.just(
            [VeganStage(image: UIImage(named: "firstVegan"), text: veganText),
             VeganStage(image: UIImage(named: "secondVegan"), text: lactoText),
             VeganStage(image: UIImage(named: "thirdVegan"), text: ovoText),
             VeganStage(image: UIImage(named: "fourthVegan"), text: pescoText),
             VeganStage(image: UIImage(named: "fifthVegan"), text: polloText),
             VeganStage(image: UIImage(named: "sixthVegan"), text: flexitarianText)
             
            ])
        
        cellData
            .drive(onNext: { [weak self] data in
                self?.currentCellData = data
            })
            .disposed(by: disposeBag)

        
        itemSelected
            .map{_ in true}
            .bind(to: startButtonEnabled)
            .disposed(by: disposeBag)
        
        
    }
    
}


