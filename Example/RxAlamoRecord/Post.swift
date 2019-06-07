
import AlamoRecord
import RxSwift

class Post: AlamoRecordObject<ApplicationURL, ApplicationError, Int> {
    
    let title: String
    let body: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        try super.init(from: decoder)
    }
    
    override class var requestManager: ApplicationRequestManager {
        return ApplicationRequestManager.shared
    }
    
    override class var root: String {
        return "post"
    }
    
    func comments() -> Observable<[Comment]> {
        let url = ApplicationURL(url: "\(Post.pluralRoot)/\(id)/\(Comment.pluralRoot)")
        return requestManager.rx
            .mapObjects(.get, url: url)
            .execute()
    }
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case title
        case body
    }
    
}
