import RxSwift
import RxCocoa
import Alamofire

class MapViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let categoryItems = BehaviorRelay<[String]>(value: [])
    let categorySelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    
    let restaurantText = BehaviorRelay<String>(value: "")
    let cafeText = BehaviorRelay<String>(value: "")
    let tourText = BehaviorRelay<String>(value: "")
    
    let places: BehaviorRelay<[Place]> = BehaviorRelay(value: [])
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(restaurantText, cafeText, tourText)
            .subscribe(onNext: { [weak self] a, b, c in
                self?.categoryItems.accept([a, b, c])
            })
            .disposed(by: disposeBag)
        
    }
    
    func fetchData() {
        let baseURL = "https://apis.data.go.kr/B551011/GreenTourService1/areaBasedList1"
        let parameters: [String: String] = [
            "MobileOS": "IOS",
            "MobileApp": "Chaeso",
            "areaCode": "6",
            "_type": "json",
            "serviceKey": "baUzHe88eAYK43DCQFlep1DxNZUQyLnobW3qM0mq9o1IL2h5CAZTaQsiF+hyXr8NJVJvYs5lQnCh+CQft6zuZQ=="
        ]
        
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default)
        .responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let response):
                var placesFromServer: [Place] = []
                
                let places = response.response.body.items.item
                for place in places {
                    placesFromServer.append(place)
                    //print(place)
                }
                print(response)
                // Update the places BehaviorRelay
                self.places.accept(placesFromServer)
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    private func updateLocalization() {

        restaurantText.accept(localizationManager.localizedString(forKey: "Restaurant"))
        cafeText.accept(localizationManager.localizedString(forKey: "Cafe"))
        tourText.accept(localizationManager.localizedString(forKey: "tourist attraction"))
        
    }
    
}
