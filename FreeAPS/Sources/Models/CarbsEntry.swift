import Foundation
import LoopKit

struct CarbsEntry: JSON, Equatable, Hashable {
    let id: String?
    let createdAt: Date
    let carbs: Decimal
    let fat: Decimal?
    let protein: Decimal?
    let note: String?
    let enteredBy: String?
    let isFPU: Bool?
    let fpuID: String?

    static let manual = "Open-iAPS"
    static let appleHealth = "applehealth"

    static func == (lhs: CarbsEntry, rhs: CarbsEntry) -> Bool {
        lhs.createdAt == rhs.createdAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(createdAt)
    }
}

extension CarbsEntry {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt = "created_at"
        case carbs
        case fat
        case protein
        case note
        case enteredBy
        case isFPU
        case fpuID
    }
}

extension CarbsEntry {
    func convertSyncCarb(operation: LoopKit.Operation = .create) -> SyncCarbObject {
        SyncCarbObject(
            absorptionTime: nil,
            createdByCurrentApp: true,
            foodType: nil,
            grams: Double(carbs),
            startDate: createdAt,
            uuid: UUID(uuidString: id!),
            provenanceIdentifier: enteredBy ?? "",
            syncIdentifier: id,
            syncVersion: nil,
            userCreatedDate: nil,
            userUpdatedDate: nil,
            userDeletedDate: nil,
            operation: operation,
            addedDate: nil,
            supercededDate: nil
        )
    }
}
