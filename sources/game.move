module MyAddr::game{
 use std::signer;
use std::debug;
const STAR_ALREADY_EXISTS:u64 = 100;
const STAR_NOT_EXISTS:u64 = 101;
struct GameStar has key, drop {
 name: vector<u8>,
 country: vector<u8>,
 position: u8,
 value: u64,
 }
 
 public fun newStar(
    name: vector<u8>,
    country: vector<u8>,
    position: u8) :GameStar
 {
return GameStar{name,country,position,value:0}
 }

 public fun get(owner: address) :(vector<u8>, u64) acquires GameStar
 {
let star = borrow_global<GameStar>(owner);
 (star.name, star.value)
 }

 public fun mint(to: &signer, star: GameStar){
   let addr = signer::address_of(to);
  assert!(!exists<GameStar>(addr), STAR_ALREADY_EXISTS);
  move_to<GameStar>(to, star);
   }

   public fun setPrice(owner: address, price: u64) acquires GameStar{
      assert!(exists<GameStar>(owner), STAR_NOT_EXISTS);
      let star = borrow_global_mut<GameStar>(owner);
      star.value = price;
    }

    public fun transfer(owner: &signer, to: &signer) acquires GameStar {
      let addrto = signer::address_of(to);
     assert!(exists<GameStar>(addrto), STAR_NOT_EXISTS);
     let addro = signer::address_of(owner);
     let star = move_from<GameStar>(addro);
      star.value = star.value + 20;
     assert!(!exists<GameStar>(addrto), STAR_ALREADY_EXISTS);
     move_to<GameStar>(to, star);
      }
   
   
   // #[test(account = @0x42)]
   // public entry fun my_test(account:&signer) acquires GameStar{
   //     let star = MyAddr::game::newStar(b"Tahlil", b"BD", 7);
   //     let starName = star.name;
   //    debug::print(&starName);
   //    debug::print<GameStar>(&star);

   //    MyAddr::game::mint(account, star);
   //    let addrss = signer::address_of(account);
   //    let name:vector<u8>;
   //    let value: u64;
   //    (name, value) = MyAddr::game::get(addrss);
   //    debug::print<vector<u8>>(&name);
   //    debug::print<u64>(&value);
   // }

   #[test(account = @0x42)]
   public entry fun set_price_test(account:&signer) acquires GameStar{
       let star = MyAddr::game::newStar(b"Tahlil", b"BD", 7);
      
       MyAddr::game::mint(account, star);
       let addrss = signer::address_of(account);
   
       let value: u64;
       (_, value) = MyAddr::game::get(addrss);
       debug::print(&value);
       MyAddr::game::setPrice(addrss, 11);

       (_, value) = MyAddr::game::get(addrss);
       debug::print(&value);
   }
  
}
