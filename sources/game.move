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
   
   #[test(account = @0x42)]
   public entry fun my_test(account:&signer) acquires GameStar{
       let star = MyAddr::game::newStar(b"Sneha", b"Bharat", 6);
       let starName = star.name;
      debug::print(&starName);
      debug::print<GameStar>(&star);

      MyAddr::game::mint(account, star);
      let addrss = signer::address_of(account);
      let name:vector<u8>;
      let value: u64;
      (name, value) = MyAddr::game::get(addrss);
      debug::print<vector<u8>>(&name);
      debug::print<u64>(&value);
   }
  
}
