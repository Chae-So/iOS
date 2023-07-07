import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    let id: Int
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(id: Int, title: String?, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
    }
}

class MapModel {
    
    // MARK: - Methods
    
    func getAnnotations(completionHandler: @escaping (Result<[MapAnnotation], Error>) -> Void) {
        
        // Simulate a network request to get annotations from a server
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let annotations = [
                MapAnnotation(id: 1, title: "서울시청", coordinate: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)),
                MapAnnotation(id: 2, title: "경복궁", coordinate: CLLocationCoordinate2D(latitude: 37.5788, longitude: 126.9770)),
                MapAnnotation(id: 3, title: "남산타워", coordinate: CLLocationCoordinate2D(latitude: 37.5512, longitude: 126.9882))
            ]
            
            completionHandler(.success(annotations))
            
        }
        
    }
}
