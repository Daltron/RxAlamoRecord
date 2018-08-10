
class PostsViewModel {
    
    let posts = AlamoRecordRelay<[Post]>(value: [])

    func numberOfPosts() -> Int {
        return posts.value.count
    }
    
    func post(at index: Int) -> Post {
        return posts.value[index]
    }
    
    func insertPost(post: Post) {
        var posts = self.posts.value
        posts.insert(post, at: 0)
        self.posts.accept(posts)
    }
    
    func deletePost(at index: Int) {
        var posts = self.posts.value
        posts.remove(at: index)
        self.posts.accept(posts)
    }
}
