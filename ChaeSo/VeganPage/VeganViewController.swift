import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Lottie

class VeganViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var veganViewModel: VeganViewModel!
    
    
    
    private lazy var selectVeganLabel = UILabel()
    private lazy var firstButton = UIButton()
    private lazy var secondButton = UIButton()
    private lazy var thirdButton = UIButton()
    private lazy var fourthButton = UIButton()
    private lazy var fifthButton = UIButton()
    private lazy var startButton = UIButton()
    
    private lazy var whiteView = UIView()
    private lazy var veganLabel = UILabel()
    private lazy var lactoLabel = UILabel()
    private lazy var ovoLabel = UILabel()
    private lazy var pescoLabel = UILabel()
    private lazy var polloLabel = UILabel()
    
    private lazy var firstImageView = UIImageView()
    private lazy var secondImageView = UIImageView()
    private lazy var thirdImageView = UIImageView()
    private lazy var fourthImageView = UIImageView()
    private lazy var fifthImageView = UIImageView()
    
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
        
        print(UserInfo.shared.nickname)
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
        veganViewModel.veganText
            .asDriver(onErrorDriveWith: .empty())
            .drive(firstButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.veganText
            .asDriver(onErrorDriveWith: .empty())
            .drive(veganLabel.rx.text)
            .disposed(by: disposeBag)
        
        veganViewModel.lactoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(secondButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.lactoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(lactoLabel.rx.text)
            .disposed(by: disposeBag)
        
        veganViewModel.ovoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(thirdButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.ovoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(ovoLabel.rx.text)
            .disposed(by: disposeBag)
        
        veganViewModel.pescoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(fourthButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.pescoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(pescoLabel.rx.text)
            .disposed(by: disposeBag)
        
        veganViewModel.polloText
            .asDriver(onErrorDriveWith: .empty())
            .drive(fifthButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.polloText
            .asDriver(onErrorDriveWith: .empty())
            .drive(polloLabel.rx.text)
            .disposed(by: disposeBag)
        
        firstButton.rx.tap
            .bind(to: veganViewModel.veganButtonTapped)
            .disposed(by: disposeBag)
        
        veganViewModel.selectedVegan
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(firstButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        secondButton.rx.tap
            .bind(to: veganViewModel.lactoButtonTapped)
            .disposed(by: disposeBag)
        
        veganViewModel.selectedLacto
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(secondButton.rx.borderColor)
            .disposed(by: disposeBag)

        thirdButton.rx.tap
            .bind(to: veganViewModel.ovoButtonTapped)
            .disposed(by: disposeBag)
        
        veganViewModel.selectedOvo
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(thirdButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        fourthButton.rx.tap
            .bind(to: veganViewModel.pescoButtonTapped)
            .disposed(by: disposeBag)
        
        veganViewModel.selectedPesco
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(fourthButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        fifthButton.rx.tap
            .bind(to: veganViewModel.polloButtonTapped)
            .disposed(by: disposeBag)
        
        veganViewModel.selectedPollo
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(fifthButton.rx.borderColor)
            .disposed(by: disposeBag)
        

        veganViewModel.allValid
            .asDriver(onErrorDriveWith: .empty())
            .drive(startButton.rx.isEnabled)
            .disposed(by: disposeBag)

        veganViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(startButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        veganViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(startButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let searchingViewModel = SearchingViewModel(localizationManager: LocalizationManager.shared)
                let searchingViewController = SearchingViewController(searchingViewModel: searchingViewModel)
                self.navigationController?.pushViewController(searchingViewController, animated: true)
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
        firstButton.layer.borderWidth = 1
        firstButton.layer.borderColor = UIColor.clear.cgColor
        firstButton.backgroundColor = UIColor.white
        firstButton.setImage(UIImage(named: "firstVegan"), for: .normal)
        
        //MARK: secondButton Attribute
        secondButton.adjustsImageWhenHighlighted = false
        secondButton.titleLabel?.textAlignment = .center
        secondButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        secondButton.setTitleColor(UIColor.black, for: .normal)
        secondButton.layer.cornerRadius = 20
        secondButton.layer.borderWidth = 1
        secondButton.layer.borderColor = UIColor.clear.cgColor
        secondButton.backgroundColor = UIColor.white
        secondButton.setImage(UIImage(named: "secondVegan"), for: .normal)
        
        //MARK: thirdButton Attribute
        thirdButton.adjustsImageWhenHighlighted = false
        thirdButton.titleLabel?.textAlignment = .center
        thirdButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        thirdButton.setTitleColor(UIColor.black, for: .normal)
        thirdButton.layer.cornerRadius = 20
        thirdButton.layer.borderWidth = 1
        thirdButton.layer.borderColor = UIColor.clear.cgColor
        thirdButton.backgroundColor = UIColor.white
        thirdButton.setImage(UIImage(named: "thirdVegan"), for: .normal)
        
        //MARK: fourthButton Attribute
        fourthButton.adjustsImageWhenHighlighted = false
        fourthButton.titleLabel?.textAlignment = .center
        fourthButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        fourthButton.setTitleColor(UIColor.black, for: .normal)
        fourthButton.layer.cornerRadius = 20
        fourthButton.layer.borderWidth = 1
        fourthButton.layer.borderColor = UIColor.clear.cgColor
        fourthButton.backgroundColor = UIColor.white
        fourthButton.setImage(UIImage(named: "fourthVegan"), for: .normal)
        
        //MARK: fifthButton Attribute
        fifthButton.adjustsImageWhenHighlighted = false
        fifthButton.titleLabel?.textAlignment = .center
        fifthButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        fifthButton.setTitleColor(UIColor.black, for: .normal)
        fifthButton.layer.cornerRadius = 20
        fifthButton.layer.borderWidth = 1
        fifthButton.layer.borderColor = UIColor.clear.cgColor
        fifthButton.backgroundColor = UIColor.white
        fifthButton.setImage(UIImage(named: "fifthVegan"), for: .normal)
        
        //MARK: whiteView Attribute
        whiteView.backgroundColor = UIColor(hexCode: "F5F5F5")
        whiteView.layer.cornerRadius = 16
        veganLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        lactoLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        ovoLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        pescoLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        polloLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        
        firstImageView.image = UIImage(named: "veganOne")
        secondImageView.image = UIImage(named: "veganTwo")
        thirdImageView.image = UIImage(named: "veganThree")
        fourthImageView.image = UIImage(named: "veganFour")
        fifthImageView.image = UIImage(named: "veganFive")
        
        //MARK: startButton Attribute
        startButton.titleLabel?.textAlignment = .center
        startButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        startButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        startButton.setTitle("start", for: .normal)
        startButton.backgroundColor = UIColor(hexCode: "F5F5F5")
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
            //make.trailing.equalTo(firstButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
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
            //make.trailing.equalTo(secondButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
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
            //make.trailing.equalTo(thirdButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
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
            //make.trailing.equalTo(fourthButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
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
            //make.trailing.equalTo(fifthButton.titleLabel!.snp.leading).offset(-8*Constants.standardWidth)
            make.top.equalToSuperview().offset(8*Constants.standardHeight)
        }
    
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(462*Constants.standardHeight)
        }
        
        
        [veganLabel,lactoLabel,ovoLabel,pescoLabel,polloLabel,firstImageView,secondImageView,thirdImageView,fourthImageView,fifthImageView]
            .forEach { UIView in
                whiteView.addSubview(UIView)
            }
        
        veganLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalToSuperview().offset(47*Constants.standardHeight)
        }
        
        lactoLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalTo(veganLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        ovoLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalTo(lactoLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        pescoLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalTo(ovoLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        polloLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalTo(pescoLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.width.equalTo(184*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(148*Constants.standardWidth)
            make.top.equalToSuperview().offset(47*Constants.standardHeight)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.width.equalTo(184*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(148*Constants.standardWidth)
            make.top.equalTo(firstImageView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.width.equalTo(184*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(148*Constants.standardWidth)
            make.top.equalTo(secondImageView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        fourthImageView.snp.makeConstraints { make in
            make.width.equalTo(184*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(148*Constants.standardWidth)
            make.top.equalTo(thirdImageView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        fifthImageView.snp.makeConstraints { make in
            make.width.equalTo(184*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(148*Constants.standardWidth)
            make.top.equalTo(fourthImageView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
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
