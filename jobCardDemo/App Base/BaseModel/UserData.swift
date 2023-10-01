
import Foundation

// MARK: - LoginModel
struct LoginModel: BaseCodable {
    var status: String
    var data: UserData?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case status, data , message
    }
}

// MARK: - UserData
struct UserData: Codable {
    let id, fullname, email: String?
    var phone , phoneKey: String?
    let image: String?
    let isActive: Bool?
    var token: Token?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case id, fullname, phone, email, image, gender, phoneKey
        case isActive = "is_active"
        case token
    }
}

// MARK: - Token
struct Token: Codable {
    var tokenType, accessToken: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
    }
}
