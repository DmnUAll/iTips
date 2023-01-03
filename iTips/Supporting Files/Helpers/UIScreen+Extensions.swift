import UIKit

extension UIScreen {

    static func screenSize(heightDividedBy divider: CGFloat) -> CGFloat {
        return self.main.bounds.height / divider
    }
}
