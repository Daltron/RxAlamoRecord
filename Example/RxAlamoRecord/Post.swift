
import AlamoRecord
import RxSwift
import ObjectMapper

class Post: ApplicationObject {
    
    override class var root: String {
        return "post"
    }

    private(set) var userId: Int!
    private(set) var title: String!
    private(set) var body: String!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }
    
    func comments() -> Observable<[Comment]> {
        let url = ApplicationURL(url: "\(Post.pluralRoot)/\(id!)/\(Comment.pluralRoot)")
        return requestManager.rx
            .mapObjects(.get, url: url)
            .execute()
    }

}
