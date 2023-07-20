import UIKit
import PhotosUI
import RxCocoa
import RxSwift

struct Input {
    let buttonTapped = PublishSubject<Void>()
    let pickedImages = PublishSubject<[PHPickerResult]>()
    let selectedImage = PublishSubject<IndexPath>()
    let morePhotosTapped = PublishSubject<Void>()
    let keepCurrentTapped = PublishSubject<Void>()
}

struct Output {
    let image = BehaviorSubject<UIImage?>(value: nil)
    let images = BehaviorSubject<[UIImage]>(value: [])
    let showImagePicker = PublishSubject<Void>()
    let showAlert = PublishSubject<Void>()
    let showLimitedAlert = PublishSubject<Void>()
    let showCollectionView = PublishSubject<Void>()
}

class NicknameViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    var currentView: UIView?
    
    let input = Input()
    let output = Output()
    
    // Input
    let NkText = BehaviorRelay<String>(value: "")
    let checkText = BehaviorRelay<String>(value: "")
    let NkTextFieldPlaceholder = BehaviorRelay<String>(value: "")
    let NkValidFirstText = BehaviorRelay<String>(value: "")
    let NkValidSecondText = BehaviorRelay<String>(value: "")
    
    let NkInput = BehaviorRelay<String>(value: "")
    let nicknameButtonTapped = PublishSubject<Void>()
    
    // Output
    var nkLengthValid = Observable<Bool>.just(false)
    var nkCheckValid = Observable<Bool>.just(true)
    var allValid = Observable<Bool>.just(false)
    
    //var showImagePicker = Observable<Void>.just(())
    //let selectedImage = BehaviorRelay<UIImage?>(value: nil)
    
    var buttonImage = BehaviorRelay<UIImage?>(value: nil)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        nicknameButtonTapped
            .subscribe(onNext: { [self] in
                buttonImage.accept(UIImage(systemName: "bolt.circle.fill"))
            })
            .disposed(by: disposeBag)
        
        //buttonImage = Observable<UIImage?>.just(UIImage(named: "tomato"))

        
        nkLengthValid = NkInput.map{ $0.count >= 2 && $0.count <= 10}
        
        allValid = Observable.combineLatest(nkLengthValid,nkCheckValid).map{ $0 && $1 }
        
