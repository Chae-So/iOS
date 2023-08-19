import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class InfoView: UIView {
    let disposeBag = DisposeBag()
    var infoViewModel: InfoViewModel
    
    let tableView = UITableView()
    private let dataSource: RxTableViewSectionedReloadDataSource<TableViewSection> = {
        return RxTableViewSectionedReloadDataSource<TableViewSection>(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath.section] {
            case .sectionA:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FirstInfoTableViewCell", for: indexPath) as! FirstInfoTableViewCell
                cell.configure(with: item as! ItemA)
                return cell

            case .sectionB:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SecondInfoTableViewCell", for: indexPath) as! SecondInfoTableViewCell
                cell.configure(with: item as! ItemB)
                return cell

            case .sectionC(_, let items):
                let cell = tableView.dequeueReusableCell(withIdentifier: "FourthInfoTableViewCell", for: indexPath) as! FourthInfoTableViewCell
                cell.configure(with: item as! ItemC)
                return cell
            }
        })
    }()
    
    init(infoViewModel: InfoViewModel) {
        self.infoViewModel = infoViewModel
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
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        infoViewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    private func attribute(){
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16*Constants.standardWidth, bottom: 0, right: 16*Constants.standardWidth)
        tableView.separatorColor = UIColor(named: "gray10")
        tableView.register(FirstInfoTableViewCell.self, forCellReuseIdentifier: "FirstInfoTableViewCell")
        tableView.register(SecondInfoTableViewCell.self, forCellReuseIdentifier: "SecondInfoTableViewCell")
        tableView.register(InfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "InfoHeaderView")
        tableView.register(FourthInfoTableViewCell.self, forCellReuseIdentifier: "FourthInfoTableViewCell")
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.sectionFooterHeight = 0
        //tableView.sectionHeaderHeight = 0
        tableView.sectionHeaderTopPadding = 1
    }
    
    private func layout(){
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
}

extension InfoView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 3){
            return UITableView.automaticDimension
        }
        return 44.0 * Constants.standardHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch dataSource[section] {
        case .sectionC(let header, _):
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "InfoHeaderView") as! InfoHeaderView
            headerView.configure(with: header)
            headerView.toggleAction = infoViewModel.toggleSection3
            return headerView
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .sectionC:
            return 44.0 * Constants.standardHeight
        default:
            return 0.0
        }
    }
}
