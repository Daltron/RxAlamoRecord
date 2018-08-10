
import UIKit

protocol PostsTableViewHelperDelegate: class {
    func numberOfPosts() -> Int
    func post(at index: Int) -> Post
    func commentsButtonPressed(at index: Int)
    func destroyButtonPressed(at index: Int)
}

class PostsTableViewHelper: NSObject {

    private weak var delegate: PostsTableViewHelperDelegate?
    
    init(delegate: PostsTableViewHelperDelegate) {
        super.init()
        self.delegate = delegate
    }
}

extension PostsTableViewHelper: UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfPosts() ?? 0
    }
    
    internal func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        cell.delegate = self
        cell.bind(post: delegate!.post(at: indexPath.row))
        
        return cell
    }
}

extension PostsTableViewHelper: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension PostsTableViewHelper: PostCellDelegate {
    
    internal func commentsButtonPressed(at index: Int) {
        delegate?.commentsButtonPressed(at: index)
    }
    
    internal func destroyButtonPressed(at index: Int) {
        delegate?.destroyButtonPressed(at: index)
    }
}
