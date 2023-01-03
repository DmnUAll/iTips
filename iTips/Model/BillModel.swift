import Foundation

struct BillModel {
    let totalCost: Float
    let totalPerPerson: Float
    let tipsPercent: Float
    let numberOfPersons: Float

    var totalPerPpersonInfo: String {
        return String(format: "%.2f", totalPerPerson)
    }
    var countResultInfo: String {
        return "Split between \(Int(numberOfPersons)) with \(Int(tipsPercent)) % tips."
    }
}
