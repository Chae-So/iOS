import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Kingfisher

class DetailListView: UIView {
    private let disposeBag = DisposeBag()
    var detailListViewModel: DetailListViewModel
    
    private let grayView = UIView()
    private let titleLabel = UILabel()
    private let separateView = UIView()
    private lazy var tableView = UITableView()

    init(detailListViewModel: DetailListViewModel) {
        self.detailListViewModel = detailListViewModel
        super.init(frame: .zero)
        
        bind()
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    func bind(){
        detailListViewModel.titleText
            .subscribe(onNext: { aa in
                print(aa,1231232137812638712)
            })
            .disposed(by: disposeBag)
        
        detailListViewModel.titleText
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        

        detailListViewModel.placeList
            .bind(to: tableView.rx.items(cellIdentifier: "TourListTableViewCell", cellType: TourListTableViewCell.self)){ [weak self] (row, element, cell) in
                guard let self = self else {return}
                
                cell.photo.kf.setImage(with: URL(string: element.mainimage))
                cell.nameLabel.text = element.title
                cell.categoryLabel.text = self.titleLabel.text
                cell.pointLabel.text = "4.3 / 5"
                
            }
            .disposed(by: disposeBag)
        
        
    }
    
    func attribute(){
        
        self.layer.cornerRadius = 30
        self.backgroundColor = UIColor(named: "sbgColor")
        
        grayView.do{
            $0.backgroundColor = UIColor(named: "gray10")
        }
        
        titleLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 20)
        }
        
        separateView.do{
            $0.backgroundColor = UIColor(named: "gray10")
        }
        
        tableView.do{
            $0.separatorStyle = .singleLine
            $0.separatorInset = UIEdgeInsets(top: 0, left: 16*Constants.standardWidth, bottom: 0, right: 16*Constants.standardWidth)
            $0.separatorColor = UIColor(named: "gray10")
            $0.register(TourListTableViewCell.self, forCellReuseIdentifier: "TourListTableViewCell")
            $0.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
            $0.rowHeight = 140*Constants.standardHeight
        }
    }
    
    func layout(){
        [grayView,titleLabel,separateView,tableView]
            .forEach { UIView in
                addSubview(UIView)
            }
        
        grayView.snp.makeConstraints { make in
            make.width.equalTo(60*Constants.standardWidth)
            make.height.equalTo(5*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10*Constants.standardHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(17*Constants.standardWidth)
            make.top.equalTo(grayView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        separateView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(separateView.snp.bottom)
        }
        
        
    }

}
