//
//  CommentsTableViewHelper.swift
//  RxAlamoRecord_Example
//
//  Created by Dalton Hinterscher on 8/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

protocol CommentsTableViewHelperDelegate: class {
    func numberOfComments() -> Int
    func comment(at index: Int) -> Comment
}

class CommentsTableViewHelper: NSObject {

    private weak var delegate: CommentsTableViewHelperDelegate?
    
    init(delegate: CommentsTableViewHelperDelegate) {
        super.init()
        self.delegate = delegate
    }
}

extension CommentsTableViewHelper: UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfComments() ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier) as! CommentCell
        cell.bind(comment: delegate!.comment(at: indexPath.row))
        return cell
    }
}

extension CommentsTableViewHelper: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
