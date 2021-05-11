

class Checkout
    attr_accessor :pricing_rules, :total

    def initialize(pricing_rules)
        @pricing_rules = pricing_rules
        @total = 0
        @cart = {}
        @catalog = {
            "A" => 50,
            "B" => 30,
            "C" => 20,
            "D" => 15
         }
    end

   # ITEM SCANNER
   def scan(item)
        @catalog.each do |citem, price|
            if (item == citem) 
                @total += price # increase total price
                if @cart.has_key?(item) # if cart already has cart
                    # increase item quantity in cart
                    @cart[item] += 1
                    #puts @cart[item]
                else 
                    # add item to cart
                    @cart[item] = 1
                end
            #puts @cart
            end
        end  
    end

    def applyDiscount()
        # for each pricing rule
        @pricing_rules.each do |rule|
            # if item is in cart 
            if  @cart.key?(rule.item_sku)
                # if item quanity matches special quanity
                if ( @cart[rule.item_sku] / rule.special_quant ) >= 1 
                   # minus discount off total price
                   @total -= (@cart[rule.item_sku] / rule.special_quant) * rule.special_disc
                   puts "You saved $#{(@cart[rule.item_sku] / rule.special_quant) * rule.special_disc}"
                end
            end
        end
    end
end


class PricingRule
    attr_accessor :item_sku, :special_quant, :special_disc

    def initialize(item_sku, special_quant, special_disc)
    @item_sku = item_sku
    @special_quant = special_quant
    @special_disc = special_disc
    end

end

rule_A = PricingRule.new("A", 3, 20)
rule_B = PricingRule.new("B", 2, 15)
rule_C = PricingRule.new("C", 3, 20)

pricing_rules = [rule_A, rule_B, rule_C]

co = Checkout.new(pricing_rules)
co.scan("A")
co.scan("A")
co.scan("A")
co.scan("B")
co.scan("B")
co.scan("C")
co.applyDiscount

puts co.total
