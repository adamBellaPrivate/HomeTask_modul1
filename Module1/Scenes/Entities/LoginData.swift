//
//  LoginData.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

struct LoginData {
    let username: String
    let password: String

    init?(username: String?, password: String?) {
        guard let username = username, !username.isEmpty, let password = password, !password.isEmpty else { return nil }
        self.username = username
        self.password = password
    }
}
