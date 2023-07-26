import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BookmarkView: UIView {
    private lazy var tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let leftActiveTabIndicator = UIView()
    private let rightActiveTabIndicator = UIView()
    private let placeView = PlaceView(placeViewModel: PlaceViewModel(localizationManager: LocalizationManager.shared))
    private let chaesoLogView = ChaesoLogView()
    private let bookmarkViewModel: BookmarkViewModel
    private let disposeBag = DisposeBag()

    init(bookmarkViewModel: BookmarkViewModel) {
        self.bookmarkViewModel = bookmarkViewModel
        super.init(frame: .zero)
        bind()
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        bookmarkViewModel.tabItems
            .bind(to: tabCollectionView.rx.items(cellIdentifier: "TabCell", cellType: TabCell.self)) { row, element, cell in
                cell.titleLabel.text = element
                print(element)
            }
            .disposed(by: disposeBag)
        

        // Handle tab selection and animate the views accordingly
        tabCollectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                switch indexPath.row {
                case 0:  // "장소"
                    self.showPlaceView()
                    print("장소클릭")
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    
                case 1:  // "채소로그"
                    self.showChaesoLogView()
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func attribute(){
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
        tabCollectionView.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
        
        //MARK: ActiveTabIndicator attribute
        leftActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
        rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")

    }
    
    func layout(){
        [tabCollectionView,leftActiveTabIndicator,rightActiveTabIndicator,placeView,chaesoLogView]
            .forEach { UIView in
                addSubview(UIView)
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
        
        placeView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(leftActiveTabIndicator.snp.bottom)
        }
        
        
    }


    private func showPlaceView() {
        // Animate the transition to show the PlaceView and hide the ChaesoLogView
        UIView.animate(withDuration: 0.3) {
            self.placeView.isHidden = false
            self.chaesoLogView.isHidden = true
            // Update the activeTabIndicator's position if necessary
        }
    }

    private func showChaesoLogView() {
        // Animate the transition to show the ChaesoLogView and hide the PlaceView
        UIView.animate(withDuration: 0.3) {
            self.placeView.isHidden = true
            self.chaesoLogView.isHidden = false
            // Update the activeTabIndicator's position if necessary
        }
    }
}
