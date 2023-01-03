import UIKit

// MARK: - ResultPresenter
final class ResultPresenter {

    // MARK: - Properties and Initializers
    weak var viewController: ResultController?

    init(viewController: ResultController? = nil) {
        self.viewController = viewController
        viewController?.resultView.delegate = self

        let tap = UITapGestureRecognizer(target: viewController?.view, action: #selector(UIView.endEditing))
        viewController?.view.addGestureRecognizer(tap)
    }
}

// MARK: - Helpers
extension ResultPresenter {
    func fillUI(using billModel: BillModel) {
        viewController?.resultView.totalInfoLabel.text = billModel.countResultInfo
        viewController?.resultView.totalPerPersonLabel.text = billModel.totalPerPpersonInfo
    }
}

// MARK: - ResultViewDelegate
extension ResultPresenter: ResultViewDelegate {

    func recalculateTapped() {
        viewController?.dismiss(animated: true)
    }
}
