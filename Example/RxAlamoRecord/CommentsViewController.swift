
import Action
import NotificationBannerSwift
import RxSwift

class CommentsViewController: UIViewController {

    private var commentsView: CommentsView {
        return view as! CommentsView
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel: CommentsViewModel
    private var tableViewHelper: CommentsTableViewHelper!
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = UIRectEdge()

        title = Comment.pluralRoot.capitalized
        
        tableViewHelper = CommentsTableViewHelper(delegate: self)
        view = CommentsView(tableViewHelper: tableViewHelper)
        
        viewModel.comments
            .bind(to: updateTableView)
            .disposed(by: disposeBag)
        
        viewModel.post
            .comments()
            .bind(to: viewModel.comments, failure: commentsRetrievalFailed)
            .disposed(by: disposeBag)
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    private lazy var updateTableView: Action<[Comment], Swift.Never> = {
        return Action { [weak self] _ in
            self?.commentsView.tableView.reloadData()
            return Observable.empty()
        }
    }()
    
    private lazy var commentsRetrievalFailed: Action<ApplicationError, Swift.Never> = {
        return Action { error in
            let banner = StatusBarNotificationBanner(title: "Failed to retreive comments: \(error)",
                style: .warning)
            banner.show()
            return Observable.empty()
        }
    }()

}

extension CommentsViewController: CommentsTableViewHelperDelegate {
    
    internal func numberOfComments() -> Int {
        return viewModel.numberOfComments()
    }
    
    internal func comment(at index: Int) -> Comment {
        return viewModel.comment(at: index)
    }
}
