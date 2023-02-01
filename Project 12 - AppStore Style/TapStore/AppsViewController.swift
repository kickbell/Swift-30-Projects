//
//  ViewController.swift
//  TapStore
//
//  Created by Paul Hudson on 01/10/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {
    let sections = Bundle.main.decode([Section].self, from: "appstore.json")
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, App>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseIdentifier)
        
        createDataSource()
        reloadData()
        
    }
    
    //SelfConfiguringCell를 준수하는 T타입은 다 리턴가능..
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with app: App, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: app)
        return cell
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
            switch self.sections[indexPath.section].type {
            case "mediumTable":
                return self.configure(MediumTableCell.self, with: app, for: indexPath)
            default:
                return self.configure(FeaturedCell.self, with: app, for: indexPath)
            }
        }
        
        
        //섹션헤더.
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                return nil
            }
            //인덱스경로를 읽는 대신 직접 섹션을 가져오는 방법?..이라는데.
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.title.isEmpty { return nil }
            
            sectionHeader.title.text = section.title
            sectionHeader.subtitle.text = section.subtitle
            return sectionHeader
        }
    }

    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case "mediumTable":
                return self.createMediumTableSection(using: section)
            default:
                return self.createFeaturedSection(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    //전체 레이아웃에서 하나의 섹션을 생성하는 방법
    //아이템 크기정하고. 아이템레이아웃생성하고..
    //그니까 뭔가 이렇게 아이템크기나 섹션모양이나 이런걸 정하는 그런작업..NSCollectionLayoutSection 을 리턴하는거보니까.
    //1개의 섹션을 디자인하는 작업이다.
    func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5) //아이템과 아이템사이의 공간을 조절
        
        //그룹 하나가 100퍼센트 가로로 꽉차느냐의 여부.
        //0.93으로하면 뒤에가 약간 보임
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        //이거 중요. 이걸로 가로스크롤링되게할수있음
        //groupPagingCentered 이기때문에 센터로 계속 이동됨. groupPaging 이면 왼쪽은 안보임.
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
    
    func createMediumTableSection(using section: Section) -> NSCollectionLayoutSection {
        //중요. 3개가 하나로 들어가야되니까 fractionalHeight는 0.33 이된거다.
        //그러면.. 그 큰 덩어리 하나가 Item이라고 볼수있는거겠지.?
        //아냐 그건 아닌거같애. fractional가 분모분수에서 분수라는 뜻이니까.. 부모기준으로 0.33이다 뭐그런말인가봐ㅏ.
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5) //아이템과 아이템사이의 공간을 조절
        
        //그룹 하나가 100퍼센트 가로로 꽉차느냐의 여부.
        //0.93으로하면 뒤에가 약간 보임
        //또 중요한건 fractionalWidth(0.55)인데..
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        //또 저 3개짜리가 수직으로 쌓이니까.. 이것도 vertical으로. 이부분도 좀 헷갈림.
        //그룹이라는 단위도 중요한듯 그래서.
        //https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout 이사진이 중요한듯.
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        
        //만들고 등록한 섹션헤더 집어넣기
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        
        
        return layoutSection
    }

}

