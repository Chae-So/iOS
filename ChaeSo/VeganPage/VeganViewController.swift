import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Lottie

class VeganViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var veganViewModel: VeganViewModel!
    
    let name = "시금치"
    
    private lazy var selectVeganLabel = UILabel()
    private lazy var firstButton = UIButton()
    private lazy var secondButton = UIButton()
    private lazy var thirdButton = UIButton()
    private lazy var fourthButton = UIButton()
    private lazy var fifthButton = UIButton()
    private lazy var startButton = UIButton()
    
    private lazy var whiteView = UIView()
    private lazy var firstExplainLabel = UILabel()
    private lazy var secondExplainLabel = UILabel()
    
    init(veganViewModel: VeganViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.veganViewModel = veganViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
        
        firstExplainLabel.text = "I eat dairy products\n among animal ingredients"
        firstExplainLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        firstExplainLabel.numberOfLines = 2
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
        veganViewModel.veganText
            .asDriver(onErrorDriveWith: .empty())
            .drive(firstButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.LactoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(secondButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.OvoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(thirdButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.PescoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(fourthButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.PolloText
            .asDriver(onErrorDriveWith: .empty())
            .drive(fifthButton.rx.title())
            .disposed(by: disposeBag)
        
//        veganViewModel.allValid
//            .asDriver(onErrorDriveWith: .empty())
//            .drive(startButton.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        veganViewModel.allValid
//            .asDriver(onErrorJustReturn: false)
//            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
//            .drive(startButton.rx.backgroundColor)
//            .disposed(by: disposeBag)
//
//        veganViewModel.allValid
//            .asDriver(onErrorJustReturn: false)
//            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
//            .drive(startButton.rx.titleColor(for: .normal))
//            .disposed(by: disposeBag)
        
        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let veganViewModel = VeganViewModel(localizationManager: LocalizationManager.shared)
                let veganViewController = VeganViewController(veganViewModel: veganViewModel)
                self.navigationController?.pushViewController(veganViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func attribute(){
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: firstButton Attribute
        firstButton.adjustsImageWhenHighlighted = false
        firstButton.titleLabel?.textAlignment = .center
        firstButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        firstButton.setTitleColor(UIColor.black, for: .normal)
        firstButton.layer.cornerRadius = 20
        firstButton.backgroundColor = UIColor.white
        firstButton.setImage(UIImage(named: "firstVegan"), for: .normal)
        
        //MARK: secondButton Attribute
        secondButton.adjustsImageWhenHighlighted = false
        secondButton.titleLabel?.textAlignment = .center
        secondButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        secondButton.setTitleColor(UIColor.black, for: .normal)
        secondButton.layer.cornerRadius = 20
        secondButton.backgroundColor = UIColor.white
        secondButton.setImage(UIImage(named: "secondVegan"), for: .normal)
        
        //MARK: thirdButton Attribute
        thirdButton.adjustsImageWhenHighlighted = false
        thirdButton.titleLabel?.textAlignment = .center
        thirdButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        thirdButton.setTitleColor(UIColor.black, for: .normal)
        thirdButton.layer.cornerRadius = 20
        thirdButton.backgroundColor = UIColor.white
        thirdButton.setImage(UIImage(named: "thirdVegan"), for: .normal)
        
        //MARK: fourthButton Attribute
        fourthButton.adjustsImageWhenHighlighted = false
        fourthButton.titleLabel?.textAlignment = .center
        fourthButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        fourthButton.setTitleColor(UIColor.black, for: .normal)
        fourthButton.layer.cornerRadius = 20
        fourthButton.backgroundColor = UIColor.white
        fourthButton.setImage(UIImage(named: "fourthVegan"), for: .normal)
        
        //MARK: fifthButton Attribute
        fifthButton.adjustsImageWhenHighlighted = false
        fifthButton.titleLabel?.textAlignment = .center
        fifthButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        fifthButton.setTitleColor(UIColor.black, for: .normal)
        fifthButton.layer.cornerRadius = 20
        fifthButton.backgroundColor = UIColor.white
        fifthButton.setImage(UIImage(named: "fifthVegan"), for: .normal)
        
        //MARK: startButton Attribute
        startButton.titleLabel?.textAlignment = .center
        startButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        startButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        startButton.setTitle("next", for: .normal)
        startButton.backgroundColor = UIColor(named: "bgColor")
        startButton.layer.cornerRadius = 8
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
    }
    
    func layout(){
        [selectVeganLabel,firstButton,secondButton,thirdButton,fourthButton,fifthButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        firstButton.snp.makeConstraints { make in
            make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(40*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(308*Constants.standardHeight)
        }
        
        firstButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(8*Constants.standardWidth)
            make.trailing.equalTo(firstButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
            make.top.equalToSuperview().offset(8*Constants.standardHeight)
        }
        
        secondButton.snp.makeConstraints { make in
            make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(40*Constants.standardHeight)
            make.leading.equalTo(firstButton.snp.trailing).offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(308*Constants.standardHeight)
        }
        
        secondButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(8*Constants.standardWidth)
            make.trailing.equalTo(secondButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
            make.top.equalToSuperview().offset(8*Constants.standardHeight)
        }
        
        thirdButton.snp.makeConstraints { make in
            make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(40*Constants.standardHeight)
            make.leading.equalTo(secondButton.snp.trailing).offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(308*Constants.standardHeight)
        }
        
        thirdButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(8*Constants.standardWidth)
            make.trailing.equalTo(thirdButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
            make.top.equalToSuperview().offset(8*Constants.standardHeight)
        }
        
        fourthButton.snp.makeConstraints { make in
            make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(40*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(364*Constants.standardHeight)
        }
        
        fourthButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(8*Constants.standardWidth)
            make.trailing.equalTo(fourthButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
            make.top.equalToSuperview().offset(8*Constants.standardHeight)
        }

        fifthButton.snp.makeConstraints { make in
            make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(40*Constants.standardHeight)
            make.leading.equalTo(fourthButton.snp.trailing).offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(364*Constants.standardHeight)
        }
        
        fifthButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(8*Constants.standardWidth)
            make.trailing.equalTo(fifthButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
            make.top.equalToSuperview().offset(8*Constants.standardHeight)
        }
        
        
        view.addSubview(firstExplainLabel)
        firstExplainLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(70*Constants.standardHeight)
            make.leading.equalToSuperview().offset(100*Constants.standardWidth)
            make.top.equalToSuperview().offset(480*Constants.standardHeight)
        }
        
        
    }

}

//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        VeganViewController(veganViewModel: VeganViewModel(localizationManager: LocalizationManager.shared))
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
