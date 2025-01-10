/// Module: my_coin
module my_coin::my_coin {
    use sui::coin::{Self, TreasuryCap};
    use sui::url;

    const EInvalidAmount: u64 = 0;

    public struct MY_COIN has drop {}

    fun init(witness: MY_COIN, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness, 
            6, 
            b"DUCH25_MYC", 
            b"duch25 Coin", 
            b"A Coin that can only be minted by specific addresses, created by Duc Hoai Nguyen - duch25.",
            option::some(url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/duch25/mover-duch25/task2/mover/duch25/images/logo_my_coin.png")), 
            ctx
        );

        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, ctx.sender());  
    }

    public entry fun mint(
        c: &mut TreasuryCap<MY_COIN>, 
        amount: u64, 
        recipient: address,
        ctx: &mut TxContext
    ) {
        assert!(amount > 0, EInvalidAmount);

        coin::mint_and_transfer(c, amount, recipient, ctx)
    }
}
