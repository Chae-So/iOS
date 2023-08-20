import RxSwift
import RxCocoa

class ReviewViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let photoReviewTableViewModel = PhotoReviewTableViewModel()
//    let sortTableViewModel = SortTableViewModel(localizationManager: LocalizationManager.shared)
    
    let writeReviewText = BehaviorRelay<String>(value: "")
    let viewPhotoReviewsText = BehaviorRelay<String>(value: "")
    let followText = BehaviorRelay<String>(value: "")
    
    let cellData = Driver<[[Any]]>.just([
        ["a"],
        [[UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato")]],
        ["b"],
        [
            ReviewList(userImage: UIImage(named: "tomato")!, userName: "villa", starPoint: "5", userType: "비건", withType: "친구와", otherType: "", reviewImages: [UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!], content: "dfsgfsgfdsdfsgdf  asfsdkfshd kksd fksdh kkadjsk dshkh dhka skhasdh kj sdhjhsdk khasdkhfksfjksdhfkjsdh ajkfhsd khshlkjf hlkafkjasd lsdfkdsbj dshf sd fsdk ksdjfweukoqlwoi;qwo elhf dk,j xc dkl"),
            ReviewList(userImage: UIImage(named: "tomato")!, userName: "fdhg", starPoint: "4", userType: "오보", withType: "친구와", otherType: "오보", reviewImages: [UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!], content: "dfsgfsgfdsdfsgdf  asfsdkfshd kksd fksdh kkadjsk dshkh dhka skhasdh kj sdhjhsdk khasdkhfksfjksdhfkjsdh ajkfhsd khshlkjf hlkafkjasd lsdfkdsbj dshf sd fsdk ksdjfweukoqlwoi;qwo elhf dk,j xc dkl"),
            ReviewList(userImage: UIImage(named: "tomato")!, userName: "rtutyr", starPoint: "3", userType: "비건", withType: "친구와", otherType: "nil", reviewImages: [UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!], content: "dfsgfsgfdsdfsgdf  asfsdkfshd kksd fksdh kkadjsk dshkh dhka skhasdh kj sdhjhsdk khasdkhfksfjksdhfkjsdh ajkfhsd khshlkjf hlkafkjasd lsdfkdsbj dshf sd fsdk ksdjfweukoqlwoi;qwo elhf dk,j xc dkl")
        ]
    ])
    
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
 
        //photoReviewTableViewModel.images.accept([UIImage(named: "tomato")!, UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!])
        
    }
    
    private func updateLocalization() {
        writeReviewText.accept(localizationManager.localizedString(forKey: "Write review"))
        viewPhotoReviewsText.accept(localizationManager.localizedString(forKey: "View photo reviews"))
        followText.accept(localizationManager.localizedString(forKey: "Follow"))
    }

}

