
import UIKit

class CommentCell: BaseTableViewCell {

    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var bodyLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize * 1.25)
        resizableView.addSubview(nameLabel)
        
        bodyLabel = UILabel()
        bodyLabel.numberOfLines = 0
        bodyLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        resizableView.addSubview(bodyLabel)
        
        emailLabel = UILabel()
        emailLabel.numberOfLines = 0
        emailLabel.font = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        emailLabel.textColor = .lightGray
        resizableView.addSubview(emailLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        bodyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel)
            make.right.equalTo(nameLabel)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bodyLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel)
            make.right.equalTo(nameLabel)
        }
        
        autoResize(under: emailLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(comment: Comment) {
        nameLabel.text = comment.name
        bodyLabel.text = comment.body
        emailLabel.text = comment.email
    }

}
