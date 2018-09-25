
import UIKit
import SnapKit

class PostsView: UIView {
    
    private(set) var tableView: UITableView!

    init(tableViewHelper: PostsTableViewHelper) {
        super.init(frame: .zero)
        backgroundColor = .darkWhite
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .darkWhite
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        tableView.dataSource = tableViewHelper
        tableView.delegate = tableViewHelper
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
