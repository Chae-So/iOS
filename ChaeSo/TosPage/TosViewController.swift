import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ToSViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var tosViewModel: TosViewModel!
    
    private lazy var imageView = UIImageView()
    private lazy var firstLabel = UILabel()
    private lazy var secondLabel = UILabel()
    
    private lazy var allSelectLabel = UILabel()
    private lazy var serviceTosLabel = UILabel()
    private lazy var infoTosLabel = UILabel()
    
    private lazy var allSelectButton = UIButton()
    private lazy var serviceTosButton = UIButton()
    private lazy var infoTosButton = UIButton()
    private lazy var nextButton = UIButton()

    init(tosViewModel: TosViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.tosViewModel = tosViewModel
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
    
    func bind(){
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
        
//        tosViewModel.toggleAll
//            .asDriver(onErrorDriveWith: .empty())
//            .filter { $0 }
//            .map { _ in .scaleToFill }
//            .drive(infoTosButton.rx.imageViewContentMode)
//            .disposed(by: disposeBag)
        
        serviceTosButton.rx.tap
            .bind(to: tosViewModel.serviceTosButtonTapped)
            .disposed(by: disposeBag)
        
        tosViewModel.toggleService
            .asDriver(onErrorDriveWith: .empty())
            .drive(serviceTosButton.rx.isSelected)
            .disposed(by: disposeBag)
        
//        tosViewModel.toggleInfo
//            .asDriver(onErrorDriveWith: .empty())
//            .filter { $0 }
//            .map { _ in .scaleAspectFill }
//            .drive(infoTosButton.rx.imageViewContentMode)
//            .disposed(by: disposeBag)
        
        infoTosButton.rx.tap
            .bind(to: tosViewModel.infoTosButtonTapped)
            .disposed(by: disposeBag)
        
        tosViewModel.toggleInfo
            .asDriver(onErrorDriveWith: .empty())
            .drive(infoTosButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        
            
        
//        tosViewModel.toggleInfo
//            .filter { $0 }
//            .map { _ in .scaleAspectFill }
//            .bind(to: infoTosButton.rx.imageViewContentMode)
//            .disposed(by: disposeBag)


        
        
        


    }
    
    func attribute(){
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageView Attribute
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        //MARK: firstLabel Attribute
        firstLabel.textColor = UIColor.black
        firstLabel.font = UIFont(name: "Pretendard-Bold", size: 24)
        firstLabel.textAlignment = .center
        
        //MARK: secondLabel Attribute
        secondLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        secondLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        secondLabel.textAlignment = .center
        
        //MARK: allSelectLabel Attribute
        allSelectLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        allSelectLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        allSelectLabel.textAlignment = .left
        
        //MARK: serviceTosLabel Attribute
        serviceTosLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        serviceTosLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        serviceTosLabel.textAlignment = .left
        
        //MARK: infoTosLabel Attribute
        infoTosLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        infoTosLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        infoTosLabel.textAlignment = .left
        
        //MARK: allSelectButton Attribute
        allSelectButton.layer.cornerRadius = 2
        allSelectButton.layer.borderWidth = 2
        allSelectButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        let checkmarkSymbolConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .heavy)
        let checkmarkImage = UIImage(systemName: "checkmark", withConfiguration: checkmarkSymbolConfig)

        // 버튼에 체크마크 이미지 설정
        allSelectButton.setImage(checkmarkImage, for: .selected)
        allSelectButton.imageView!.contentMode = .scaleAspectFit

        //MARK: serviceTosButton Attribute
        serviceTosButton.layer.cornerRadius = 2
        serviceTosButton.layer.borderWidth = 2
        serviceTosButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
      
        // 버튼에 체크마크 이미지 설정
        serviceTosButton.setImage(checkmarkImage, for: .selected)

        //MARK: infoTosButton Attribute
        infoTosButton.layer.cornerRadius = 2
        infoTosButton.layer.borderWidth = 2
        infoTosButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        infoTosButton.setImage(checkmarkImage, for: .selected)
        
        
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
        [imageView,firstLabel,secondLabel]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(96.41*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(160*Constants.standardHeight)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.height.equalTo(96.41*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(311*Constants.standardHeight)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.height.equalTo(96.41*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(355*Constants.standardHeight)
        }
        
        [allSelectButton,allSelectLabel,serviceTosButton,serviceTosLabel,infoTosButton,infoTosLabel,nextButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        allSelectLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(76*Constants.standardWidth)
            //make.top.equalTo(secondLabel.snp.bottom).offset(32*Constants.standardHeight)
            make.top.equalToSuperview().offset(437*Constants.standardHeight)
        }

        serviceTosLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(76*Constants.standardWidth)
            make.top.equalTo(allSelectLabel.snp.bottom).offset(45*Constants.standardHeight)
        }

        infoTosLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
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

extension Reactive where Base: UIButton {
    var imageViewContentMode: Binder<UIView.ContentMode> {
        return Binder(self.base) { button, contentMode in
            button.imageView?.contentMode = contentMode
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
