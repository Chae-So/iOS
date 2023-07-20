import Foundation
import PhotosUI
import RxSwift
import RxCocoa

class PTCollectionViewModel: PHPickerViewControllerDelegate{
    
    enum PickerResult {
        case single(UIImage)
        case multiple([UIImage])
    }
    
    enum AlertAction {
        case showPickerAlert
        case showCollectionAlert
    }
    
    let selectedAssetsKey = "SelectedAssetsKey"
    let selectedAssets = BehaviorRelay<[PHAsset]>(value: [])
    
    let selectedImageRelay = BehaviorRelay<UIImage?>(value: nil)
    
    let nicknameButtonTapped = PublishSubject<Void>()
    let pickerResult = PublishSubject<PickerResult>()
    let alertAction = PublishSubject<AlertAction>()
    let pickerConfiguration = PublishSubject<PHPickerConfiguration>()
    let images = BehaviorSubject<[UIImage]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init() {
        
        selectedImageRelay
            .subscribe(onNext: { aa in
                print("피티뷰모델",aa)
            })
            .disposed(by: disposeBag)
        
        nicknameButtonTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                print(11)
                switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
                case .limited:
                    // Show alert to choose more photos or keep current selection
                    print("limited")
                    self.alertAction.onNext(.showCollectionAlert)
                case .authorized:
                    // Show PHPicker with no limit
                    print("authorized")
                    var configuration = PHPickerConfiguration()
                    configuration.filter = .images
                    configuration.selectionLimit = 1 // no limit
                    configuration.preferredAssetRepresentationMode = .current
                    self.pickerConfiguration.onNext(configuration)
                default:
                   break
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    func saveSelectedAssetsIdentifiers(assets: [PHAsset]) {
        let identifiers = assets.map { $0.localIdentifier }
        UserDefaults.standard.set(identifiers, forKey: selectedAssetsKey)
    }
    
    func loadSelectedAssets() {
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
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        print("zxc")
        if results.count == 1 {
            // Single image selected
            print("Single image selected")
            results.first?.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self = self else { return }
                if let image = image as? UIImage {
                    self.pickerResult.onNext(.single(image))
                }
            }
        } else {
            // Multiple images selected
            print("Multiple images selected")
            var images: [UIImage] = []
            let dispatchGroup = DispatchGroup()
            
            for result in results {
                dispatchGroup.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        images.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.pickerResult.onNext(.multiple(images))
                do {
                    let oldImages = try self.images.value()
                    self.images.onNext(oldImages + images)
                } catch {
                    print(error)
                }
            }
        }
    }

}

    
