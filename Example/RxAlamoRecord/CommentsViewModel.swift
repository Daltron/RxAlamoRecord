
class CommentsViewModel {

    let post: Post
    let comments = AlamoRecordRelay<[Comment]>(value: [])
    
    init(post: Post) {
        self.post = post
    }
    
    func numberOfComments() -> Int {
        return comments.value.count
    }
    
    func comment(at index: Int) -> Comment {
        return comments.value[index]
    }

}
