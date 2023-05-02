//
//  Note.swift
//  Notes Watch App
//
//  Created by Hassan Assiry on 23/04/2023.
//

import Foundation

struct Note: Identifiable , Codable
{
    let id: UUID
    let text: String
}
