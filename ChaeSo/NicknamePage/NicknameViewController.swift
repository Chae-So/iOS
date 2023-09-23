import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import PhotosUI

class NicknameViewController: UIViewController {

    let disposeBag = DisposeBag()
    var nicknameViewModel: NicknameViewModel
    
    let progressView = UIProgressView()
    lazy var leftButton = UIButton()
    lazy var nicknameButton = UIButton()
    lazy var plusButton = UIButton()
    lazy var nicknameLabel = UILabel()
    lazy var checkButton = UIButton()
    lazy var nicknameTextField = UITextField()
    lazy var isValidNkFirstLabel = UILabel()
    lazy var isValidNkSecondLabel = UILabel()
    lazy var nextButton = UIButton()
        
    init(nicknameViewModel: NicknameViewModel) {
        self.nicknameViewModel = nicknameViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        bind()
        attribute()
        layout()
    }

    
    func bind(){
        
        leftButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        nicknameViewModel.nextText
            .asDriver(onErrorDriveWith: .empty())
            .drive(nextButton.rx.title())
            .disposed(by: disposeBag)
        
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
            .bind(to: nicknameViewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
        nicknameButton.rx.tap
            .bind(to: nicknameViewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
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
        
        nicknameViewModel.nicknameButtonTapped
            .subscribe(onNext: {
                let mainPTCollectionViewController = MainPTCollectionViewController(mainPTCollectionViewModel: MainPTCollectionViewModel(photoViewModelProtocol: self.nicknameViewModel))
                mainPTCollectionViewController.modalPresentationStyle = .fullScreen
                mainPTCollectionViewController.type = "nickname"
                self.present(mainPTCollectionViewController, animated: true)
            })
            .disposed(by: disposeBag)
  
        nicknameViewModel.selectedPhotosRelay
            .map { $0.first }
            .bind(to: nicknameButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
        
    }
    
    func attribute(){

        self.view.backgroundColor = UIColor(named: "bgColor")
        
        progressView.do{
            $0.backgroundColor = UIColor(hexCode: "D9D9D9")
            $0.progressTintColor = UIColor(named: "prColor")
            $0.progress = 0.66
        }
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        
        nicknameButton.do{
            $0.setImage(UIImage(named: "userImage"), for: .normal)
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.sizeToFit()
            $0.layer.cornerRadius = $0.frame.size.height / 2
        }
        
        plusButton.do{
            $0.setImage(UIImage(named: "plusButton"), for: .normal)
            $0.backgroundColor = UIColor(named: "gray10")
            $0.sizeToFit()
            $0.layer.cornerRadius = $0.frame.size.height / 2
        }
        
        nicknameLabel.do{
            $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        }
        
        nicknameTextField.do{
            $0.alpha = 0.56
            $0.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.addLeftPadding()
        }
        
        checkButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.tintColor = .white
            $0.backgroundColor = UIColor(named: "prColor")
            $0.layer.cornerRadius = 8*Constants.standardHeight
        }
        
        [isValidNkFirstLabel,isValidNkSecondLabel]
            .forEach{
                $0.font = UIFont(name: "Pretendard-Medium", size: 13*Constants.standartFont)
                $0.textColor = UIColor(named: "gray20")
            }
        
        nextButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.backgroundColor = UIColor(named: "bgColor")
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
        }
    }
    
    func layout(){
        [progressView,leftButton,nicknameButton,plusButton,nicknameLabel,nicknameTextField,checkButton,isValidNkFirstLabel,isValidNkSecondLabel,nextButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        progressView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardHeight)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(10*Constants.standardHeight)
            make.top.equalToSuperview().offset(63*Constants.standardHeight)
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
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidNkSecondLabel.snp.makeConstraints { make in
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


//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        NicknameViewController(nicknameViewModel: NicknameViewModel(localizationManager: LocalizationManager.shared), ptCollectionViewModel: PTCollectionViewModel())
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
