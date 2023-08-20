import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources
import Then

class SortTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    var sortTableViewModel: SortTableViewModel?
    
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
    })
    private let secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.sectionInset = UIEdgeInsets(top: $0.sectionInset.top, left: 0, bottom: $0.sectionInset.bottom, right: $0.sectionInset.right)

        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
    })
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor(hexCode: "F5F5F5")
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(sortTableViewModel: SortTableViewModel){
        self.sortTableViewModel = sortTableViewModel
        firstCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        sortTableViewModel.firstItems
            .bind(to: firstCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        sortTableViewModel.firstSelectedIndexPath
                .bind(to: firstCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        firstCollectionView.rx.itemSelected
            .bind(to: sortTableViewModel.firstSelectedIndexPath)
            .disposed(by: disposeBag)
        
        secondCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        sortTableViewModel.secondItems
            .bind(to: secondCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        sortTableViewModel.secondSelectedIndexPath
                .bind(to: secondCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        secondCollectionView.rx.itemSelected
            .bind(to: sortTableViewModel.secondSelectedIndexPath)
            .disposed(by: disposeBag)

    }
    
    func attribute(){
        firstLabel.do{
            $0.font = UIFont(name: "Pretendard-Regular", size: 16)
            $0.text = "채식타입"
        }
        
        secondLabel.do{
            $0.font = UIFont(name: "Pretendard-Regular", size: 16)
            $0.text = "일행"
        }
        
        [firstCollectionView,secondCollectionView].forEach{
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        }
    }
    
    func layout(){
        [firstLabel,secondLabel,firstCollectionView,secondCollectionView]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(15*Constants.standardHeight)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(firstLabel.snp.bottom).offset(24*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-16*Constants.standardHeight)
        }
        
        firstCollectionView.snp.makeConstraints { make in
            make.width.equalTo(350*Constants.standardWidth)
            make.height.equalTo(38*Constants.standardHeight)
            //make.leading.equalToSuperview().offset(100*Constants.standardWidth)
            make.leading.equalTo(firstLabel.snp.trailing).offset(30*Constants.standardWidth)
            make.centerY.equalTo(firstLabel)
            //make.top.equalToSuperview().offset(7*Constants.standardHeight)
        }
        
        secondCollectionView.snp.makeConstraints { make in
            make.width.equalTo(250*Constants.standardWidth)
            make.height.equalTo(38*Constants.standardHeight)
            //make.leading.equalToSuperview().offset(100*Constants.standardWidth)
            make.leading.equalTo(firstCollectionView.snp.leading)
            make.centerY.equalTo(secondLabel)
            //make.top.equalTo(firstCollectionView.snp.bottom).offset(8*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-16*Constants.standardHeight)
        }
        
    }

}

extension SortTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var items = sortTableViewModel!.firstItems.value
        if collectionView == firstCollectionView {
            items = sortTableViewModel!.firstItems.value
        } else if collectionView == secondCollectionView {
            items = sortTableViewModel!.secondItems.value
        } else {
            return CGSize(width: 0, height: 0)
        }
        guard indexPath.item < items.count else {
            return CGSize(width: 0, height: 0)
        }
        
        let text = items[indexPath.item]
        let font = UIFont(name: "Pretendard-Medium", size: 16)
        
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let width = textSize.width + 16 * 2 * Constants.standardWidth  // 좌우 패딩
        let height = textSize.height + 8 * 2 * Constants.standardHeight // 상하 패딩
        
        return CGSize(width: width, height: height-2)
    }
}

//#if DEBUG
//import SwiftUI
//
//struct TableViewCellPreview: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> UITableViewCell {
//        // 여기에서 원하는 테이블뷰 셀을 생성 및 구성하십시오.
//        let cell = SortTableViewCell()
//
//        // 추가적인 셀 구성 ...
//        return cell
//    }
//
//    func updateUIView(_ uiView: UITableViewCell, context: Context) {
//        // 셀 업데이트는 필요에 따라 구현
//    }
//}
//
//struct TableViewCellPreviewProvider: PreviewProvider {
//    static var previews: some View {
//        TableViewCellPreview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//
//        TableViewCellPreview()
//            .previewLayout(.sizeThatFits)
//            .frame(height: 253) // 셀의 높이를 설정
//    }
//}
//#endif
