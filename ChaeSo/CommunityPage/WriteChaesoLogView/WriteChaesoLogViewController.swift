import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

class WriteChaesoLogViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    var writeChaesoLogViewModel: WriteChaesoLogViewModel
    
    // MARK: - UI Elements
    private lazy var writeChaesoLogLabel = UILabel()
    private lazy var backButton = UIButton()
    private lazy var separateFirstView = UIView()
    private lazy var separateSecondView = UIView()
    private lazy var separateThirdView = UIView()
    private lazy var separateFourthView = UIView()
    private lazy var firstLabel = UILabel()
    private lazy var secondLabel = UILabel()
    
    private let photoAddCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 100 * Constants.standardHeight, height: 100 * Constants.standardHeight)
        $0.minimumInteritemSpacing = 8 // 아이템 간의 최소 간격
    })
    private let firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal

        $0.minimumInteritemSpacing = 8 // 아이템 간의 최소 간격
    })
    
    private let secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        
        $0.minimumInteritemSpacing = 8 // 아이템 간의 최소 간격
    })
    
    private lazy var textView = UITextView()
    
    private lazy var shareButton = UIButton()
    
    // MARK: - Initializers
    
    init(writeChaesoLogViewModel: WriteChaesoLogViewModel) {
        self.writeChaesoLogViewModel = writeChaesoLogViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        attribute()
        layout()
        bind()
    }
    
    
    func bind(){

        writeChaesoLogViewModel.selectedPhotosRelay
            .map { [UIImage(named: "tomato")!] + $0 }
            .bind(to: photoAddCollectionView.rx.items) { (collectionView, index, image) -> UICollectionViewCell in
                if index == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddFirstCollectionViewCell", for: IndexPath(row: index, section: 0)) as! PhotoAddFirstCollectionViewCell
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddCollectionViewCell", for: IndexPath(row: index, section: 0)) as! PhotoAddCollectionViewCell
                    cell.photoImage.image = image
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        photoAddCollectionView.rx.itemSelected
            .subscribe(onNext: {[weak self] aaa in
                guard let self = self else { return }
                switch aaa.row{
                case 0:
                    let mainPTCollectionViewController =  MainPTCollectionViewController(mainPTCollectionViewModel: MainPTCollectionViewModel(photoViewModelProtocol: self.writeChaesoLogViewModel))
                    mainPTCollectionViewController.modalPresentationStyle = .fullScreen
                    self.present(mainPTCollectionViewController, animated: true)
                default:
                    break
                }
            })
        
        firstCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        writeChaesoLogViewModel.firstItems
            .bind(to: firstCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        
        writeChaesoLogViewModel.firstSelectedIndexPath
                .bind(to: firstCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        firstCollectionView.rx.itemSelected
            .bind(to: writeChaesoLogViewModel.firstSelectedIndexPath)
            .disposed(by: disposeBag)
        
        secondCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        writeChaesoLogViewModel.secondItems
            .bind(to: secondCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        
        writeChaesoLogViewModel.secondSelectedIndexPath
                .bind(to: secondCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        
        
        secondCollectionView.rx.itemSelected
            .bind(to: writeChaesoLogViewModel.secondSelectedIndexPath)
            .disposed(by: disposeBag)
        
        textView.rx.didBeginEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.textView.textColor = .black
                self.textView.text = nil
            })
            .disposed(by: disposeBag)

        writeChaesoLogViewModel.textViewPlaceholder
            .bind(to: textView.rx.text)
            .disposed(by: disposeBag)
    
    }

   
    
    func attribute(){
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        backButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        }
        
        writeChaesoLogLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.text = "채소로그"
        }
        
        [separateFirstView,separateSecondView,separateThirdView,separateFourthView]
            .forEach{$0.backgroundColor = UIColor(hexCode: "D9D9D9")}
        
        
        firstLabel.do{
            $0.text = writeChaesoLogViewModel.firstText
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        secondLabel.do{
            $0.text = writeChaesoLogViewModel.secondText
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        photoAddCollectionView.do{
            $0.isPagingEnabled = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.register(PhotoAddFirstCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoAddFirstCollectionViewCell")
            $0.register(PhotoAddCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoAddCollectionViewCell")
        }
        
        firstCollectionView.do{
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        }
        
        secondCollectionView.do{
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        }
        
        textView.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.textColor = UIColor(named: "gray20")
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
        }
       
        
        shareButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.setTitle("공유하기", for: .normal)
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
        }
        
        
        
        
        
    }
    
    func layout(){
        
        [backButton,writeChaesoLogLabel,separateFirstView,shareButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardWidth)
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalToSuperview().offset(4*Constants.standardWidth)
            make.top.equalToSuperview().offset(47*Constants.standardHeight)
        }

        writeChaesoLogLabel.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            //make.height.equalTo(5*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(59*Constants.standardHeight)
        }

        separateFirstView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(92*Constants.standardHeight)
        }
        
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.bottom.equalToSuperview().offset(-16*Constants.standardHeight)
        }

        
        [photoAddCollectionView,separateSecondView,firstLabel,firstCollectionView,separateThirdView,secondLabel,secondCollectionView,separateFourthView,textView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        photoAddCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(110*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(separateFirstView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        separateSecondView.snp.makeConstraints { make in
            make.width.equalTo(335*Constants.standardWidth)
            make.height.equalTo(1*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(photoAddCollectionView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(separateSecondView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        firstCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(52*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(firstLabel.snp.bottom).offset(11*Constants.standardHeight)
        }

        separateThirdView.snp.makeConstraints { make in
            make.width.equalTo(335*Constants.standardWidth)
            make.height.equalTo(1*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(firstCollectionView.snp.bottom).offset(16*Constants.standardHeight)
        }

        secondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(separateThirdView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        secondCollectionView.snp.makeConstraints { make in
            make.width.equalTo((view.frame.size.width-32)*Constants.standardWidth)
            make.height.equalTo(52*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(secondLabel.snp.bottom).offset(11*Constants.standardHeight)
        }
        
        separateFourthView.snp.makeConstraints { make in
            make.width.equalTo(335*Constants.standardWidth)
            make.height.equalTo(1*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(secondCollectionView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        textView.snp.makeConstraints { make in
            make.width.equalTo(335*Constants.standardWidth)
            make.height.equalTo(200*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(separateFourthView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        
        
    }
}

extension WriteChaesoLogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var items = writeChaesoLogViewModel.firstItems.value
        if collectionView == firstCollectionView {
            items = writeChaesoLogViewModel.firstItems.value
        } else if collectionView == secondCollectionView {
            items = writeChaesoLogViewModel.secondItems.value
        } else {
            return CGSize(width: 0, height: 0)
        }
        guard indexPath.item < items.count else {
            return CGSize(width: 0, height: 0)
        }
        
        let text = items[indexPath.item]
        let font = UIFont(name: "Pretendard-Medium", size: 14)
        
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let width = textSize.width + 16 * 2 * Constants.standardWidth  // 좌우 패딩
        let height = textSize.height + 8 * 2 * Constants.standardHeight // 상하 패딩
        
        return CGSize(width: width, height: height-2)
    }
}



//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        WriteReviewViewController(writeReviewViewModel: WriteReviewViewModel(localizationManager: LocalizationManager.shared))
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
