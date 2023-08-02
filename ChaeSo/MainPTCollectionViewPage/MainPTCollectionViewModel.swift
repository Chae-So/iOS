import Foundation
import PhotosUI
import RxSwift
import RxCocoa

class MainPTCollectionViewModel: NSObject, PHPhotoLibraryChangeObserver{
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // 현재 선택된 사진들의 PHAsset 가져오기
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        fetchOptions.includeAssetSourceTypes = [.typeUserLibrary]
        let assets = PHAsset.fetchAssets(with: fetchOptions)
        
        var updatedAssets: [PHAsset] = []
        assets.enumerateObjects { (asset, _, _) in
            updatedAssets.append(asset)
        }
        
        
        // 선택된 사진들을 selectedAssets Relay에 업데이트하고 저장합니다.
        selectedAssets.accept(updatedAssets)
        saveSelectedAssetsIdentifiers(assets: updatedAssets)
    }
    
    enum PickerResult {
        case single(UIImage)
        case multiple([UIImage])
    }
    
    // 선택한 아이템의 IndexPath와 순서를 저장합니다.
    var selectedItemsOrder: [IndexPath: Int] = [:]
    var selectedIndexArray: [Int] = []
    
    let selectedAssetsKey = "SelectedAssetsKey"
    let selectedAssets = BehaviorRelay<[PHAsset]>(value: [])
    let selectedPhotos = PublishRelay<[UIImage]>()
    let selectedImageRelay = BehaviorRelay<UIImage?>(value: nil)
    
    let nicknameButtonTapped = PublishSubject<Void>()
    let pickerResult = PublishSubject<PickerResult>()
    let alertAction = PublishSubject<String>()
    let pickerConfiguration = PublishSubject<PHPickerConfiguration>()
    let images = BehaviorSubject<[UIImage]>(value: [])
    
    let doneButtonTapped = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    private let writeReviewViewModel: WriteReviewViewModel
    
    init(writeReviewViewModel: WriteReviewViewModel) {
        self.writeReviewViewModel = writeReviewViewModel
        super.init()
        PHPhotoLibrary.shared().register(self)
        doneButtonTapped
            .map { [weak self] in
                return self?.getSelectedPhotos().compactMap { self?.getImage(from: $0) } ?? []
            }
            .do(onNext: { [weak self] images in
                self?.writeReviewViewModel.selectedPhotosRelay.accept(images)
            })
                .bind(to: selectedPhotos)
                .disposed(by: disposeBag)
                }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    func checkPhotoPermissionAndLoad() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .limited:
            self.alertAction.onNext("limited")
            loadSelectedAssets()
        case .authorized:
            self.alertAction.onNext("authorized")
            loadAllPhotos()
        default:
            break
        }
    }
    
    func loadAllPhotos() {
        print("loadAllPhotos")
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let assets = PHAsset.fetchAssets(with: fetchOptions)
        var allAssets: [PHAsset] = []
        assets.enumerateObjects { (asset, _, _) in
            allAssets.append(asset)
        }
        
        // 불러온 사진들을 Relay 혹은 다른 방식으로 뷰 컨트롤러에 전달
        self.selectedAssets.accept(allAssets)
    }
    
    
    func saveSelectedAssetsIdentifiers(assets: [PHAsset]) {
        let identifiers = assets.map { $0.localIdentifier }
        UserDefaults.standard.set(identifiers, forKey: selectedAssetsKey)
    }
    
    func loadSelectedAssets() {
        print("loadSelectedAssets")
        // UserDefaults에서 선택된 사진들의 식별자를 불러옵니다.
        guard let savedIdentifiers = UserDefaults.standard.array(forKey: selectedAssetsKey) as? [String] else { return }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]  // 여기에 정렬 옵션을 추가
        fetchOptions.predicate = NSPredicate(format: "localIdentifier IN %@", savedIdentifiers)
        
        let assets = PHAsset.fetchAssets(with: fetchOptions)
        var loadedAssets: [PHAsset] = []
        assets.enumerateObjects { (asset, _, _) in
            loadedAssets.append(asset)
        }
        
        // 가져온 사진들을 selectedAssets Relay에 저장합니다.
        selectedAssets.accept(loadedAssets)
    }
    
    // 아이템을 선택하는 메서드
    func selectItem(at indexPath: IndexPath) {
        if let order = selectedItemsOrder[indexPath] {
            selectedItemsOrder.removeValue(forKey: indexPath)
            selectedIndexArray.removeAll(where: { $0 == indexPath.item })
            
            for (index, value) in selectedIndexArray.enumerated() {
                selectedItemsOrder[IndexPath(item: value, section: 0)] = index + 1
            }
        } else {
            let newOrder = (selectedItemsOrder.values.max() ?? 0) + 1
            selectedItemsOrder[indexPath] = newOrder
            selectedIndexArray.append(indexPath.item)
        }
    }

    
    
    // 선택한 아이템의 순서를 가져오는 메서드
    func getOrder(of indexPath: IndexPath) -> Int? {
        return selectedItemsOrder[indexPath]
    }
    
    func getSelectedPhotos() -> [PHAsset] {
        return selectedIndexArray.map { selectedAssets.value[$0] }
    }
    
    // 선택한 아이템들의 PHAsset을 가져오는 메서드
    func getSelectedAssets() -> [PHAsset] {
        let orderedItems = selectedItemsOrder.sorted(by: { $0.value < $1.value })
        return orderedItems.compactMap { index, _ in
            return selectedAssets.value[index.item]
        }
    }
    
    
    func getImage(from asset: PHAsset) -> UIImage? {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image: UIImage?
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
            image = result
        })
        return image
    }
    
}
