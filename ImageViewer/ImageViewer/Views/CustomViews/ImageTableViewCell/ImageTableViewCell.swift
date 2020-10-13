//
//  ImageTableViewCell.swift
//  ImageViewer
//
//  Created by Veera on 12/10/20.
//

import UIKit
import SDWebImage

fileprivate struct Constants {
    static let cellCornerRadius: CGFloat = 10.0
    static let cellBorderWidth: CGFloat = 2.0
    static let spacing10: CGFloat = 10.0
    static let spacingNegative10: CGFloat = -10.0
    static let size200: CGFloat = 200.0
    static let placeHolderImage = "placeholder"
    static let fontSize20: CGFloat = 20.0
    static let fontSize14: CGFloat = 14.0
}

class ImageTableViewCell: UITableViewCell {

    //--------------------------------------------------------------------------
    // MARK: - Init and over rides
    //--------------------------------------------------------------------------
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(factImageView)
        self.contentView.addSubview(descriptionLabel)
        
        self.selectionStyle = .none
        self.backgroundColor = .cyan
        self.layer.cornerRadius = Constants.cellCornerRadius
        self.layer.masksToBounds = true
        self.layer.borderWidth = Constants.cellBorderWidth
        self.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                            constant: Constants.spacing10),
            titleLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,
                                                constant: Constants.spacing10),
            titleLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,
                                                 constant: Constants.spacingNegative10),
            
            factImageView.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor),
            factImageView.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,
                                               constant: Constants.spacing10),
            factImageView.widthAnchor.constraint(equalToConstant: Constants.size200),
            factImageView.heightAnchor.constraint(equalToConstant: Constants.size200),
            
            descriptionLabel.topAnchor.constraint(equalTo:self.factImageView.bottomAnchor,
                                                  constant: Constants.spacing10),
            descriptionLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,
                                                      constant: Constants.spacing10),
            descriptionLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,
                                                       constant: Constants.spacingNegative10),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                     constant: Constants.spacingNegative10)
        ])
    }
    
    override func prepareForReuse() {
        factImageView.image = nil
        titleLabel.text = StringConstants.emptyString
        descriptionLabel.text = StringConstants.emptyString
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Outlets
    //--------------------------------------------------------------------------
    
    private let factImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize20)
        label.textColor = .darkText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize14)
        label.textColor =  .darkGray
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    func configureCell(with row: Row) {
        titleLabel.text = row.title
        descriptionLabel.text = row.rowDescription
    }
    
    func loadImage(with row: Row) {
        guard let imageURL = row.imageHref else {
            factImageView.image = UIImage(named: Constants.placeHolderImage)
            return
        }
        
        factImageView.sd_setImage(with: URL(string: imageURL),
                              placeholderImage: UIImage(named:  Constants.placeHolderImage),
                              options: .refreshCached,
                              completed: nil)
    }
}
