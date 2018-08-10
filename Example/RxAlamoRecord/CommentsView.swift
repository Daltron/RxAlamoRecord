
import UIKit


class CommentsView: UIView {

    private(set) var tableView: UITableView!
    
    init(tableViewHelper: CommentsTableViewHelper) {
        super.init(frame: .zero)
        backgroundColor = .darkWhite
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .darkWhite
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50.0
        tableView.dataSource = tableViewHelper
        tableView.delegate = tableViewHelper
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseIdentifier)
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
