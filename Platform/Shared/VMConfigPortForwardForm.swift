//
// Copyright © 2020 osy. All rights reserved.
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

import SwiftUI

struct VMConfigPortForwardForm: View {
    @Binding var forward: UTMQemuConfigurationPortForward
    
    var body: some View {
        Group {
            VMConfigConstantPicker("Protocol", selection: $forward.protocol)
            DefaultTextField("Guest Address", text: $forward.guestAddress.bound, prompt: "10.0.2.15")
                .help("Guest Address")
            NumberTextField("Guest Port", number: $forward.guestPort, prompt: "1234")
                .help("Guest Port")
            DefaultTextField("Host Address", text: $forward.hostAddress.bound, prompt: "0.0.0.0")
                .help("Host Address")
            NumberTextField("Host Port", number: $forward.hostPort, prompt: "1234")
                .help("Host Port")
        }.disableAutocorrection(true)
        .keyboardType(.decimalPad)
    }
}

struct VMConfigPortForwardForm_Previews: PreviewProvider {
    @State static private var forward = UTMQemuConfigurationPortForward()
    
    static var previews: some View {
        VStack {
            VStack {
                Form {
                    VMConfigPortForwardForm(forward: $forward)
                }
            }
        }
    }
}
