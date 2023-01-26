//
//  ReplyInsertReplyView.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import UIKit
import SnapKit

final class ReplyInsertFieldView: UIView {
    let replyType: ReplyType
    let topLineView = UIView()

    var textView = UITextView()
    var profileImageView = UIImageView()
    var uploadButton = UIButton(type: .system)
    
    init(replyType: ReplyType) {
        self.replyType = replyType
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReplyInsertFieldView {
    func insertUI() {
        [
            topLineView,
            textView,
            profileImageView,
            uploadButton
        ]
            .forEach {
                addSubview($0)
            }
    }
    
    func basicSetUI() {
        topLineViewBasicSet()
        textViewBasicSet()
        profileImageViewBasicSet()
        uploadButtonBasicSet()
    }
    
    func anchorUI() {
        topLineViewAnchor()
        textViewAnchor()
        profileImageViewAnchor()
        uploadButtonAnchor()
    }
}

extension ReplyInsertFieldView {
    func topLineViewBasicSet() {
        topLineView.backgroundColor = .lightGray
    }
    
    func textViewBasicSet() {
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.layer.cornerRadius = 3
        textView.layer.borderWidth = 1
        textView.font = .boldSystemFont(ofSize: 12)
        textView.textContainerInset.left = 6
        textView.textContainerInset.right = 36
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func profileImageViewBasicSet() {
        profileImageView.backgroundColor = .clear
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
    }
    
    func uploadButtonBasicSet() {
        uploadButton.backgroundColor = .clear
        uploadButton.isEnabled = false
        uploadButton.isUserInteractionEnabled = false
        uploadButton.setTitleColor(.orange, for: .normal)
        uploadButton.setTitleColor(.lightGray, for: .disabled)
        uploadButton.setTitle("게시", for: .normal)
        uploadButton.setTitle("게시", for: .disabled)
        uploadButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        uploadButton.contentVerticalAlignment = .bottom
    }
    
    func topLineViewAnchor() {
        topLineView.snp.makeConstraints {
            $0.leading.trailing.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func textViewAnchor() {
        textView.snp.makeConstraints {
            $0.bottom.equalTo(-15)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(-16)
            $0.top.equalTo(15)
            //textViewHeight = make.height.equalTo(40).constraint
        }
    }
    
    func profileImageViewAnchor() {
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.leading.equalTo(17)
            $0.top.equalTo(15)
        }
    }
    
    func uploadButtonAnchor() {
        uploadButton.snp.makeConstraints {
           $0.trailing.equalTo(textView).offset(-5)
           $0.top.equalTo(textView).offset(10)
           $0.bottom.equalTo(textView).offset(-10)
           $0.width.equalTo(28)
        }
    }
}
