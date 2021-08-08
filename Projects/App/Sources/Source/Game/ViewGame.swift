import UIKit
import DifferenceKit
import UIComponents

final class GameView: View {
    
    static let cellID = "Cell"
    
    var props: Props!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(PageViewCell.self, forCellWithReuseIdentifier: Self.cellID)
        view.delegate = self
        view.isPagingEnabled = true
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    override func addSubviews() {
        addSubview(collectionView)
    }
    
    override func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension GameView: PropsRenderer {
    struct Props {
        let numberOfPages: Int
        let currentPage: Int
        let visiblePages: [Int : PageView.Props]
        let didScroll: ViewEventWith<Int>
    }
    
    func render(_ props: Props) {
        self.props = props
        props.visiblePages.forEach { key, page in
            guard let cell = collectionView
                .cellForItem(at: IndexPath(item: key, section: 0))
                as? PageViewCell
            else { return }
            cell.pageView.render(props: page)
        }
    }
}

extension GameView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
}

extension GameView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.size.width
        let currentPage = scrollView.contentOffset.x / pageWidth
        if abs(currentPage - CGFloat(self.props.currentPage)) >= 1 {
            props.didScroll.perform(with: Int(floor(currentPage)))
        }
    }
}

extension GameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return props.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellID, for: indexPath) as? PageViewCell
        else {
            fatalError("PAGE NOT FOUND")
        }
        
        if let page = props.visiblePages[indexPath.row] {
            cell.pageView.render(props: page)
        }
        return cell
    }
    
    
}
