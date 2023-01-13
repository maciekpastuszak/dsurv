import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";

actor Token {

    var owner : Principal = Principal.fromText("yhnky-yvzb5-tjllh-xw2qh-43jgt-igcz5-vafwp-mw3ya-4vnwq-n2w52-xae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "DMAC";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

    balances.put(owner, totalSupply);

    public query func balanceOf(who: Principal) : async Nat {
        
        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSymbol() :  async Text {
        return symbol;
    };

    public shared(msg) func payOut() : async Text {
        if (balances.get(msg.caller) == null) {
              let amount = 10000;
        balances.put(msg.caller, amount);
        return "Success"; 
        } else {
            return "Already claimed"
        }
     
    }
};