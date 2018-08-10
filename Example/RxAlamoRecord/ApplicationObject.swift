
import AlamoRecord

class ApplicationObject: AlamoRecordObject<ApplicationURL, ApplicationError> {

    override class var requestManager: RequestManager<ApplicationURL, ApplicationError> {
        return ApplicationRequestManager.shared
    }
    
    override var requestManager: RequestManager<ApplicationURL, ApplicationError> {
        return ApplicationRequestManager.shared
    }
}
