//
//  ReplyViewController.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import UIKit
import SnapKit

struct Post: UserPost {
    var id: String
    var time: String
}

 class ReplyViewController: UIViewController {
    lazy var replyListView = ReplyCollectionView(replyType: .homeBookReply, post: Post(id: "", time: "") , userID: "")
    
     var replyButton = UIButton(type: .system)
     var reReplyButton = UIButton(type: .system)
     
     
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
     
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         replyButton.setTitle("댓글", for: .normal)
         reReplyButton.setTitle("대댓글", for: .normal)
         
         replyButton.addTarget(self, action: #selector(replyButtonTapped), for: .touchUpInside)
         reReplyButton.addTarget(self, action: #selector(reReplyButtonTapped), for: .touchUpInside)
         let replyBarButton = UIBarButtonItem(customView: replyButton)
         let reReplyBarButton = UIBarButtonItem(customView: reReplyButton)
         navigationController?.navigationBar.isHidden = false
         navigationItem.rightBarButtonItems = [replyBarButton, reReplyBarButton]
     }
     
     func layout() {
         view.addSubview(replyListView)
         replyListView.snp.makeConstraints {
             $0.edges.equalToSuperview()
         }
     }
     
     @objc func reReplyButtonTapped(_ sender: UIButton) {
         replyListView.insertReReply()
     }
     
     @objc func replyButtonTapped(_ sender: UIButton) {
         replyListView.insertReply()
     }
}
