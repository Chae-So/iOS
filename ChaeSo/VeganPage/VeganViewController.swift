import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class VeganViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var veganViewModel: VeganViewModel
    
    let progressView = UIProgressView()
    let leftButton = UIButton()
    lazy var titleLabel = UILabel()
    lazy var veganCollectionView = UICollectionView(frame: .zero, collectionViewLayout: LeftAlignedCollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 15*Constants.standardWidth
        $0.minimumLineSpacing = 10*Constants.standardHeight
    })
    
    lazy var startButton = UIButton()
    
    let whiteView = UIView()
    let smallView = UIView()
    lazy var veganLabel = UILabel()
    lazy var lactoLabel = UILabel()
    lazy var ovoLabel = UILabel()
    lazy var pescoLabel = UILabel()
    lazy var polloLabel = UILabel()
    lazy var flexitarianLabel = UILabel()
    
    lazy var firstImageView = UIImageView()
    lazy var secondImageView = UIImageView()
    lazy var thirdImageView = UIImageView()
    lazy var fourthImageView = UIImageView()
    lazy var fifthImageView = UIImageView()
    lazy var sixthImageView = UIImageView()
    
    var lastSelectedIndexPath: IndexPath?
    
    init(veganViewModel: VeganViewModel) {
        self.veganViewModel = veganViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        bind()
        layout()
        attribute()
        
    }
    
    func bind(){
        
        leftButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        veganViewModel.startText
            .asDriver(onErrorDriveWith: .empty())
            .drive(startButton.rx.title())
            .disposed(by: disposeBag)
        
        veganViewModel.startButtonEnabled
            .bind(to: startButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        veganViewModel.startButtonEnabled
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(startButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        veganViewModel.startButtonEnabled
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(startButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        veganViewModel.cellData
            .drive(veganCollectionView.rx.items(cellIdentifier: "VeganCollectionViewCell", cellType: VeganCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setImage(element.image, for: .normal)
                cell.tabButton.setTitle(element.text, for: .normal)
            }
            .disposed(by: disposeBag)

        veganCollectionView.rx.itemSelected
            .bind(to: veganViewModel.itemSelected)
            .disposed(by: disposeBag)
        
        veganCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                if let lastIndexPath = self.lastSelectedIndexPath, let lastCell = self.veganCollectionView.cellForItem(at: lastIndexPath) as? VeganCollectionViewCell {
                    lastCell.updateBorderColor(to: .clear)
                }
                
                if let cell = self.veganCollectionView.cellForItem(at: indexPath) as? VeganCollectionViewCell {
                    cell.updateBorderColor(to: UIColor(named: "prColor")!)
                }
                
                self.lastSelectedIndexPath = indexPath
            })
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

        self.view.backgroundColor = UIColor(named: "bgColor")
        
        progressView.do{
            $0.backgroundColor = UIColor(hexCode: "D9D9D9")
            $0.progressTintColor = UIColor(named: "prColor")
            $0.progress = 1
        }
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        
        titleLabel.do{
            $0.font = UIFont(name: "Pretendard-Bold", size: 24*Constants.standartFont)
            $0.text = veganViewModel.titleText
            $0.numberOfLines = 2
        }
        
        veganCollectionView.do{
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = UIColor(named: "bgColor")
            $0.register(VeganCollectionViewCell.self, forCellWithReuseIdentifier: "VeganCollectionViewCell")
        }
        
        
        whiteView.do{
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.sizeToFit()
            $0.layer.cornerRadius = 16 * Constants.standardHeight
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: -4*Constants.standardHeight)
            $0.layer.shadowRadius = 10*Constants.standardHeight
            $0.layer.shadowOpacity = 0.1
        }
        
        smallView.do{
            $0.backgroundColor = UIColor(named: "gray10")
            $0.sizeToFit()
            $0.layer.cornerRadius = $0.frame.size.height / 2
        }
        
        [veganLabel,lactoLabel,ovoLabel,pescoLabel,polloLabel,flexitarianLabel]
            .forEach {
                $0.font = UIFont(name: "Pretendard-Medium", size: 20*Constants.standartFont)
            }
        
        veganLabel.text = veganViewModel.veganText
        lactoLabel.text = veganViewModel.lactoText
        ovoLabel.text = veganViewModel.ovoText
        pescoLabel.text = veganViewModel.pescoText
        polloLabel.text = veganViewModel.polloText
        flexitarianLabel.text = veganViewModel.flexitarianText
        
        firstImageView.image = UIImage(named: "veganOne")
        secondImageView.image = UIImage(named: "veganTwo")
        thirdImageView.image = UIImage(named: "veganThree")
        fourthImageView.image = UIImage(named: "veganFour")
        fifthImageView.image = UIImage(named: "veganFive")
        sixthImageView.image = UIImage(named: "veganSix")
        
        startButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
            $0.isEnabled = false
        }
    }
    
    func layout(){
        
        [progressView,leftButton,titleLabel,veganCollectionView,whiteView]
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
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(progressView.snp.bottom).offset(100*Constants.standardHeight)
        }
        
        veganCollectionView.snp.makeConstraints { make in
            make.width.equalTo(330*Constants.standardWidth)
            make.height.equalTo(180*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(titleLabel.snp.bottom).offset(30*Constants.standardHeight)
        }
    
        whiteView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(421*Constants.standardHeight)
        }
        
        
        [smallView,veganLabel,lactoLabel,ovoLabel,pescoLabel,polloLabel,flexitarianLabel,firstImageView,secondImageView,thirdImageView,fourthImageView,fifthImageView,sixthImageView]
            .forEach { UIView in
                whiteView.addSubview(UIView)
            }
        
        smallView.snp.makeConstraints { make in
            make.width.equalTo(60*Constants.standardWidth)
            make.height.equalTo(5*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10*Constants.standardHeight)
        }
        
        veganLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(48*Constants.standardHeight)
        }
        
        lactoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(veganLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        ovoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(lactoLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        pescoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(ovoLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        polloLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pescoLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        flexitarianLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(polloLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.width.equalTo(224*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(135*Constants.standardWidth)
            make.top.equalToSuperview().offset(48*Constants.standardHeight)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.width.equalTo(224*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(135*Constants.standardWidth)
            make.top.equalTo(firstImageView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.width.equalTo(224*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(135*Constants.standardWidth)
            make.top.equalTo(secondImageView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        fourthImageView.snp.makeConstraints { make in
            make.width.equalTo(224*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(135*Constants.standardWidth)
            make.top.equalTo(thirdImageView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        fifthImageView.snp.makeConstraints { make in
            make.width.equalTo(224*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(135*Constants.standardWidth)
            make.top.equalTo(fourthImageView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        sixthImageView.snp.makeConstraints { make in
            make.width.equalTo(224*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(135*Constants.standardWidth)
            make.top.equalTo(fifthImageView.snp.bottom).offset(16*Constants.standardHeight)
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
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
//    }
//}
//#endif
