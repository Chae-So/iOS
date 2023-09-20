import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class TosViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var tosViewModel: TosViewModel
    
    let progressView = UIProgressView()
    lazy var leftButton = UIButton()
    lazy var imageView = UIImageView()
    lazy var firstLabel = UILabel()
    lazy var secondLabel = UILabel()
    
    lazy var allSelectLabel = UILabel()
    lazy var serviceTosLabel = UILabel()
    lazy var infoTosLabel = UILabel()
    
    let allSelectButton = UIButton()
    let serviceTosButton = UIButton()
    let infoTosButton = UIButton()
    lazy var nextButton = UIButton()

    init(tosViewModel: TosViewModel) {
        self.tosViewModel = tosViewModel
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
        
        tosViewModel.nextText
            .asDriver(onErrorDriveWith: .empty())
            .drive(nextButton.rx.title())
            .disposed(by: disposeBag)
        
        tosViewModel.firstLabelText
            .asDriver(onErrorDriveWith: .empty())
            .drive(firstLabel.rx.text)
            .disposed(by: disposeBag)
        
        tosViewModel.secondLabelText
            .asDriver(onErrorDriveWith: .empty())
            .drive(secondLabel.rx.text)
            .disposed(by: disposeBag)
        
        tosViewModel.allSelectLabelText
            .asDriver(onErrorDriveWith: .empty())
            .drive(allSelectLabel.rx.text)
            .disposed(by: disposeBag)
        
        tosViewModel.serviceTosLabelText
            .asDriver(onErrorDriveWith: .empty())
            .drive(serviceTosLabel.rx.text)
            .disposed(by: disposeBag)
        
        tosViewModel.infoTosLabelText
            .asDriver(onErrorDriveWith: .empty())
            .drive(infoTosLabel.rx.text)
            .disposed(by: disposeBag)
        
        allSelectButton.rx.tap
            .bind(to: tosViewModel.allSelectButtonTapped)
            .disposed(by: disposeBag)
        
        tosViewModel.toggleAll
            .asDriver(onErrorDriveWith: .empty())
            .drive(allSelectButton.rx.isSelected)
            .disposed(by: disposeBag)
   
        serviceTosButton.rx.tap
            .bind(to: tosViewModel.serviceTosButtonTapped)
            .disposed(by: disposeBag)
        
        tosViewModel.toggleService
            .asDriver(onErrorDriveWith: .empty())
            .drive(serviceTosButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        infoTosButton.rx.tap
            .bind(to: tosViewModel.infoTosButtonTapped)
            .disposed(by: disposeBag)
        
        tosViewModel.toggleInfo
            .asDriver(onErrorDriveWith: .empty())
            .drive(infoTosButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        tosViewModel.allCheck
            .asDriver(onErrorDriveWith: .empty())
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        tosViewModel.allCheck
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        tosViewModel.allCheck
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(nextButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let nicknameViewModel = NicknameViewModel(localizationManager: LocalizationManager.shared)
                let nicknameViewController = NicknameViewController(nicknameViewModel: nicknameViewModel)
                self.navigationController?.pushViewController(nicknameViewController, animated: true)
            })
            .disposed(by: disposeBag)

    }
    
    func attribute(){

        self.view.backgroundColor = UIColor(named: "bgColor")
        
        progressView.do{
            $0.backgroundColor = UIColor(hexCode: "D9D9D9")
            $0.progressTintColor = UIColor(named: "prColor")
            $0.progress = 0.33
        }
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)

        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        firstLabel.do{
            $0.textColor = UIColor.black
            $0.font = UIFont(name: "Pretendard-Bold", size: 24*Constants.standartFont)
            $0.textAlignment = .center
        }
        
        secondLabel.do{
            $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.textAlignment = .center
        }
        
        [allSelectLabel,serviceTosLabel,infoTosLabel]
            .forEach{
                $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                $0.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
                $0.textAlignment = .left
            }

        let checkmarkSymbolConfig = UIImage.SymbolConfiguration(pointSize: 20*Constants.standartFont, weight: .heavy)
        let checkmarkImage = UIImage(systemName: "checkmark", withConfiguration: checkmarkSymbolConfig)
        
        [allSelectButton,serviceTosButton,infoTosButton]
            .forEach{
                $0.layer.cornerRadius = 2*Constants.standardHeight
                $0.layer.borderWidth = 2
                $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
                $0.setImage(checkmarkImage, for: .selected)
                $0.imageView?.tintColor = .white
                $0.imageView?.backgroundColor = UIColor(named: "prColor")
                $0.contentEdgeInsets = UIEdgeInsets(top: 2*Constants.standardHeight, left: 2*Constants.standardWidth, bottom: 2*Constants.standardHeight, right: 2*Constants.standardWidth)
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
        [progressView,leftButton,imageView,firstLabel,secondLabel]
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
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(96.41*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(160*Constants.standardHeight)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(311*Constants.standardHeight)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(355*Constants.standardHeight)
        }
        
        [allSelectButton,allSelectLabel,serviceTosButton,serviceTosLabel,infoTosButton,infoTosLabel,nextButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }

        
        allSelectLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(76*Constants.standardWidth)
            make.top.equalToSuperview().offset(437*Constants.standardHeight)
        }

        serviceTosLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(76*Constants.standardWidth)
            make.top.equalTo(allSelectLabel.snp.bottom).offset(45*Constants.standardHeight)
        }

        infoTosLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(76*Constants.standardWidth)
            make.top.equalTo(serviceTosLabel.snp.bottom).offset(45*Constants.standardHeight)
        }
        
        allSelectButton.snp.makeConstraints { make in
            make.width.equalTo(20*Constants.standardWidth)
            make.height.equalTo(20*Constants.standardHeight)
            make.leading.equalToSuperview().offset(29*Constants.standardWidth)
            make.top.equalToSuperview().offset(436*Constants.standardHeight)
        }

        serviceTosButton.snp.makeConstraints { make in
            make.width.equalTo(20*Constants.standardWidth)
            make.height.equalTo(20*Constants.standardHeight)
            make.leading.equalToSuperview().offset(29*Constants.standardWidth)
            make.top.equalTo(allSelectButton.snp.bottom).offset(44*Constants.standardHeight)
        }

        infoTosButton.snp.makeConstraints { make in
            make.width.equalTo(20*Constants.standardWidth)
            make.height.equalTo(20*Constants.standardHeight)
            make.leading.equalToSuperview().offset(29*Constants.standardWidth)
            make.top.equalTo(serviceTosButton.snp.bottom).offset(44*Constants.standardHeight)
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
//        ToSViewController(tosViewModel: TosViewModel(localizationManager: LocalizationManager.shared))
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
