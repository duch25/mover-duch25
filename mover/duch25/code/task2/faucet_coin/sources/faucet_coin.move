/// Module: faucet_coin
module faucet_coin::faucet_coin {
    use sui::coin::{Self, TreasuryCap};
    use sui::url;

    const EInvalidAmount: u64 = 0;

    public struct FAUCET_COIN has drop {}

    fun init(witness: FAUCET_COIN, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness, 
            6, 
            b"DUCH25_FCC", 
            b"duch25 Faucet Coin", 
            b"A Coin that anyone can mint, created by Duc Hoai Nguyen - duch25.",
            option::some(url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/duch25/mover-duch25/task2/mover/duch25/images/logo_faucet_coin.png")), 
            ctx
        );

        transfer::public_freeze_object(metadata);
        transfer::public_share_object(treasury);
    }

    public entry fun mint(
        c: &mut TreasuryCap<FAUCET_COIN>, 
        amount: u64, 
        recipient: address,
        ctx: &mut TxContext
    ) {
        assert!(amount > 0, EInvalidAmount);

        coin::mint_and_transfer(c, amount, recipient, ctx);
    }
}
