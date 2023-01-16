import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";

actor Token {

    let owner : Principal = Principal.fromText("yhnky-yvzb5-tjllh-xw2qh-43jgt-igcz5-vafwp-mw3ya-4vnwq-n2w52-xae");
    let totalSupply : Nat = 1000000000;
    let symbol : Text = "DMAC";

    private stable var balanceEntries : [(Principal, Nat)] = [];

    private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

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
        let result = await transfer(msg.caller, amount);
        return result; 
        } else {
            return "Already claimed"
        }
     
    };

    public shared(msg)func transfer(to: Principal, amount: Nat) : async Text {
        let fromBalance = await balanceOf(msg.caller);
        if (fromBalance > amount) {
            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);
            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);
            return "Success";
        } else {
            return "Insufficient funds"
        }
       
    };

    system func preupgrade() {
        balanceEntries := Iter.toArray(balances.entrie());
    };

     system func postupgrade() {
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.val(), 1, Principal.equal, Principal.hash);
        if (blances.size() < 1) {

            balances.put(owner, totalSupply);
        }
    };
};