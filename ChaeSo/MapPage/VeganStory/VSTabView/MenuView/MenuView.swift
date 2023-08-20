import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class MenuView: UIView {
    let disposeBag = DisposeBag()
    var menuViewModel: MenuViewModel
    
    let tableView = UITableView()
    
    init(menuViewModel: MenuViewModel) {
        self.menuViewModel = menuViewModel
        super.init(frame: .zero)
        backgroundColor = UIColor(hexCode: "F5F5F5")
        
        bind()
        attribute()
        layout()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        
        menuViewModel.menuList
            .bind(to: tableView.rx.items(cellIdentifier: "MenuTableViewCell", cellType: MenuTableViewCell.self)){ [weak self] (row, element, cell) in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func attribute(){
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16*Constants.standardWidth, bottom: 0, right: 16*Constants.standardWidth)
        tableView.separatorColor = UIColor(named: "gray10")
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    private func layout(){
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
}

