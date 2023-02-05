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
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, App>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        createDataSource()
        applyInitialSnapshot()
    }

    
    func cellRegistration<T: SelfConfiguringCell> (_ cell: T.Type) -> UICollectionView.CellRegistration<T, App>{
        return UICollectionView.CellRegistration<T, App> { (cell, indexPath, app) in cell.configure(with: app)
        }
    }
    
    func sectionHeaderRegistration<T: UICollectionReusableView>(_ view: T.Type) -> UICollectionView.SupplementaryRegistration<T>{
        return UICollectionView.SupplementaryRegistration<T>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView,elementKind,indexPath in }
    }
    
    func createDataSource() {
        let featuredCellRegistration = cellRegistration(FeaturedCell.self)
        let smallTableCellRegistration = cellRegistration(SmallTableCell.self)
        let mediumTableCellRegistration = cellRegistration(MediumTableCell.self)
        let sectionHeaderRegistration = sectionHeaderRegistration(SectionHeader.self)
        
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
            let section = self.sections[indexPath.section]
            
            switch section.appType {
                //            switch self.sections[indexPath.section].type {
            case .mediumTable:
                return collectionView.dequeueConfiguredReusableCell(using: mediumTableCellRegistration, for: indexPath, item: app)
            case .smallTable:
                return collectionView.dequeueConfiguredReusableCell(using: smallTableCellRegistration, for: indexPath, item: app)
            case .featured:
                return collectionView.dequeueConfiguredReusableCell(using: featuredCellRegistration, for: indexPath, item: app)
            case .none:
                return UICollectionViewCell()
            }
        }
        
        
        //섹션헤더.
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            
            //인덱스경로를 읽는 대신 직접 섹션을 가져오는 방법?..이라는데.
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.title.isEmpty { return nil }
            
            sectionHeader.title.text = section.title
            sectionHeader.subtitle.text = section.subtitle
            return sectionHeader
        }
    }
    
    func applyInitialSnapshot() {
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
            
            switch section.appType {
            case .mediumTable:
                return self.createMediumTableSection(using: section)
            case .smallTable:
                return self.createSmallTableSection(using: section)
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
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        
        
        return layoutSection
    }
    
    func createSmallTableSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
}
