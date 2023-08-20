import RxSwift
import RxCocoa

class InfoViewModel{
    let sections = BehaviorSubject<[TableViewSection]>(value: [])
    
    init() {
        loadInitialData()
    }
    
    func loadInitialData() {
        let currentDayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        let days = ["일요일","월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]
        let currentDay = days[currentDayIndex]
        
        let initialSections: [TableViewSection] = [
            .sectionA(items: [ItemA(first: true, second: false, third: true)]),
            .sectionB(items: [ItemB(image: UIImage(named: "phone")!, text: "010-1234-1234")]),
            .sectionB(items: [ItemB(image: UIImage(named: "loca")!, text: "대한민국 서울")]),
            .sectionC(header: HeaderItem(day: currentDay, time: "09:00", isExpanded: false), items: [])
        ]
        
        sections.onNext(initialSections)
    }
    
    func toggleSection3() {
        guard var currentSections = try? sections.value() else { return }
        
        if case var .sectionC(header, items) = currentSections[3] {
            header.isExpanded.toggle()
            items = header.isExpanded ? [ItemC(monTime: "10:00 ~ 20:00", tueTime: "10:00 ~ 20:00", wedTime: "10:00 ~ 20:00", thuTime: "10:00 ~ 20:00", friTime: "10:00 ~ 20:00", satTime: "10:00 ~ 20:00", sunTime: "휴일")] : []
            currentSections[3] = .sectionC(header: header, items: items)
        }
        
        sections.onNext(currentSections)
    }
}

