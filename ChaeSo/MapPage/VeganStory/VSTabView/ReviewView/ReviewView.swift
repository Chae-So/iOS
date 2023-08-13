import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import SnapKit

class ReviewView: UIView {

    private var disposeBag = DisposeBag()
    var reviewViewModel: ReviewViewModel
    
    private let reviewTableView = UITableView()
    let presentWriteReviewRelay = PublishRelay<Void>()
    
    init(reviewViewModel: ReviewViewModel) {
        self.reviewViewModel = reviewViewModel
        super.init(frame: .zero)
        
        bind()
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bind(){
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
                    configureCell: { dataSource, table, indexPath, item in
                        switch indexPath.section {
                        case 0:
                            guard let cell = table.dequeueReusableCell(withIdentifier: "RatingTableViewCell") as? RatingTableViewCell else {
                                fatalError("Cannot dequeue RatingTableViewCell")
                            }
                            cell.writeReviewButtonTapped
                                .subscribe(onNext: { [weak self] in
                                    guard let self = self else { return }
                                    print("Button tapped event received in ReviewView")
                                    self.presentWriteReviewRelay.accept(())
                                })
                                .disposed(by: cell.disposeBag)
                            
                            return cell

                        default:
                            fatalError("Unknown section")
                        }
                    }
                )
        
        reviewViewModel.cellData
            .map { sections in
                return [
                    SectionModel(model: "A", items: sections[0])
                ]
            }
            .drive(reviewTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    private func attribute(){
        backgroundColor = UIColor(hexCode: "F5F5F5")
        
        reviewTableView.separatorStyle = .singleLine
        reviewTableView.separatorInset = UIEdgeInsets(top: 0, left: 16*Constants.standardWidth, bottom: 0, right: 16*Constants.standardWidth)
        reviewTableView.separatorColor = UIColor(hexCode: "D9D9D9")
        reviewTableView.register(RatingTableViewCell.self, forCellReuseIdentifier: "RatingTableViewCell")
        reviewTableView.register(PhotoReviewTableViewCell.self, forCellReuseIdentifier: "PhotoReviewTableViewCell")
        reviewTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func layout(){
        addSubview(reviewTableView)
        
        reviewTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
}

