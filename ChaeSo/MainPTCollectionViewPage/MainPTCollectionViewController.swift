import UIKit
import PhotosUI
import RxSwift
import RxCocoa
import Then
import SnapKit

class MainPTCollectionViewController: UIViewController {
    
    private let mainPTCollectionViewModel: MainPTCollectionViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var cancelButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var doneButton = UIButton()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 3) / 4  // 2는 셀 간 간격이므로 총 2번 고려해야 합니다.
        $0.itemSize = CGSize(width: cellWidth, height: cellWidth)
        $0.minimumLineSpacing = 1
        $0.minimumInteritemSpacing = 1
    })
    var selectedPhotoAssets: [PHAsset] = []
    var previousSelectedIndexPath: IndexPath?
    var type = ""
    var status = ""
    
    
    init(mainPTCollectionViewModel: MainPTCollectionViewModel) {
        self.mainPTCollectionViewModel = mainPTCollectionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if status == "limited"{
            showPickerAlert()
        }
    }
    
    
    private func attribute(){
        
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        cancelButton.do{
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .black
            $0.imageView?.contentMode = .scaleToFill
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
        }
        
        titleLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.text = "사진고르기"
        }
        
        
        doneButton.do{
            $0.setTitle("완료", for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.layer.cornerRadius = 8
        }
        
        collectionView.do {
            $0.register(MainPTCollectionVewCell.self, forCellWithReuseIdentifier: "MainPTCollectionVewCell")
        }
    }
    
    private func layout() {
        [cancelButton,titleLabel,doneButton,collectionView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardWidth)
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(44*Constants.standardHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            //make.width.equalTo(44*Constants.standardWidth)
            make.height.equalTo(26*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(53*Constants.standardHeight)
        }
        
        doneButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardWidth)
            make.height.equalTo(44*Constants.standardHeight)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(44*Constants.standardHeight)
        }
        
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    
    
    private func bind() {
        
        mainPTCollectionViewModel.viewTypeRelay.accept(type)
        
        mainPTCollectionViewModel.alertAction
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                guard let self = self else { return }
                self.status = status
            })
            .disposed(by: disposeBag)
        
        
        
        mainPTCollectionViewModel.checkPhotoPermissionAndLoad()
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .bind(to: mainPTCollectionViewModel.doneButtonTapped)
            .disposed(by: disposeBag)

        
        mainPTCollectionViewModel.selectedPhotos
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        
        
        mainPTCollectionViewModel.selectedAssets
            .bind(to: collectionView.rx.items(cellIdentifier: "MainPTCollectionVewCell", cellType: MainPTCollectionVewCell.self)) { index, model, cell in
                cell.asset = model
                if let order = self.mainPTCollectionViewModel.getOrder(of: IndexPath(item: index, section: 0)) {
                    cell.updateSelection(isSelected: true, order: order)
                } else {
                    cell.updateSelection(isSelected: false)
                }
            }
            .disposed(by: disposeBag)
        
        if type == "nickname" {
            collectionView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    guard let cell = self?.collectionView.cellForItem(at: indexPath) as? MainPTCollectionVewCell else { return }
                    cell.onlyOneUpdateSelection(isSelected: true)
                    
                    if let previousSelectedIndexPath = self?.previousSelectedIndexPath, previousSelectedIndexPath != indexPath {
                        guard let previousCell = self?.collectionView.cellForItem(at: previousSelectedIndexPath) as? MainPTCollectionVewCell else { return }
                        previousCell.onlyOneUpdateSelection(isSelected: false)
                    }
                    self?.previousSelectedIndexPath = indexPath
                    self?.mainPTCollectionViewModel.selectItem(at: (self?.previousSelectedIndexPath!)!)
                })
                .disposed(by: disposeBag)
        }
        else {
            collectionView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    self?.mainPTCollectionViewModel.selectItem(at: indexPath)
                    // 갱신된 순서로 모든 셀을 업데이트합니다.
                    let updatedIndexPaths = self?.mainPTCollectionViewModel.selectedIndexArray.map { IndexPath(item: $0, section: 0) } ?? []
                    self?.collectionView.reloadItems(at: updatedIndexPaths + [indexPath])
                })
                .disposed(by: disposeBag)
        }

        
    }
    
    private func showPickerAlert() {
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
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
