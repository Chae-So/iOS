import UIKit
import RxSwift
import RxCocoa
import SnapKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: MapViewModel
    
    // MARK: - UI Elements
    
    let mapView = MKMapView()
    
    // MARK: - Initializers
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        // Set up the map view
        //        view.addSubview(mapView)
        //        mapView.snp.makeConstraints { make in
        //            make.edges.equalToSuperview()
        //        }
        //
        //        // Bind the annotations to the map view
        //        viewModel.annotations
        //            .drive(mapView.rx.annotations)
        //            .disposed(by: disposeBag)
        //
        //        // Bind the region to the map view
        //        viewModel.region
        //            .drive(mapView.rx.region)
        //            .disposed(by: disposeBag)
        //
        //        // Bind the selected annotation to the view model
        //        mapView.rx.didSelectAnnotationView
        //            .map { $0.annotation as? MapAnnotation }
        //            .bind(to: viewModel.selectedAnnotation)
        //            .disposed(by: disposeBag)
        //
        //        // Navigate to the annotation detail view controller when selected
        //        viewModel.selectedAnnotation
        //            .compactMap { $0 }
        //            .subscribe(onNext: { [weak self] annotation in
        //                guard let self = self else { return }
        //                let annotationDetailVC = AnnotationDetailViewController(viewModel: AnnotationDetailViewModel(model: AnnotationDetailModel(annotation: annotation)))
        //                self.navigationController?.pushViewController(annotationDetailVC, animated: true)
        //            })
        //            .disposed(by: disposeBag)
        //
        //        // Fetch the annotations from the view model
        //        viewModel.fetchAnnotations()
        //    }
    }
}
