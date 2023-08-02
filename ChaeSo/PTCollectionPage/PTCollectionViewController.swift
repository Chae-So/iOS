import UIKit
import PhotosUI
import Photos
import RxSwift
import RxCocoa

class PTCollectionViewController: UIViewController, PHPhotoLibraryChangeObserver {

    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // 현재 선택된 사진들의 PHAsset 가져오기
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        fetchOptions.includeAssetSourceTypes = [.typeUserLibrary]
        let assets = PHAsset.fetchAssets(with: fetchOptions)
        
        var updatedAssets: [PHAsset] = []
        assets.enumerateObjects { (asset, _, _) in
            updatedAssets.append(asset)
        }
        
        // 선택된 사진들을 selectedAssets Relay에 업데이트하고 저장합니다.
        ptCollectionViewModel.selectedAssets.accept(updatedAssets)
        ptCollectionViewModel.saveSelectedAssetsIdentifiers(assets: updatedAssets)
    }

    
    
    private let ptCollectionViewModel: PTCollectionViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var cancelButton = UIButton()
    private lazy var addButton = UIButton()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    init(ptCollectionViewModel: PTCollectionViewModel) {
        
        self.ptCollectionViewModel = ptCollectionViewModel

        super.init(nibName: nil, bundle: nil)
        PHPhotoLibrary.shared().register(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPickerAlert()
    }
    
    func attribute(){
        
        view.backgroundColor = .white
        
        cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelButton.imageView?.contentMode = .scaleToFill
        
        //MARK: addButton attribute
        addButton.titleLabel?.textAlignment = .center
        addButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        addButton.tintColor = .white
        addButton.backgroundColor = UIColor(named: "prColor")
        addButton.layer.cornerRadius = 8
        addButton.setTitle("추가", for: .normal)
        
        // Set up collection view layout
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 3) / 4  // 2는 셀 간 간격이므로 총 2번 고려해야 합니다.
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        // Register collection view cell
        collectionView.register(PTCollectionViewCell.self, forCellWithReuseIdentifier: "PTCollectionViewCell")
    }
    
    private func layout() {
        [cancelButton,addButton,collectionView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(50*Constants.standardWidth)
            make.height.equalTo(40*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16*Constants.standardHeight)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(60*Constants.standardWidth)
            make.height.equalTo(40*Constants.standardHeight)
            make.trailing.equalToSuperview().offset(-16*Constants.standardWidth)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16*Constants.standardHeight)        }
        
        // Set up collection view constraints with SnapKit
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100*Constants.standardHeight)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    
    
    private func bind() {
        
        ptCollectionViewModel.loadSelectedAssets()
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .flatMapLatest { [weak self] _ -> Observable<UIImage?> in
                guard let self = self else { return Observable.just(nil) }
                
                if let selectedIndexPaths = self.collectionView.indexPathsForSelectedItems, !selectedIndexPaths.isEmpty {
                    let asset = self.ptCollectionViewModel.selectedAssets.value[selectedIndexPaths[0].row]
                    return Observable.just(self.getImage(from: asset))
                }
                
                return Observable.just(nil)
            }
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] Image in
                guard let self = self else { return }
                self.dismiss(animated: true) { [weak self] in
                    guard let self = self else { return }
                    print("About to send image to selectedImageRelay")
                    self.ptCollectionViewModel.selectedImageRelay.accept(Image)
                }
            })
            .disposed(by: disposeBag)
        
        
        ptCollectionViewModel.selectedAssets
            .bind(to: collectionView.rx.items(cellIdentifier: "PTCollectionViewCell", cellType: PTCollectionViewCell.self)) { index, model, cell in
                cell.asset = model
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map{ _ in true }
            .asDriver(onErrorDriveWith: .empty())
            .drive(addButton.rx.isEnabled)
            .disposed(by: disposeBag)

        // 아이템 선택 시
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell = self?.collectionView.cellForItem(at: indexPath) as? PTCollectionViewCell else { return }
                cell.updateSelectionState(isSelected: true)
            })
            .disposed(by: disposeBag)
        
        // 아이템 선택 취소 시
        collectionView.rx.itemDeselected
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell = self?.collectionView.cellForItem(at: indexPath) as? PTCollectionViewCell else { return }
                cell.updateSelectionState(isSelected: false)
            })
            .disposed(by: disposeBag)

        
        
        
    }
    
    private func showPickerAlert() {
        print("showPickerAlert")
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "더 많은 사진 선택", style: .default, handler: { _ in
            PHPhotoLibrary.requestAuthorization(for: .readWrite){ status in
                if status == .limited{
                    
                    PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
                    
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "현재 선택 항목 유지", style: .cancel))
        //alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        //print(13)
        present(alert, animated: true, completion: nil)
    }
    
    func getImage(from asset: PHAsset) -> UIImage? {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image: UIImage?
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
            image = result
        })
        return image
    }

}
