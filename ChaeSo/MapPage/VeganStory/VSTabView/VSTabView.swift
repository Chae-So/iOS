import UIKit
import RxCocoa
import RxSwift
import SnapKit

class VSTabView: UIView {
    private lazy var tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let leftActiveTabIndicator = UIView()
    private let centerActiveTabIndicator = UIView()
    private let rightActiveTabIndicator = UIView()
    private let infoView = InfoView()
    private let menuView = MenuView()
    private let reviewView = ReviewView()
    private let vsTabViewModel: VSTabViewModel
    private let disposeBag = DisposeBag()

    init(vsTabViewModel: VSTabViewModel) {
        self.vsTabViewModel = vsTabViewModel
        super.init(frame: .zero)
        bind()
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        vsTabViewModel.tabItems
            .bind(to: tabCollectionView.rx.items(cellIdentifier: "VSTabCell", cellType: VSTabCell.self)) { row, element, cell in
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
                    self.showInfoView()
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    self.centerActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    
                case 1:
                    self.showMenuView()
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    self.centerActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    
                case 2:
                    self.showReviewView()
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    self.centerActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func attribute(){
        backgroundColor = UIColor(hexCode: "F5F5F5")
        
        //MARK: tabCollectionView attribute
        if let layout = tabCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: 44 * Constants.standardHeight)
            
            layout.minimumInteritemSpacing = 0 // 아이템 간의 최소 간격
            layout.minimumLineSpacing = 0      // 줄 간의 최소 간격
        }
        tabCollectionView.backgroundColor = .white
        tabCollectionView.showsHorizontalScrollIndicator = false
        tabCollectionView.register(VSTabCell.self, forCellWithReuseIdentifier: "VSTabCell")
        
        //MARK: ActiveTabIndicator attribute
        leftActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
        centerActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
        rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")

        //MARK: Info,Menu,Review attribute
        self.infoView.isHidden = true
        self.menuView.isHidden = true
        self.reviewView.isHidden = true
        
    }
    
    func layout(){
        [tabCollectionView,leftActiveTabIndicator,centerActiveTabIndicator,rightActiveTabIndicator,infoView,menuView,reviewView]
            .forEach { UIView in
                addSubview(UIView)
            }
        
        tabCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        leftActiveTabIndicator.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.0/3.0)
            make.height.equalTo(2*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        centerActiveTabIndicator.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.0/3.0)
            make.height.equalTo(2*Constants.standardHeight)
            make.leading.equalTo(leftActiveTabIndicator.snp.trailing)
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        rightActiveTabIndicator.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.0/3.0)
            make.height.equalTo(2*Constants.standardHeight)
            make.trailing.equalToSuperview()
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        infoView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            //make.height.equalTo(44*Constants.standardHeight)
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(leftActiveTabIndicator.snp.bottom)
        }
        
        menuView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            //make.height.equalTo(44*Constants.standardHeight)
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(leftActiveTabIndicator.snp.bottom)
        }
        
        reviewView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            //make.height.equalTo(44*Constants.standardHeight)
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(leftActiveTabIndicator.snp.bottom)
        }
        
        
        
    }


    private func showInfoView() {
        // Animate the transition to show the PlaceView and hide the ChaesoLogView
        UIView.animate(withDuration: 0.3) {
            self.infoView.isHidden = false
            self.menuView.isHidden = true
            self.reviewView.isHidden = true
        }
    }

    private func showMenuView() {
        // Animate the transition to show the ChaesoLogView and hide the PlaceView
        UIView.animate(withDuration: 0.3) {
            self.infoView.isHidden = true
            self.menuView.isHidden = false
            self.reviewView.isHidden = true
        }
    }

    private func showReviewView() {
        // Animate the transition to show the PlaceView and hide the ChaesoLogView
        UIView.animate(withDuration: 0.3) {
            self.infoView.isHidden = true
            self.menuView.isHidden = true
            self.reviewView.isHidden = false
        }
    }
    
    
    
}
