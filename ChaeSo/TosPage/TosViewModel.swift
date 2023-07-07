import UIKit
import RxCocoa
import RxSwift

class TosViewModel{
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
    }
}
