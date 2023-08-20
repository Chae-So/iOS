import UIKit
import RxCocoa
import RxSwift
import SnapKit

class VSTabView: UIView {
    private lazy var tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let leftActiveTabIndicator = UIView()
    private let centerActiveTabIndicator = UIView()
    private let rightActiveTabIndicator = UIView()
    private let infoView = InfoView(infoViewModel: InfoViewModel())
    private let menuView = MenuView(menuViewModel: MenuViewModel())
    private let reviewView = ReviewView(reviewViewModel: ReviewViewModel(localizationManager: LocalizationManager.shared))
    private let vsTabViewModel: VSTabViewModel
    private let disposeBag = DisposeBag()
    let presentWriteReviewRelay = PublishRelay<Void>()

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
        reviewView.presentWriteReviewRelay
                .bind(to: presentWriteReviewRelay)
                .disposed(by: disposeBag)
        
        vsTabViewModel.tabItems
            .bind(to: tabCollectionView.rx.items(cellIdentifier: "VSTabCell", cellType: VSTabCell.self)) { row, element, cell in
                cell.titleLabel.text = element
                switch row{
                case 0: cell.titleLabel.textColor = .black
                case 1: cell.titleLabel.textColor = UIColor(named: "gray20")
                case 2: cell.titleLabel.textColor = UIColor(named: "gray20")
                default: break
                }
            }
            .disposed(by: disposeBag)
        

        tabCollectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .map { $0.row }
            .subscribe(onNext: { [weak self] selectedIndex in
                self?.updateViews(for: selectedIndex)
            })
            .disposed(by: disposeBag)

        
        
        vsTabViewModel.selectedIndexPath
                .bind(to: tabCollectionView.rx.updateSelectedCellTextColor)
                .disposed(by: disposeBag)
        
        tabCollectionView.rx.itemSelected
            .bind(to: vsTabViewModel.selectedIndexPath)
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
        self.infoView.isHidden = false
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
    
    private func updateViews(for index: Int) {
        infoView.isHidden = index != 0
        menuView.isHidden = index != 1
        reviewView.isHidden = index != 2

        let color = UIColor(named: "prColor")
        let grayColor = UIColor(named: "gray10")
        
        leftActiveTabIndicator.backgroundColor = index == 0 ? color : grayColor
        centerActiveTabIndicator.backgroundColor = index == 1 ? color : grayColor
        rightActiveTabIndicator.backgroundColor = index == 2 ? color : grayColor

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
}
