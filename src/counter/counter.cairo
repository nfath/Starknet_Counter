#[starknet::interface]
trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn increase_counter(ref self: TContractState);
    fn decrease_counter(ref self: TContractState);
    fn reset_counter(ref self: TContractState);
}

#[starknet::contract]
mod Counter {
    use super::ICounter;
    //use starknet::ContractAddress;
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        counter: u32,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        CounterIncreased: CounterIncreased,
        CounterDecreased: CounterDecreased
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        counter: u32
    }

    #[derive(Drop, starknet::Event)]
    struct CounterDecreased {
        counter: u32
    }

    #[constructor]
    fn constructor(ref self: ContractState, init_value: u32) {
        self.counter.write(init_value);
    }

    #[abi(embed_v0)]
    impl CounterImpl of ICounter<ContractState> {
        fn get_counter(self: @ContractState) -> u32 {
            self.counter.read()
        }

        fn increase_counter(ref self: ContractState) {
            let old_counter = self.counter.read();
            let new_counter = old_counter + 1;
            self.counter.write(new_counter);
            self.emit(CounterIncreased { counter: new_counter });
        }

        fn decrease_counter(ref self: ContractState) {
            let old_counter = self.counter.read();
            let new_counter = old_counter - 1;
            self.counter.write(new_counter);
            self.emit(CounterDecreased { counter: new_counter });
        }

        fn reset_counter(ref self: ContractState) {
            self.counter.write(0);
        }
    }
}
