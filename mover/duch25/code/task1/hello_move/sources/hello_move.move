// Module: greetings
module hello_move::greetings {
    
    use std::string::{Self, String};

    // Struct to store greeting message details
    public struct GreetingMessage has key {
        id: UID,
        content: String
    }

    // Struct to store Github ID 
    public struct GithubID has key {
        id: UID,
        github_id: String
    }

    public fun get_content(greeting: &GreetingMessage): &String {
        &greeting.content
    }

    // Function to create a greeting message
    public fun new_greeting_message(content: String, ctx: &mut TxContext): GreetingMessage {
        GreetingMessage {
            id: object::new(ctx),
            content: content
        }
    }

    // Function to set Github ID in the struct
    public fun set_github_id(_github_id: String, ctx: &mut TxContext): GithubID {
        GithubID {
            id: object::new(ctx),
            github_id: _github_id
        }
    }

    // Entry function to send a greeting message to `duch25`
    public entry fun send_hello_to_duch25(ctx: &mut TxContext) {
        let github_id_struct = set_github_id(string::utf8(b"duch25"), ctx);

        let mut content = string::utf8(b"Hello ");
        string::append(&mut content, github_id_struct.github_id);
        let greeting = new_greeting_message(content, ctx);

        transfer::transfer(greeting, ctx.sender());

        let GithubID { id, github_id: _ } = github_id_struct;
        object::delete(id);
    }

    fun init(ctx: &mut TxContext) {
        send_hello_to_duch25(ctx);
    }
}  