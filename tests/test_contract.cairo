use starknet_counter::Counter;
use starknet::ContractAddress;

use snforge_std::{
    declare, ContractClassTrait, DeclareResultTrait, start_cheat_caller_address,
    stop_cheat_caller_address, spy_events, EventSpyAssertionsTrait,
};

use starknet_counter::{
    ICounterDispatcher, ICounterDispatcherTrait, ICounterSafeDispatcher,
    ICounterSafeDispatcherTrait,
};

fn OWNER() -> ContractAddress {
    'OWNER'.try_into().unwrap()
}

fn deploy_counter(initial_count: u32) -> (ICounterDispatcher, ICounterSafeDispatcher) {
    let contract = declare("Counter").unwrap().contract_class();

    //serialize the calldata
    let mut calldata = array![];
    initial_count.serialize(ref calldata);
    OWNER().serialize(ref calldata);

    let (contract_address, _) = contract.deploy(@calldata).unwrap();

    let dispatcher = ICounterDispatcher { contract_address };
    let safe_dispatcher = ICounterSafeDispatcher { contract_address };

    (dispatcher, safe_dispatcher)
}

#[test]
fn test_deploy_contract() {
    let initial_count = 0;
    let (counter, _) = deploy_counter(initial_count);

    let current_counter = counter.get_counter();
    assert!(current_counter == initial_count, "count should be initial count");
}

#[test]
fn test_increase_counter() {
    let initial_count = 0;
    let (counter, _) = deploy_counter(initial_count);

    counter.increase_counter();

    let expected_count = initial_count + 1;
    let current_count = counter.get_counter();
    assert!(current_count == expected_count, "Count should increment by 1");
}

