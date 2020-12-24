import UIKit
import DifferenceKit

final class GameView: SwelmView {
    
    static let cellID = "Cell"
    
    var props: Props = .initial {
        didSet {
            render(props: props)
        }
    }
    
    private var pages: [PageView.Props] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(PageViewCell.self, forCellWithReuseIdentifier: Self.cellID)
        view.delegate = self
        view.isPagingEnabled = true
        view.dataSource = self
        
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

extension GameView {
    private func render(props: Props) {
        let changeset = StagedChangeset(source: pages, target: props.pages)
        UIView.animate(withDuration: 0) {
            self.collectionView.reload(using: changeset) { data in
                self.pages = props.pages
            }
        }
        
    }
}

extension GameView {
    struct Props {
        let pages: [PageView.Props]
        let didScroll: UICommandWith<Int>
        
        static let initial = Props(pages: [], didScroll: .nop)
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
        if floor(currentPage) == currentPage {
            props.didScroll.perform(with: Int(floor(currentPage)))
        }
    }
}

extension GameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let page = pages[safe: indexPath.row],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellID, for: indexPath) as? PageViewCell
        else {
            fatalError("PAGE NOT FOUND")
        }
        
        
        cell.pageView.props = page
        return cell
    }
    
    
}
