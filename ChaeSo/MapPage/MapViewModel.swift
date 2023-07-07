import Foundation
import RxSwift
import RxCocoa
import MapKit

class MapViewModel {
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let model: MapModel
    
    // MARK: - Inputs
    
    let selectedAnnotation = BehaviorRelay<MapAnnotation?>(value: nil)
    
    // MARK: - Outputs
    
    let annotations = BehaviorRelay<[MapAnnotation]>(value: [])
    let region = BehaviorRelay<MKCoordinateRegion>(value: MKCoordinateRegion())
    
    // MARK: - Initializers
    
    init(model: MapModel) {
        self.model = model
        
        // Reset the selected annotation when annotations change
        annotations.asObservable()
            .map { _ in nil }
            .bind(to: selectedAnnotation)
            .disposed(by: disposeBag)
        
        // Set the initial region to Seoul
        region.accept(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        
        // Fetch the annotations from the model when initialized
        fetchAnnotations()
    }
    
    // MARK: - Methods
    
    func fetchAnnotations() {
        model.getAnnotations { [weak self] result in
            switch result {
            case .success(let annotations):
                self?.annotations.accept(annotations)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
