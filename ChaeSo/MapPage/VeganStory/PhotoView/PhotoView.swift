import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Kingfisher

class PhotoView: UIView {
    let disposeBag = DisposeBag()
    
    let aa = UIImageView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hexCode: "F5F5F5")
        
        let url = URL(string: "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230420_23%2F1681970614736W2ROG_JPEG%2F%25B1%25B8%25BC%25AE_%25BA%25CE%25BB%25EA%25BF%25C0%25BA%25FC_%25B1%25A4%25B0%25ED%25C3%25D4%25BF%25B5%25BF%25EB_%25BB%25E7%25C1%25F8_%25281%2529.jpg")
        aa.kf.setImage(with: url)
        print(aa.image)

        
        addSubview(aa)
        aa.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        //aa.backgroundColor = .red
        
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
        
    }
    
    private func layout(){
       
    }
    
}
