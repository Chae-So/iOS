import RxSwift
import RxCocoa

enum PlaceDisplayType {
    case facilities(Bool, Bool)
    case tel(String,UIImage)
    case addr(String,UIImage)
    case content(String)
}

class TourViewModel{
    var localizationManager: LocalizationManager
    
    let infoText = BehaviorRelay<String>(value: "")
    let parkingText = BehaviorRelay<String>(value: "")
    let toiletText = BehaviorRelay<String>(value: "")
    
    let placeMain: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let placeData: BehaviorRelay<[PlaceDisplayType]> = BehaviorRelay(value: [])

    init(localizationManager: LocalizationManager, place: Place) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        let data: [PlaceDisplayType] = [
            .facilities(place.toilet, place.parking),
            .addr(place.addr,UIImage(named: "loca")!),
            .tel(place.tel,UIImage(named: "phone")!),
            .content(place.content)
        ]
        placeData.accept(data)
        placeMain.accept([place.title,place.mainimage])
        
    }
    
    private func updateLocalization() {
        infoText.accept(localizationManager.localizedString(forKey: "Info"))
        parkingText.accept(localizationManager.localizedString(forKey: "parking"))
        toiletText.accept(localizationManager.localizedString(forKey: "toilet"))
    }
    
}
