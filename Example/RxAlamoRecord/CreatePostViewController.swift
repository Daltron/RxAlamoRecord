//
//  CreatePostViewController.swift
//  AlamoRecord
//
//  Created by Dalton Hinterscher on 7/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Action
import KeyboardSpy
import NotificationBannerSwift
import RxSwift

protocol CreatePostViewControllerDelegate: class {
    func onPostCreated(post: Post)
}

class CreatePostViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private weak var delegate: CreatePostViewControllerDelegate?
    private var createView: CreatePostView {
        return view as! CreatePostView
    }
    
    init(delegate: CreatePostViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = UIRectEdge()
        self.delegate = delegate
        view = CreatePostView()
        
        let button = UIBarButtonItem(title: "SAVE", style: .plain, target: nil, action: nil)
        button.rx
            .tap
            .map { [weak self] _ in (self?.createView.titleTextField.text ?? "", self?.createView.bodyTextView.text ?? "") }
            .bind(to: saveButtonPressed.inputs)
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        KeyboardSpy.spy(on: createView)
        createView.titleTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        KeyboardSpy.unspy(on: createView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var saveButtonPressed: Action<(String, String), Swift.Never> = {
        return Action { [weak self] title, body in
            guard let s = self else { return Observable.empty() }
            
            if title.isEmpty || body.isEmpty {
                let banner = StatusBarNotificationBanner(title: "Both fields must be filled out to create a post.",
                                                         style: .danger)
                banner.show()
            } else {
                Post.rx
                    .create()
                    .withParameters(["title": title, "body": body, "userId": 1])
                    .execute()
                    .bind(to: s.postCreated, failure: s.postFailedToCreate)
                    .disposed(by: s.disposeBag)
            }
            
            return Observable.empty()
        }
    }()
    
    private lazy var postCreated: Action<Post, Swift.Never> = {
        return Action {  [weak self] post in
            let banner = StatusBarNotificationBanner(title: "Post created.",
                                                     style: .success)
            banner.show()
            self?.navigationController?.popViewController(animated: true)
            self?.delegate?.onPostCreated(post: post)
            return Observable.empty()
        }
    }()
    
    private lazy var postFailedToCreate: Action<ApplicationError, Swift.Never> = {
        return Action {  _ in
            let banner = StatusBarNotificationBanner(title: "Failed to create post.",
                                                     style: .danger)
            banner.show()
            return Observable.empty()
        }
    }()

}