//        nicknameButtonTapped
//            .subscribe(onNext: { [self] in
//                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
//                    switch status {
//                    case .notDetermined:
//                        // The user hasn't determined this app's access.
//                        break
//                    case .restricted:
//                        // The system restricted this app's access.
//                        break
//                    case .denied:
//                        // The user explicitly denied this app's access.
//                        break
//                    case .authorized:
//                        // The user authorized this app to access Photos data.
//                        break
//                    case .limited:
//                        // The user authorized this app for limited Photos access.
//
//                        print(123)
//                        DispatchQueue.main.async {
//                            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: getCurrentViewController(from: currentView!)!)
//
//                        }
//
//                        break
//                    @unknown default:
//                        fatalError()
//                    }
//                }
//            })
        
        
//        let aa = input.pickedImages
//            .flatMap { results in
//                // convert the results to an observable of images
//                return Observable.from(results)
//            }
//            .flatMap { result in
//                // load the image from the result item provider and return an observable of image
//                return Observable.create { observer in
//                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
//                        if let image = image as? UIImage {
//                            observer.onNext(image)
//                        }
//                        observer.onCompleted()
//                    }
//                    return Disposables.create()
//                }
//            }
//
//            aa
//            .subscribe(onNext: { [weak self] image in
//                // get the current value of the output images
//                if var images = try? self?.output.images.value() {
//                    // append the image to the images array
//                    images.append(image)
//                    // set the output images to the new array
//                    self?.output.images.onNext(images)
//                }
//                // set the output image to the first image in the array if any
//                if self?.output.image.value == nil {
//                    self?.output.image.onNext(image)
//                }
//            })
//            .disposed(by: disposeBag)
//
//
//        nicknameButtonTapped
//            .flatMapLatest { [weak self] in
//                // check the photo authorization status and return an observable of the status
//                return self?.checkPhotoAuthorizationStatus() ?? Observable.empty()
//            }
//            .subscribe(onNext: { [weak self] status in
//                switch status {
//                case .authorized:
//                    // trigger the output showImagePicker event
//                    self?.output.showImagePicker.onNext(())
//                case .limited:
//                    // trigger the output showLimitedAlert event
//                    self?.output.showLimitedAlert.onNext(())
//                case .notDetermined:
//                    // request access
//                    PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
//                        if status == .authorized {
//                            // trigger the output showImagePicker event on the main thread
//                            DispatchQueue.main.async {
//                                self?.output.showImagePicker.onNext(())
//                            }
//                        } else {
//                            // trigger the output showAlert event on the main thread
//                            DispatchQueue.main.async {
//                                self?.output.showAlert.onNext(())
//                            }
//                        }
//                    }
//                default:
//                    break
//                }
//            })
//            .disposed(by: disposeBag)
//
//
//
//
//        //        // subscribe to the input pickedImages event
//        //        input.pickedImages
//        //            .flatMap { results in
//        //                // convert the results to an observable of images
//        //                return Observable.from(results)
//        //            }
//        //            .flatMap { result in
//        //                // load the image from the result item provider and return an observable of image
//        //                return Observable.create { observer in
//        //                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
//        //                        if let image = image as? UIImage {
//        //                            observer.onNext(image)
//        //                        }
//        //                        observer.onCompleted()
//        //                    }
//        //                    return Disposables.create()
//        //                }
//        //            }
//        //            .toArray()
//        //            .subscribe(onNext: { [weak self] images in
//        //                // set the output image to the first image in the array if any
//        //                self?.output.image.onNext(images.first)
//        //                // set the output images to the array of images
//        //                self?.output.images.onNext(images)
//        //            })
//        //            .disposed(by: disposeBag)
//
//        // subscribe to the input selectedImage event
//        input.selectedImage
//            .withLatestFrom(output.images) { ($0, $1) }
//            .map { index, images in
//                // get the image at the selected index from the array of images
//                return images[index.row]
//            }
//            .bind(to: output.image)
//            .disposed(by: disposeBag)
//
//        // subscribe to the input morePhotosTapped event
//        //        input.morePhotosTapped
//        //            .subscribe(onNext: { [weak self] in
//        //                // show the limited library picker to let the user change their selection
//        //
//        //            })
//        //            .disposed(by: disposeBag)
//
//        // subscribe to the input keepCurrentTapped event
//        input.keepCurrentTapped
//            .bind(to: output.showCollectionView)
//            .disposed(by: disposeBag)
//
        
    }
    
    func getCurrentViewController(from view: UIView) -> UIViewController? {
        // get the next responder of the view
        var responder: UIResponder? = view
        // loop until the responder is a view controller or nil
        while responder != nil && !(responder is UIViewController) {
            // get the next responder
            responder = responder?.next
        }
        // return the responder as a view controller or nil
        return responder as? UIViewController
    }
    
    private func checkPhotoAuthorizationStatus() -> Observable<PHAuthorizationStatus> {
        return Observable.create { observer in
            // get and emit the photo authorization status for read write access level
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            observer.onNext(status)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func updateLocalization() {
        NkText.accept(localizationManager.localizedString(forKey: "Nickname"))
        checkText.accept(localizationManager.localizedString(forKey: "Check"))
        NkTextFieldPlaceholder.accept(localizationManager.localizedString(forKey: "Please enter your nickname"))
        NkValidFirstText.accept(localizationManager.localizedString(forKey: "Please enter 2~10 letters"))
        NkValidSecondText.accept(localizationManager.localizedString(forKey: "Please click Duplicate Check"))
        
    }
}
