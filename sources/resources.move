module MyAddr::Colln{
    use std::vector;
    use std::signer;
    use std::debug;

    struct Item has store, drop{}

    struct Collection has store, key {
        items: vector<Item>,
    }

    public fun start_collection(account:&signer)
    {
        move_to<Collection>(account, Collection{items: vector::empty<Item>()})
    }
        //presence/absence

    public fun exists_at(at: address):bool{
        exists<Collection>(at)
    }

    public fun add_item(account: &signer) acquires Collection{
        let addr = signer::address_of(account);
        //let collection = borrow_global<Collection>(addr);
        let collection = borrow_global_mut<Collection>(addr);
        vector::push_back(&mut collection.items, Item{})
    }

    public fun size(account: &signer):u64 acquires Collection{
        let addr = signer::address_of(account);
        let collection = borrow_global<Collection>(addr);
        vector::length(&collection.items)
    }



    public fun destroy(account: &signer) acquires Collection
    {
        let addr = signer::address_of(account);
        let collection = move_from<Collection>(addr);

        let Collection{items:_} = collection;
    }

    

         #[test(account = @0x11)]
        public entry fun my_test(account: signer) acquires Collection{
            MyAddr::Colln::start_collection(&account);
            let addrss = signer::address_of(&account);
            let addressExist = MyAddr::Colln::exists_at(addrss);
            MyAddr::Colln::add_item(&account);
            let colSize = MyAddr::Colln::size(&account);
            debug::print(&addressExist);
            debug::print(&colSize);
            // debug::print(&colSize);
        }

         #[test(account = @0x42)]
        public entry fun delete_test(account: signer) acquires Collection{
            MyAddr::Colln::start_collection(&account);
            let addrss = signer::address_of(&account);
            let addressExist = MyAddr::Colln::exists_at(addrss);
            MyAddr::Colln::add_item(&account);
            let colSize = MyAddr::Colln::size(&account);
            debug::print(&addressExist);
            debug::print(&colSize);
            MyAddr::Colln::destroy(&account);
            // MyAddr::Colln::destroy(&account);
            addressExist = MyAddr::Colln::exists_at(addrss);
            debug::print(&addressExist);
            // debug::print(&colSize);
        }

        // #[test(account = @0x01)]
        // public entry fun script_fn_2(account: signer) acquires Collection{
        //     MyAddr::Colln::start_collection(&account);
        //     let addr = signer::address_of(&account);
        //     let is = MyAddr::Colln::exists_at(addr);
        //     debug::print(&is);
        //     MyAddr::Colln::add_item(&account);
        //     let lsize = MyAddr::Colln::size(&account);
        //     debug::print(&lsize);
        //     MyAddr::Colln::destroy(&account);
        //     MyAddr::Colln::destroy(&account);
        //     let is = MyAddr::Colln::exists_at(addr);
        //     debug::print(&is);
        //     //MyAddr::Colln::start_collection(&account);
        // }
    }