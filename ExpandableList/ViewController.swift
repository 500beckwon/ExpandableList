//
//  ViewController.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import UIKit

enum Section {
    case main
}

class ViewController: UIViewController {
    var dataSource: UICollectionViewDiffableDataSource<Section, SFSymbolItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, SFSymbolItem>!
    
    lazy var collectionView: UICollectionView = {
        let cView = UICollectionView(frame: .zero)
        return cView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCollectionViewLayout()
        dataSourceInit()
        performSnapshot()
    }
}

private extension ViewController {
    func makeConfiguration() -> UICollectionLayoutListConfiguration {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            guard let item = dataSource.itemIdentifier(for: indexPath) else {
                return nil
            }
            
            let action1 = UIContextualAction(style: .normal, title: "Action 1") { (action, view, completion) in
                
                self.handleSwipe(for: action, item: item)
                completion(true)
            }
            
            action1.backgroundColor = .systemGreen
            
            let action2 = UIContextualAction(style: .normal, title: "Action 2") { (action, view, completion) in
                self.handleSwipe(for: action, item: item)
                completion(true)
            }
            action2.backgroundColor = .systemPink
            
            return UISwipeActionsConfiguration(actions: [action2, action1])
        }
        return layoutConfig
    }
    
    
    func makeCollectionViewLayout() {
        let layoutConfig = makeConfiguration()
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout)
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
        ])
    }
    
    func performSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<Section, SFSymbolItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataItems, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func handleSwipe(for action: UIContextualAction, item: SFSymbolItem) {
        
        let alert = UIAlertController(title: action.title,
                                      message: item.name,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title:"OK", style: .default, handler: { (_) in })
        alert.addAction(okAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    func dataSourceInit() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem> { (cell, indexPath, item) in
            
            // Define how data should be shown using content configuration
            var content = cell.defaultContentConfiguration()
            content.image = item.image
            content.text = item.name
            
            // Assign content configuration to cell
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SFSymbolItem>(collectionView: collectionView) {
            collectionView, indexPath, identifier -> UICollectionViewCell? in
            
            // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            // Configure cell appearance
            cell.accessories = [.disclosureIndicator()]
            
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        
        let alert = UIAlertController(title: selectedItem.name,
                                      message: "",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title:"OK", style: .default, handler: { (_) in
            // Deselect the selected cell
            collectionView.deselectItem(at: indexPath, animated: true)
        })
        alert.addAction(okAction)
        
        present(alert, animated: true, completion:nil)
    }
}
