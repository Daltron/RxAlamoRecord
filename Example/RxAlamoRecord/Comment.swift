
import AlamoRecord
import ObjectMapper

class Comment: ApplicationObject {
    
    override class var root: String {
        return "comment"
    }
    
    private(set) var postId: Int!
    private(set) var name: String!
    private(set) var email: String!
    private(set) var body: String!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        postId <- map["postId"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }
}
