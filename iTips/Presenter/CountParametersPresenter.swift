import UIKit

// MARK: - CountParametersPresenter
final class CountParametersPresenter {

    // MARK: - Properties and Initializers
    weak var viewController: CountParametersController?

    init(viewController: CountParametersController? = nil) {
        self.viewController = viewController
        viewController?.countParametersView.delegate = self

        let tap = UITapGestureRecognizer(target: viewController?.view, action: #selector(UIView.endEditing))
        viewController?.view.addGestureRecognizer(tap)
    }
}

// MARK: - Helpers
private extension CountParametersPresenter {

    private func showAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let actionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(actionOK)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - CounterParametersViewDelegate
extension CountParametersPresenter: CountParametersViewDelegate {

    func calculateTapped(withBill bill: String?, tipsPercent tips: Float, andNumberOfPersons persons: Float) {
        guard let bill = bill else { return }
        guard let unwrappedBill = Float((bill.replacingOccurrences(of: ",", with: "."))) else {
            showAlert(withTitle: "You should enter a correct bill!", andMessage: "e.g. 123.45")
            return
        }
        let total = (unwrappedBill * (1 + tips.rounded(.down) / 100) / persons)
        let billModel = BillModel(totalCost: unwrappedBill,
                                  totalPerPerson: total,
                                  tipsPercent: tips,
                                  numberOfPersons: persons)
        viewController?.show(ResultController(forBill: billModel), sender: nil)
    }

    func tipsPercentChanged(to value: String) {
        viewController?.countParametersView.billTotalTextField.endEditing(true)
        viewController?.countParametersView.tipsAmountInfoLabel.text = value
    }

    func personsAmountChanged(to value: String) {
        viewController?.countParametersView.billTotalTextField.endEditing(true)
        viewController?.countParametersView.personsAmountInfoLabel.text = value
    }
}
