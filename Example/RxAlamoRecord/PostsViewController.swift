
import Action
import NotificationBannerSwift
import RxSwift

class PostsViewController: UIViewController {

    private var postsView: PostsView {
        return view as! PostsView
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel = PostsViewModel()
    private var tableViewHelper: PostsTableViewHelper!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = UIRectEdge()
        title = Post.pluralRoot.capitalized
        
        tableViewHelper = PostsTableViewHelper(delegate: self)
        view = PostsView(tableViewHelper: tableViewHelper)
        
        viewModel.posts
            .take(2)
            .bind(to: updateTableView)
            .disposed(by: disposeBag)
        
        Post.rx
            .all()
            .execute()
            .bind(to: viewModel.posts, failure: postsRetrievalFailed)
            .disposed(by: disposeBag)
        
        let button = UIBarButtonItem(title: "CREATE", style: .plain, target: nil, action: nil)
        button.rx
            .tap
            .bind(to: createButtonPressed.inputs)
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem = button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    private lazy var updateTableView: Action<[Post], Swift.Never> = {
        return Action { [weak self] _ in
            self?.postsView.tableView.reloadData()
            return Observable.empty()
        }
    }()
    
    private lazy var postsRetrievalFailed: Action<ApplicationError, Swift.Never> = {
        return Action { error in
            let banner = StatusBarNotificationBanner(title: "Failed to retreive posts: \(error)",
                                                     style: .warning)
            banner.show()
            return Observable.empty()
        }
    }()
    
    private lazy var destroyedPost: Action<Int, Swift.Never> = {
        return Action { [weak self] index in
            self?.viewModel.deletePost(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            self?.postsView.tableView.deleteRows(at: [indexPath], with: .automatic)
            let banner = StatusBarNotificationBanner(title: "Post destroyed.",
                                                     style: .success)
            banner.show()
            return Observable.empty()
        }
    }()
    
    private lazy var destroyPostFailed: Action<ApplicationError, Swift.Never> = {
        return Action { error in
            let banner = StatusBarNotificationBanner(title: "Post not destroyed: \(error)",
                                                     style: .warning)
            banner.show()
            return Observable.empty()
        }
    }()
    
    private lazy var createButtonPressed: Action<Void, Swift.Never> = {
        return Action { [weak self] _ in
            guard let s = self else { return Observable.empty() }
            s.navigationController?.pushViewController(CreatePostViewController(delegate: s), animated: true)
            return Observable.empty()
        }
    }()
}

extension PostsViewController: PostsTableViewHelperDelegate {
    
    internal func numberOfPosts() -> Int {
        return viewModel.numberOfPosts()
    }
    
    internal func post(at index: Int) -> Post {
        return viewModel.post(at: index)
    }
    
    internal func commentsButtonPressed(at index: Int) {
        let post = self.post(at: index)
        let viewModel = CommentsViewModel(post: post)
        let controller = CommentsViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    internal func destroyButtonPressed(at index: Int) {
        let post = self.post(at: index)
        post.rx
            .destroy()
            .execute()
            .map { _ in index }
            .bind(to: destroyedPost, failure: destroyPostFailed)
            .disposed(by: disposeBag)
    }
    
}

extension PostsViewController: CreatePostViewControllerDelegate {
    
    internal func onPostCreated(post: Post) {
        viewModel.insertPost(post: post)
        let indexPath = IndexPath(row: 0, section: 0)
        postsView.tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
