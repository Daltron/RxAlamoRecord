
import AlamoRecord

class ApplicationObject: AlamoRecordObject<ApplicationURL, ApplicationError, Int> {

    override class var requestManager: ApplicationRequestManager {
        return ApplicationRequestManager.shared
    }
    
    override var requestManager: ApplicationRequestManager {
        return ApplicationRequestManager.shared
    }
}
