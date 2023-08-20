import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import Then

class VeganViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var veganViewModel: VeganViewModel!
    
    private lazy var progressView = UIProgressView()
    private lazy var titleLabel = UILabel()
    private let veganCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private lazy var startButton = UIButton()
    
    private lazy var whiteView = UIView()
    private lazy var smallView = UIView()
    private lazy var veganLabel = UILabel()
    private lazy var lactoLabel = UILabel()
    private lazy var ovoLabel = UILabel()
    private lazy var pescoLabel = UILabel()
    private lazy var polloLabel = UILabel()
    private lazy var flexitarianLabel = UILabel()
    
    private lazy var firstImageView = UIImageView()
    private lazy var secondImageView = UIImageView()
    private lazy var thirdImageView = UIImageView()
    private lazy var fourthImageView = UIImageView()
    private lazy var fifthImageView = UIImageView()
    private lazy var sixthImageView = UIImageView()
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        bind()
        layout()
        attribute()
        
    }
    
    func bind(){
        
        veganViewModel.cellData
            .drive(veganCollectionView.rx.items(cellIdentifier: "VeganCollectionViewCell", cellType: VeganCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setImage(element.image, for: .normal)
                cell.tabButton.setTitle(element.text, for: .normal)
            }
            .disposed(by: disposeBag)

        
        veganCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        veganViewModel.firstSelectedIndexPath
                .bind(to: veganCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        veganCollectionView.rx.itemSelected
            .bind(to: veganViewModel.firstSelectedIndexPath)
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
        
        progressView.do{
            $0.backgroundColor = UIColor(hexCode: "D9D9D9")
            $0.progressTintColor = UIColor(named: "prColor")
            $0.progress = 1
            
        }
        
        titleLabel.do{
            $0.font = UIFont(name: "Pretendard-Bold", size: 24)
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
            $0.layer.shadowColor = UIColor.black.cgColor // 색깔
            //$0.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
            $0.layer.shadowOffset = CGSize(width: 0, height: -4) // 위치조정
            $0.layer.shadowRadius = 10 // 반경
            $0.layer.shadowOpacity = 0.1 // alpha값
        }
        
        smallView.do{
            $0.backgroundColor = UIColor(named: "gray10")
            $0.sizeToFit()
            $0.layer.cornerRadius = $0.frame.size.height / 2
        }
        
        [veganLabel,lactoLabel,ovoLabel,pescoLabel,polloLabel,flexitarianLabel]
            .forEach {
                $0.font = UIFont(name: "Pretendard-Medium", size: 20)
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
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.setTitle("start", for: .normal)
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.layer.cornerRadius = 8 * Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
        }
    }
    
    func layout(){
        
        [progressView,titleLabel,veganCollectionView,whiteView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        progressView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
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
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(48*Constants.standardHeight)
        }
        
        lactoLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(veganLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        ovoLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(lactoLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        pescoLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(ovoLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        polloLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pescoLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        flexitarianLabel.snp.makeConstraints { make in
            //make.width.equalTo(99*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
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

extension VeganViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = veganViewModel.currentCellData
        
        // 텍스트 크기 계산
        let text = items[indexPath.item].text
        let font = UIFont(name: "Pretendard-Medium", size: 20 * Constants.standardWidth)
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        // 이미지 크기 계산
        let image = items[indexPath.item].image
        let imageSize = image?.size ?? CGSize.zero
        
        // 총 너비 및 높이 계산
        let width = textSize.width + imageSize.width + 20 * 2 * Constants.standardWidth  // 좌우 패딩
        let height = textSize.height + 8 * 2 * Constants.standardHeight // 이미지와 텍스트 간의 간격 및 상하 패딩
        
        return CGSize(width: width, height: height-2)
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
