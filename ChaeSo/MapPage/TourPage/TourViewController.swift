import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class TourViewController: UIViewController {
    let disposeBag = DisposeBag()
    var tourViewModel: TourViewModel

    
    let leftButton = UIButton()
    lazy var titleLabel = UILabel()
    lazy var firstSeparateView = UIView()
    lazy var tourImageView = UIImageView()
    lazy var infoLabel = UILabel()
    lazy var secondSeparateView = UIView()
    lazy var tableView = UITableView()
    
    init(tourViewModel: TourViewModel) {
        self.tourViewModel = tourViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        layout()
    }
    
    private func bind(){
        leftButton.rx.tap
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        
        tourViewModel.placeMain
            .subscribe(onNext: { [weak self] mainData in
                self?.titleLabel.text = mainData.first
                if let url = URL(string: mainData.last!) {
                    self?.tourImageView.kf.setImage(with: url)
                }
            })
            .disposed(by: disposeBag)
        
        tourViewModel.infoText
            .bind(to: infoLabel.rx.text)
            .disposed(by: disposeBag)
        
        tourViewModel.placeData
            .bind(to: tableView.rx.items) { [weak self] tableView, index, item in
                switch item {
                case .facilities(let toilet, let parking):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTourTableViewCell") as! FirstTourTableViewCell
                    cell.configure(tourViewModel: self!.tourViewModel)
                    cell.configure(toilet: toilet, parking: parking)
                    return cell
                    
                case .addr(let addr, let image):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTourTableViewCell") as! SecondTourTableViewCell
                    cell.configure(a: addr, b: image)
                    return cell
                    
                case .tel(let tel, let image):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTourTableViewCell") as! SecondTourTableViewCell
                    cell.configure(a: tel, b: image)
                    return cell
                    
                case .content(let content):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTourTableViewCell") as! ThirdTourTableViewCell
                    cell.configure(content: content)
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    private func attribute(){
        view.backgroundColor = .white
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)

        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 20*Constants.standartFont)
        
        [firstSeparateView,secondSeparateView]
            .forEach{ $0.backgroundColor = UIColor(named: "gray10") }
        secondSeparateView.backgroundColor = UIColor(named: "prColor")
        
        
        infoLabel.font = UIFont(name: "Pretendard-Medium", size: 13*Constants.standartFont)
        
        tableView.do{
            $0.separatorStyle = .singleLine
            $0.separatorInset = UIEdgeInsets(top: 0, left: 16*Constants.standardWidth, bottom: 0, right: 16*Constants.standardWidth)
            $0.separatorColor = UIColor(named: "gray10")
            $0.register(FirstTourTableViewCell.self, forCellReuseIdentifier: "FirstTourTableViewCell")
            $0.register(SecondTourTableViewCell.self, forCellReuseIdentifier: "SecondTourTableViewCell")
            $0.register(ThirdTourTableViewCell.self, forCellReuseIdentifier: "ThirdTourTableViewCell")
        }
    }
    
    private func layout(){
        [leftButton,titleLabel,firstSeparateView,tourImageView,infoLabel,secondSeparateView,tableView]
            .forEach{ view.addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45*Constants.standardWidth)
            make.top.equalToSuperview().offset(56*Constants.standardHeight)
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(10*Constants.standardWidth)
            make.centerY.equalTo(titleLabel)
        }
        
        firstSeparateView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(12*Constants.standardHeight)
        }
        
        tourImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(249*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(firstSeparateView.snp.bottom)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tourImageView.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        secondSeparateView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(2*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(secondSeparateView.snp.bottom)
            make.bottom.equalToSuperview().offset(-Constants.tabBarHeight*Constants.standardHeight)
        }

    }
    
}
