import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ReviewView: UIView {

    private let disposeBag = DisposeBag()
    private let reviewTableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        
        bind()
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        
    }
    
    private func attribute(){
        
        //reviewTableView.tableFooterView = UIView()
        reviewTableView.separatorStyle = .singleLine
        reviewTableView.separatorInset = UIEdgeInsets(top: 0, left: 16*Constants.standardWidth, bottom: 0, right: 16*Constants.standardWidth)
        reviewTableView.separatorColor = UIColor(hexCode: "D9D9D9")
        reviewTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
    }
    
    private func layout(){
        addSubview(reviewTableView)
        
        reviewTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
}
