import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PhotoReviewTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    let titleLabel = UILabel()
    let photoReviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(photoReviewTableViewModel: PhotoReviewTableViewModel){
        photoReviewTableViewModel.images
            .bind(to: photoReviewCollectionView.rx.items(cellIdentifier: "PhotoReviewCollectionViewCell", cellType: PhotoReviewCollectionViewCell.self)) { row, element, cell in
                cell.photo.image = element
            }
            .disposed(by: disposeBag)
    }
    
    func attribute(){
        backgroundColor = UIColor(hexCode: "F5F5F5")

        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        titleLabel.text = "사진 리뷰 모아보기"

        //MARK: photoCollectionView attribute
        if let layout = photoReviewCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
            layout.itemSize = CGSize(width: 100 * Constants.standardWidth, height: 100 * Constants.standardHeight)
            
            layout.minimumLineSpacing = 8      // 줄 간의 최소 간격
        }
        photoReviewCollectionView.isPagingEnabled = false
        photoReviewCollectionView.showsHorizontalScrollIndicator = false
        photoReviewCollectionView.backgroundColor = UIColor(hexCode: "F5F5F5")
        photoReviewCollectionView.register(PhotoReviewCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoReviewCollectionViewCell")
        
    }
    
    func layout(){
        [titleLabel,photoReviewCollectionView]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        titleLabel.snp.makeConstraints { make in
            //make.width.equalTo(28*Constants.standardWidth)
            //make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(14*Constants.standardHeight)
        }
        
        photoReviewCollectionView.snp.makeConstraints { make in
            make.width.equalTo(359*Constants.standardWidth)
            make.height.equalTo(102*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(titleLabel.snp.bottom).offset(12*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-16*Constants.standardHeight)
        }
        
        
        
    }

}

//#if DEBUG
//import SwiftUI
//
//struct TableViewCellPreview: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> UITableViewCell {
//        // 여기에서 원하는 테이블뷰 셀을 생성 및 구성하십시오.
//        let cell = RatingTableViewCell()
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
