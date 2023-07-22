import UIKit
import SnapKit
import RxSwift
import RxCocoa
import PhotosUI

class NicknameViewController: UIViewController {

    private let disposeBag = DisposeBag()
    var nicknameViewModel: NicknameViewModel!
    var ptCollectionViewModel: PTCollectionViewModel!
    
    private lazy var nicknameButton = UIButton()
    private lazy var plusButton = UIButton()
    private lazy var nicknameLabel = UILabel()
    private lazy var checkButton = UIButton()
    private lazy var nicknameTextField = UITextField()
    private lazy var isValidNkFirstLabel = UILabel()
    private lazy var isValidNkSecondLabel = UILabel()
    private lazy var nextButton = UIButton()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(nicknameViewModel: NicknameViewModel!, ptCollectionViewModel: PTCollectionViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.nicknameViewModel = nicknameViewModel
        self.ptCollectionViewModel = ptCollectionViewModel

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true

        bind()
        attribute()
        layout()
    }

    
    private func showCollectionAlert() {
        let collectionVC = PTCollectionViewController(ptCollectionViewModel: self.ptCollectionViewModel)
        collectionVC.modalPresentationStyle = .overFullScreen
        self.present(collectionVC, animated: true)
    }
    
    func bind(){
        
        
        // Bind PHPicker result to update nickname button image
        ptCollectionViewModel.pickerResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .single(let image):
                    self.nicknameButton.setImage(image, for: .normal)
                    self.nicknameButton.imageView?.contentMode = .scaleAspectFill
                case .multiple:
                    break // do nothing
                }
            })
            .disposed(by: disposeBag)
        
        
        // Bind alert action to show alert controller
        ptCollectionViewModel.alertAction
            .subscribe(onNext: { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .showCollectionAlert:
                    self.showCollectionAlert()
                case .showPickerAlert:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        // Bind picker configuration to present PHPicker
        ptCollectionViewModel.pickerConfiguration
            .subscribe(onNext: { [weak self] configuration in
                guard let self = self else { return }
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self.ptCollectionViewModel!
                self.present(picker, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        
        
        
        ////////////
        
        nicknameViewModel.NkText
            .asDriver(onErrorDriveWith: .empty())
            .drive(nicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
        nicknameViewModel.checkText
            .asDriver(onErrorDriveWith: .empty())
            .drive(checkButton.rx.title())
            .disposed(by: disposeBag)
        
        nicknameViewModel.NkValidFirstText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidNkFirstLabel.rx.text)
            .disposed(by: disposeBag)
        
        nicknameViewModel.NkValidSecondText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidNkSecondLabel.rx.text)
            .disposed(by: disposeBag)
        
        nicknameTextField.rx.text.orEmpty
            .bind(to: nicknameViewModel.NkInput)
            .disposed(by: disposeBag)
        
        plusButton.rx.tap
            .bind(to: ptCollectionViewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
        nicknameButton.rx.tap
            .bind(to: ptCollectionViewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
//
        
        
        
        
        
        nicknameViewModel.nkLengthValid
            .asDriver(onErrorDriveWith: .empty())
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidNkFirstLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorDriveWith: .empty())
            .map { $0 ? UIColor(named: "prColor")! : UIColor(hexCode: "FD4321") }
            .drive(nicknameTextField.rx.borderColor)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorDriveWith: .empty())
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(nextButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let veganViewModel = VeganViewModel(localizationManager: LocalizationManager.shared)
                let veganViewController = VeganViewController(veganViewModel: veganViewModel)
                UserInfo.shared.nickname = self.nicknameTextField.text!
                self.navigationController?.pushViewController(veganViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        ptCollectionViewModel.selectedImageRelay
            .observe(on: MainScheduler.instance)
            .bind(to: nicknameButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
        
        print("Starting to subscribe to selectedImageRelay")
        ptCollectionViewModel.selectedImageRelay
            .subscribe(onNext: {_ in
                print("Image received from selectedImageRelay")
            })
            .disposed(by: disposeBag)
    }
    
    func attribute(){
        
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: nicknameButton Attribute
        nicknameButton.setImage(UIImage(named: "userImage"), for: .normal)
        //nicknameButton.imageView!.contentMode = .scaleAspectFill
        nicknameButton.backgroundColor = .white
        nicknameButton.clipsToBounds = true
        nicknameButton.layer.cornerRadius = 50*Constants.standardWidth //(imageButton.bounds.size.width*Constants.standardWidth) / 2
        nicknameButton.adjustsImageWhenHighlighted = false
        
        //MARK: plusButton Attribute
        plusButton.setImage(UIImage(named: "plusButton"), for: .normal)
        plusButton.backgroundColor = UIColor(named: "gray10")
        plusButton.layer.cornerRadius = 12*Constants.standardHeight //(plusButton.frame.height*Constants.standardHeight) / 2
        plusButton.adjustsImageWhenHighlighted = false
        
        //MARK: nicknameLabel attribute
        nicknameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nicknameLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        
        //MARK: nicknameTextField attribute
        nicknameTextField.alpha = 0.56
        nicknameTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        nicknameTextField.layer.cornerRadius = 8
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.borderColor = UIColor.clear.cgColor
        nicknameTextField.addLeftPadding()
        
        //MARK: checkButton attribute
        checkButton.titleLabel?.textAlignment = .center
        checkButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        checkButton.tintColor = .white
        checkButton.backgroundColor = UIColor(named: "prColor")
        checkButton.layer.cornerRadius = 8
        
        //MARK: isValidNkFirstLabel attribute
        isValidNkFirstLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidNkFirstLabel.textColor = UIColor(named: "gray20")
        
        //MARK: isValidNkSecondLabel attribute
        isValidNkSecondLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidNkSecondLabel.textColor = UIColor(named: "gray20")
        
        //MARK: nextButton attribute
        nextButton.titleLabel?.textAlignment = .center
        nextButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        nextButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        nextButton.setTitle("next", for: .normal)
        nextButton.backgroundColor = UIColor(named: "bgColor")
        nextButton.layer.cornerRadius = 8
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
    }
    
    func layout(){
        [nicknameButton,plusButton,nicknameLabel,nicknameTextField,checkButton,isValidNkFirstLabel,isValidNkSecondLabel,nextButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        nicknameButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(100*Constants.standardHeight)
            make.leading.equalToSuperview().offset(138*Constants.standardWidth)
            make.top.equalToSuperview().offset(160*Constants.standardHeight)
        }
        
        plusButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(nicknameButton.snp.leading).offset(71*Constants.standardWidth)
            make.top.equalTo(nicknameButton.snp.top).offset(76*Constants.standardHeight)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.height.equalTo(17*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(296*Constants.standardHeight)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.width.equalTo(223*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(112*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalTo(nicknameTextField.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(nicknameTextField.snp.top)
        }
        
        isValidNkFirstLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidNkSecondLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidNkFirstLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(720*Constants.standardHeight)
        }
        
    }

}

//extension ViewController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        // dismiss the picker
//        picker.dismiss(animated: true)
//        // trigger the view model input pickedImages event with the results
//        viewModel.input.pickedImages.onNext(results)
//    }
//}



//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        NicknameViewController(nicknameViewModel: NicknameViewModel(localizationManager: LocalizationManager.shared))
//    }
//
//    func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//    }
//}
//
//struct ViewController_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhoneX"))
//
//    }
//}
//#endif
