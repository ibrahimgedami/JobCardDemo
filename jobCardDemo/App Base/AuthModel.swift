
import Foundation

// MARK: - AuthModel
struct AuthModel: BaseCodable {
    var status: String
    let data: AuthData?
    let isActive: Bool?
    let devMessage: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status, data
        case isActive = "is_active"
        case devMessage = "dev_message"
        case message
    }
}

// MARK: - AuthData
struct AuthData: Codable {
    let userID: Int?
    let userType, phonecode, phone: String?
    let carPackageID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userType = "user_type"
        case phonecode, phone
        case carPackageID = "car_package_id"
    }
}

// MARK: - ForgetPasswordModel
struct ForgetPasswordModel: BaseCodable {
    var status: String
    let message: String?
    let data: ForgetPasswordData?
}




// MARK: - ForgetPasswordData
struct ForgetPasswordData: Codable {
    let devMessage: Int?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case devMessage = "dev_message"
        case phone
    }
}
