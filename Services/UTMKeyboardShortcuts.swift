//
// Copyright © 2025 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

final class UTMKeyboardShortcuts {
    static let shared = UTMKeyboardShortcuts()
    @Setting("KeyboardShortcuts") private var savedKeyboardShortcuts: Data? = nil
    
    private init() {}
    
    func loadKeyboardShortcuts() -> [[QEMUKeyCode]] {
        let decoder = PropertyListDecoder()
        if let data = savedKeyboardShortcuts {
            if let decoded = try? decoder.decode([[QEMUKeyCode]].self, from: data) {
                return decoded
            }
        }
        // default entry
        return [[.keyCtrl, .keyAlt, .keyDelete]]
    }
    
    func saveKeyboardShortcuts(_ keyboardShortcuts: [[QEMUKeyCode]]) {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        if let data = try? encoder.encode(keyboardShortcuts) {
            savedKeyboardShortcuts = data
        }
    }
}

extension QEMUKeyCode: @retroactive Codable, @retroactive Identifiable, @retroactive CaseIterable {
    public var id: Self {
        self
    }
    
    public var title: String {
        QEMUMonitor.keyMap[self] ?? ""
    }
    
    public static var allCases: [QEMUKeyCode] {
        Array(QEMUMonitor.keyMap.keys).sorted { $0.rawValue < $1.rawValue }
    }
}

extension Array where Element == QEMUKeyCode {
    var title: String {
        self.map({ $0.title }).joined(separator: "+")
    }
}
