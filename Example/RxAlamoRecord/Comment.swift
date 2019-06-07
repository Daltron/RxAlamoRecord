
import AlamoRecord

class Comment: AlamoRecordObject<ApplicationURL, ApplicationError, Int> {
    
    let name: String
    let email: String
    let body: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        body = try container.decode(String.self, forKey: .body)
        try super.init(from: decoder)
    }
    
    class override var requestManager: ApplicationRequestManager {
        return ApplicationRequestManager.shared
    }
    
    override class var root: String {
        return "comment"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case email
        case body
    }
}
