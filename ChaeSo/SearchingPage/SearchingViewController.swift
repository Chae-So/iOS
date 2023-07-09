import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Lottie

class SearchingViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var searchingViewModel: SearchingViewModel!
    
    
    init(searchingViewModel: SearchingViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.searchingViewModel = searchingViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
        
        let animationView = LottieAnimationView(name: "FlowTomato") // AnimationView(name: "lottie json 파일 이름")으로 애니메이션 뷰 생성
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300) // 애니메이션뷰의 크기 설정
        animationView.center = self.view.center // 애니메이션뷰의 위치설정
        animationView.contentMode = .scaleAspectFill // 애니메이션뷰의 콘텐트모드 설정
        
        view.addSubview(animationView) // 애니메이션뷰를 메인뷰에 추가
        animationView.loopMode = .loop
        animationView.play() // 애미메이션뷰 실행
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
    }
    
    func attribute(){
        
    }
    
    func layout(){
        
    }

}
