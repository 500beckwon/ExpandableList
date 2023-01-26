//
//  ReplyCollectionView.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import UIKit
import SnapKit

protocol UserPost {
    var id: String { get }
    var time: String { get }
}

enum ReplyListItem: Hashable {
    case reply(Reply)
    case reReply(ReReply)
}

final class ReplyCollectionView: UIView {
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cView
    }()
    
    var replySample = [
        Reply(content: "댓글1",
              postKey: "유저|타임",
              writer: "나1",
              replyTime: "지금1",
              reReply: [
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글11",
                        writer: "나나1",
                        reReplyTime: "지금11",
                        postKey: "유저|타임"),
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글12",
                        writer: "나나12",
                        reReplyTime: "지금12",
                        postKey: "유저|타임"),
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글13",
                        writer: "나나13",
                        reReplyTime: "지금13",
                        postKey: "유저|타임")
              ]),
        Reply(content: "댓글2",
              postKey: "유저|타임",
              writer: "나2",
              replyTime: "지금2",
              reReply: [
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글21",
                        writer: "나나21",
                        reReplyTime: "지금21",
                        postKey: "유저|타임"),
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글22",
                        writer: "나나22",
                        reReplyTime: "지금22",
                        postKey: "유저|타임"),
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글23",
                        writer: "나나23",
                        reReplyTime: "지금23",
                        postKey: "유저|타임")
              ]),
        Reply(content: "댓글3",
              postKey: "유저|타임",
              writer: "나3",
              replyTime: "지금3",
              reReply: [
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글31",
                        writer: "나나3",
                        reReplyTime: "지금31",
                        postKey: "유저|타임"),
                ReReply(replyKey: "유저|타임|타임",
                        content: "대댓글32",
                        writer: "나나32",
                        reReplyTime: "지금32",
                        postKey: "유저|타임")
                
              ]),
    ]
    
    let replyType: ReplyType
    var snapshot: NSDiffableDataSourceSnapshot<Reply, ReplyListItem>!
    lazy var replyInsertField = ReplyInsertFieldView(replyType: replyType)
    
    var dataSource: UICollectionViewDiffableDataSource<Reply, ReplyListItem>!
    
    init(replyType: ReplyType, post: UserPost, userID: String) {
        self.replyType = replyType
        super.init(frame: .zero)
        insertUI()
        basicSetUI()
        anchorUI()
        makeDataSource()
        performSnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<Reply, ReplyListItem>()
        snapshot.appendSections(replySample)
        dataSource.apply(snapshot, animatingDifferences: true)
        
        for reply in replySample {
            var sectionSnapShot = NSDiffableDataSourceSectionSnapshot<ReplyListItem>()
            
            let replyListItem = ReplyListItem.reply(reply)
            sectionSnapShot.append([replyListItem])
            
            let reReplyItemList = reply.reReply.map { ReplyListItem.reReply($0)}
            sectionSnapShot.append(reReplyItemList, to: replyListItem)
            // sectionSnapShot.expand([replyListItem]) <- 바로 펼치기
            dataSource.apply(sectionSnapShot, to: reply, animatingDifferences: false)
        }
    }
    
    func insertReply() {
        let randomCount = Int.random(in: 1...2)
        makeRandomReply()
    }
    
    func makeRandomReply() {
        let randomCount = Float.random(in: 1...252)
        
        let reply = Reply(content: "댓글 \(randomCount)",
                          postKey: "세키새키",
                          writer: "작성자23",
                          replyTime: "시간 \(randomCount)",
                          reReply: [])
        
        let item = ReplyListItem.reply(reply)
        var sectionSnapShot = NSDiffableDataSourceSectionSnapshot<ReplyListItem>()
        sectionSnapShot.append([item])
        dataSource.apply(sectionSnapShot, to: reply, animatingDifferences: false)
    }
    
    func insertReReply() {
        let randomCount = Float.random(in: 1...253)
        let randomIndex = 0
        let reReply = ReReply(replyKey: "유저|시간|시간",
                              content: "댓글 \(randomCount)",
                              writer: "유저 \(randomCount)",
                              reReplyTime: "시간 \(randomCount)",
                              postKey: "키|키")
        
        let reply = dataSource.snapshot().sectionIdentifiers[randomIndex]
        var sectionSnapShot = dataSource.snapshot(for: reply)
        let replyItem = ReplyListItem.reply(reply)
        sectionSnapShot.append( [ReplyListItem.reReply(reReply)], to: replyItem)
        dataSource.apply(sectionSnapShot, to: reply, animatingDifferences: true)
    }
}

private extension ReplyCollectionView {
    func insertUI() {
        addSubview(collectionView)
        addSubview(replyInsertField)
    }
    
    func basicSetUI() {
        collectionViewBasicSet()
    }
    
    func anchorUI() {
        collectionViewAnchor()
    }
    
    func collectionViewAnchor() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionViewBasicSet() {
        let layoutConfig = makeCollectionLayout()
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView.setCollectionViewLayout(listLayout, animated: false)
    }
    
    func makeDataSource() {
        // MARK: Cell registration
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Reply> {
            cell, indexPath, headerItem in
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.content
            cell.contentConfiguration = content
            let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
            
            cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ReReply> { cell, indexPath, item in
            
            var content = cell.defaultContentConfiguration()
            content.text = item.content
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Reply, ReplyListItem>(collectionView: collectionView) {
            collectionView, indexPath, listItem -> UICollectionViewCell? in
            
            switch listItem {
            case .reply(let replyItem):
                let cell = collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration,
                                                                        for: indexPath,
                                                                        item: replyItem)
                return cell
            case .reReply(let reReplyItem):
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                        for: indexPath,
                                                                        item: reReplyItem)
                return cell
            }
        }
    }
}

extension ReplyCollectionView {
    func makeCollectionLayout() -> UICollectionLayoutListConfiguration {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.headerMode = .none
        layoutConfig.trailingSwipeActionsConfigurationProvider = { indexPath in
            let action = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
                
            }
            action.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [action])
        }
        
        return layoutConfig
    }
    
    func handleSwipe(for action: UIContextualAction, item: SFSymbolItem) {
        let alert = UIAlertController(title: action.title,
                                      message: item.name,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title:"OK", style: .default, handler: { (_) in })
        alert.addAction(okAction)
        
    }
}
