import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

actor Token {

    var owner : Principal = Principal.fromText("");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "DMAC";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
};