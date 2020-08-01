/*
 * Copyright 2019, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import GRPC
import NIOTransportServices
import NIO
import Logging

struct Greeter {

    let group = NIOTSEventLoopGroup()

    //Here use host and port of your local machine
    func reproduceBug(host: String = "192.168.1.16", port: Int = 58310) {
        // Configure the channel, we're not using TLS so the connection is `insecure`.
        let channel = ClientConnection
            .insecure(group: group)
            .connect(host: host, port: port)

        // Provide the connection to the generated client.
        let greeter = Helloworld_GreeterClient(channel: channel)

        // Form the request with the name, if one was provided.
        let request1 = Helloworld_HelloRequest.with { $0.name = "Hello_1" }

        let request2 = Helloworld_HelloRequest.with { $0.name = "Hello_2" }

        ///THIS NOT WORKING
        ///////////////////////////////////
        greeter.sayHello(request1).response
            .whenComplete { (result) in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let response):
                    debugPrint(response)
                }
        }

        greeter.sayHello(request2).response
            .whenComplete { (result) in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let response):
                    debugPrint(response)
                }
        }
        /////////////////////////////////////
    }
}
