// module MyAddr::signerex{
//     use aptos_std::signer;
//     use aptos_std::debug;

//     public entry fun mainsign(sn:signer){
//         // let a:signer = @0x42;
//         // let addr = address_of(&sn); 
//         let addr = signer::address_of(&sn);
//         debug::print<address>(&addr);
//     }
// }