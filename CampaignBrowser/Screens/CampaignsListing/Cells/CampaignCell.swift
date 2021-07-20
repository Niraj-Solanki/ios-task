import UIKit
import RxSwift


/**
 The cell which displays a campaign.
 */
class CampaignCell: UICollectionViewCell {

    /** Used to update contentView.widthAnchor constraint later */
    private var widthConstraint: NSLayoutConstraint?
    
    private let disposeBag = DisposeBag()

    /** Used to display the campaign's title. */
    @IBOutlet private(set) weak var nameLabel: UILabel!

    /** Used to display the campaign's description. */
    @IBOutlet private(set) weak var descriptionLabel: UILabel!

    /** The image view which is used to display the campaign's mood image. */
    @IBOutlet private(set) weak var imageView: UIImageView!

    /** The mood image which is displayed as the background. */
    var moodImage: Observable<UIImage>? {
        didSet {
            moodImage?
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] image in
                    self?.imageView.image = image
                    })
                .disposed(by: disposeBag)
        }
    }

    /** The campaign's name. */
    var name: String? {
        didSet {
            nameLabel?.text = name
        }
    }

    var descriptionText: String? {
        didSet {
            descriptionLabel?.text = descriptionText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        /** The widthConstraint obtains contentView's widthAnchor LayoutConstraint. */
        widthConstraint = contentView.widthAnchor.constraint(equalToConstant: 0)
        assert(nameLabel != nil)
        assert(descriptionLabel != nil)
        assert(imageView != nil)
    }
    
    /// Used to update Constraints
    override func updateConstraints() {
        // Set width constraint to superview's width.
        widthConstraint?.constant = superview?.bounds.width ?? 0
        widthConstraint?.isActive = true
        super.updateConstraints()
    }
}
