import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CommunityViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let communityViewModel: CommunityViewModel
    
    private let chaesoLogLabel = UILabel()
    private lazy var tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let leftActiveTabIndicator = UIView()
    private let rightActiveTabIndicator = UIView()
    private let contentsTableView = UITableView()
    

    init(communityViewModel: CommunityViewModel) {
        self.communityViewModel = communityViewModel
        super.init(nibName: nil, bundle: nil)
        bind()
        attribute()
        layout()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        communityViewModel.chaesoLogText
            .asDriver(onErrorDriveWith: .empty())
            .drive(chaesoLogLabel.rx.text)
            .disposed(by: disposeBag)
        
        communityViewModel.tabItems
            .bind(to: tabCollectionView.rx.items(cellIdentifier: "BookmarkTabCell", cellType: BookmarkTabCell.self)) { row, element, cell in
                cell.titleLabel.text = element
            }
            .disposed(by: disposeBag)
        

        // Handle tab selection and animate the views accordingly
        tabCollectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                switch indexPath.row {
                case 0:
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    
                case 1:
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func attribute(){
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        //MARK: tabCollectionView attribute
        if let layout = tabCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
            // 컬렉션뷰의 폭을 반으로 나누어서 itemSize를 설정
            let halfWidth = UIScreen.main.bounds.width * 0.5
            layout.itemSize = CGSize(width: halfWidth, height: 39 * Constants.standardHeight) // 여기서 높이는 원하는 높이로 설정
            
            layout.minimumInteritemSpacing = 0 // 아이템 간의 최소 간격
            layout.minimumLineSpacing = 0      // 줄 간의 최소 간격
        }
        tabCollectionView.backgroundColor = .white
        tabCollectionView.showsHorizontalScrollIndicator = false
        tabCollectionView.register(BookmarkTabCell.self, forCellWithReuseIdentifier: "BookmarkTabCell")
        
        //MARK: ActiveTabIndicator attribute
        leftActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
        rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")

    }
    
    func layout(){
        [tabCollectionView,leftActiveTabIndicator,rightActiveTabIndicator,contentsTableView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        tabCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(39*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        leftActiveTabIndicator.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        rightActiveTabIndicator.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(5*Constants.standardHeight)
            make.trailing.equalToSuperview()
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        contentsTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(leftActiveTabIndicator.snp.bottom)
        }
        
        
    }

}

//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        CommunityViewController(communityViewModel: CommunityViewModel(localizationManager: LocalizationManager.shared))
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
