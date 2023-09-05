import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

class MapViewController: UIViewController {
    let disposeBag = DisposeBag()
    var mapViewModel: MapViewModel
    
    let locationManager = CLLocationManager()
    let mapView = MTMapView()
    let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
    })
    let currentLocationButton = UIButton()
    let detailListViewModel = DetailListViewModel(localizationManager: LocalizationManager.shared)
    lazy var detailListView: DetailListView = {
        return DetailListView(detailListViewModel: self.detailListViewModel)
    }()
    let detailListBackgroundView = DetailListBackgroundView()
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let geocoder = CLGeocoder()
//        let address = "부산광역시 사하구 낙동남로 1240"
//
//        geocoder.geocodeAddressString(address) { (placemarks, error) in
//            if let error = error {
//                print(error)
//            } else if let placemarks = placemarks, let placemark = placemarks.first {
//                if let location = placemark.location {
//                    let latitude = location.coordinate.latitude
//                    let longitude = location.coordinate.longitude
//                    print("Latitude: \(latitude), Longitude: \(longitude)")
//                }
//            }
//        }
        
        //mapView.delegate = self
        locationManager.delegate = self
        
        bind()
        layout()
        attribute()
        
        setupPanGesture()
        
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer()
        detailListView.addGestureRecognizer(panGesture)

        panGesture.rx.event.asDriver { _ in .never() }
            .drive(onNext: { [weak self] sender in
                guard let view = self?.view,
                      let senderView = sender.view else {
                    return
                }

                // view에서 움직인 정보
                let transition = sender.translation(in: view)
                let proposedY = senderView.center.y + transition.y
                //print(proposedY)
                // Apply constraints
                if proposedY >= 482 && proposedY <= 1061 {
                    senderView.center = CGPoint(x: senderView.center.x, y: proposedY)
                }

                sender.setTranslation(.zero, in: view) // 움직인 값을 0으로 초기화
            })
        .disposed(by: disposeBag)

        }
    
    private func bind() {
        
        categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

        mapViewModel.categoryItems
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        mapViewModel.categorySelectedIndexPath
                .bind(to: categoryCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        categoryCollectionView.rx.itemSelected
            .bind(to: mapViewModel.categorySelectedIndexPath)
            .disposed(by: disposeBag)
        
        categoryCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if indexPath.item == 2 {
                    self.mapViewModel.fetchData()
                    self.detailListView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        mapViewModel.places
            //.skip(1)
            .subscribe(onNext: { [weak self] places in
                guard let self = self else { return }
                print("플레이스데이탕아아아ㅏ아아ㅏㅏ아아아아아")
                if !places.isEmpty {
                    
                    self.detailListViewModel.placeList.accept(places)
                    self.detailListViewModel.categoryType.accept("c")
                    
                    
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func attribute() {
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        mapView.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
        
        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        currentLocationButton.backgroundColor = .white
        currentLocationButton.sizeToFit()
        currentLocationButton.layer.cornerRadius = currentLocationButton.frame.size.height / 2
        
        categoryCollectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        categoryCollectionView.backgroundColor = .clear
        
        detailListView.isHidden = true
        
    }
    
    private func layout() {
        [mapView,categoryCollectionView, currentLocationButton, detailListView]
            .forEach { view.addSubview($0) }
        
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()//.equalTo(view.safeAreaLayoutGuide)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(38*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16*Constants.standardHeight)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.width.equalTo(48*Constants.standardHeight)
            make.height.equalTo(48*Constants.standardHeight)
            make.centerY.equalTo(categoryCollectionView)
            make.trailing.equalToSuperview().offset(-16*Constants.standardHeight)
        }
        
        detailListView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(view.snp.centerY)
        }
    }
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = mapViewModel.categoryItems.value
                
        let text = items[indexPath.item]
        let font = UIFont(name: "Pretendard-Medium", size: 16)
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let width = textSize.width + 16 * 2 * Constants.standardWidth
        let height = textSize.height + 8 * 2 * Constants.standardHeight
        
        return CGSize(width: width, height: height-2)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse,
             .notDetermined:
            return
        default:
            //viewModel.mapViewError.accept(MTMapViewError.locationAuthorizaationDenied.errorDescription)
            return
        }
    }
}
//
//extension MapViewController: MTMapViewDelegate {
//    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
//        #if DEBUG
//        viewModel.currentLocation.accept(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.394225, longitude: 127.110341)))
//        #else
//         viewModel.currentLocation.accept(location)
//        #endif
//    }
//
//    func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) {
//        viewModel.mapCenterPoint.accept(mapCenterPoint)
//    }
//
//    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
//        viewModel.selectPOIItem.accept(poiItem)
//        //print("poiItemㅓㅏㅇ너라ㅓㅇ뉴라ㅓㅇ나ㅓ륭너류",poiItem)
//        return false
//    }
//
//    func mapView(_ mapView: MTMapView!, failedUpdatingCurrentLocationWithError error: Error!) {
//        viewModel.mapViewError.accept(error.localizedDescription)
//    }
//}
//
//extension Reactive where Base: MTMapView {
//    var setMapCenterPoint: Binder<MTMapPoint> {
//        return Binder(base) { base, point in
//            base.setMapCenter(point, animated: true)
//        }
//    }
//}
//
//extension Reactive where Base: MapViewController {
//    var presentAlert: Binder<String> {
//        return Binder(base) { base, message in
//            let alertController = UIAlertController(title: "문제가 발생했어요", message: message, preferredStyle: .alert)
//
//            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
//
//            alertController.addAction(action)
//
//            base.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    var showSelectedLocation: Binder<Int> {
//        return Binder(base) { base, row in
//            let indexPath  = IndexPath(row: row, section: 0)
//            base.detailList.selectRow(at: indexPath, animated: true, scrollPosition: .top)
//        }
//    }
//
//    var addPOIItems: Binder<[MTMapPoint]> {
//        return Binder(base) { base, points in
//            let items = points
//                .enumerated()
//                .map { offset, point -> MTMapPOIItem in
//                    let mapPOIItem = MTMapPOIItem()
//
//                    mapPOIItem.mapPoint = point
//                    mapPOIItem.markerType = .redPin
//                    mapPOIItem.showAnimationType = .springFromGround
//                    mapPOIItem.tag = offset
//
//                    return mapPOIItem
//                }
//
//            base.mapView.removeAllPOIItems()
//            base.mapView.addPOIItems(items)
//        }
//    }
//}
