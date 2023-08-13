import UIKit
import RxSwift
import RxCocoa
import SnapKit


class PhotoTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    var writeChaesoLogViewModel: WriteChaesoLogViewModel!
    var photoTableViewCellViewModel = PhotoTableViewCellViewModel()
    
    let photoAddCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 100 * Constants.standardHeight, height: 100 * Constants.standardHeight)
        $0.minimumInteritemSpacing = 8
    }).then{
        $0.isPagingEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = UIColor(hexCode: "F5F5F5")
        $0.register(PhotoAddFirstCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoAddFirstCollectionViewCell")
        $0.register(PhotoAddCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoAddCollectionViewCell")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bind()
        
        
        photoAddCollectionView.backgroundColor = .brown
        contentView.addSubview(photoAddCollectionView)
        photoAddCollectionView.snp.makeConstraints { make in
            make.width.equalTo(359*Constants.standardWidth)
            make.height.equalTo(101*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(15*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(15*Constants.standardHeight)
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        
        photoTableViewCellViewModel.selectedPhotosRelay
            .subscribe(onNext: {_ in
                print(123)
            })
            .disposed(by: self.disposeBag)
        
        photoTableViewCellViewModel.selectedPhotosRelay
            .map { [UIImage(named: "tomato")!] + $0 }
            .bind(to: photoAddCollectionView.rx.items) { (collectionView, index, image) -> UICollectionViewCell in
                if index == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddFirstCollectionViewCell", for: IndexPath(row: index, section: 0)) as! PhotoAddFirstCollectionViewCell
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddCollectionViewCell", for: IndexPath(row: index, section: 0)) as! PhotoAddCollectionViewCell
                    cell.photoImage.image = image
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        
        photoAddCollectionView.rx.itemSelected
            .subscribe(onNext: {[weak self] aaa in
                guard let self = self else {return}
                self.writeChaesoLogViewModel.showMainPTCollection.onNext(())
            })
            

        
        
    }
    
    
}
