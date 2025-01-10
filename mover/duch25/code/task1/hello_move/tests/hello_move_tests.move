// tests/hello_move_tests.move

#[test_only]
module hello_move::hello_move_tests;

use std::string::{Self};
use sui::test_scenario;
use hello_move::greetings::{GreetingMessage, send_hello_to_duch25, get_content};
// use std::debug;

const ENotImplemented: u64 = 0;

// Test for sending a greeting message to "duch25"
#[test]
fun test_send_hello_to_duch25() {
    let dummy_address = @0xCAFE;

    let mut scenario = test_scenario::begin(dummy_address);
    {
        send_hello_to_duch25(scenario.ctx());
    };

    // Verify that the greeting message has been sent to the correct recipient (duch25)
    scenario.next_tx(dummy_address);
    {
        let greeting = scenario.take_from_sender<GreetingMessage>();

        // Check the content of the greeting to confirm it was sent correctly
        // debug::print(get_content(&greeting));
        assert!(get_content(&greeting) == string::utf8(b"Hello duch25"), ENotImplemented);    

        scenario.return_to_sender(greeting);
    };

    scenario.end();
}