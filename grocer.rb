def find_item_by_name_in_collection(name, collection)
  # Implement me first!   # Consult README for inputs and output
  counter = 0
  while counter < collection.length do
    if collection[counter][:item] == name
      return collection[counter]
    end
  counter += 1
  end
#result
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
result = []
counter = 0
while counter < cart.length  do
  new_item = find_item_by_name_in_collection(cart[counter][:item], result)
  if new_item
    new_item[:count] += 1
  else
    new_item = {
      :item => cart[counter][:item],
      :price => cart[counter][:price],
      :clearance => cart[counter][:clearance],
      :count => 1
    }
    result << new_item
  end
counter += 1
end
result
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
  while counter < coupons.length do
  cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
  discount_item = "#{coupons[counter][:item]} W/COUPON"
  discounted_item = find_item_by_name_in_collection(discount_item, cart)
  if cart_item && cart_item[:count] >= coupons[counter][:num]
    if discouted_item
      discouted_item[:count] += coupons[counter][:num]
      cart_item[:count] -= coupons[counter][:num]
    else
      discounted_item = {
        :item => discount_item,
        :price => coupons[counter][:cost] / coupons[counter][:num],
        :count => coupons[counter][:num],
        :clearance => cart_item[:clearance]
      }
      cart << discounted_item
      cart_item[:count] -= coupons[counter][:num]
    end
  end
  counter += 1
end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
  while counter < cart.length do
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price]) - (cart[counter][:price] * 0.2).round(2)
    end
counter += 1
  end
cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupon_cart)

  total = 0
  counter = 0
  while counter < final_cart.length do
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1
  end
  if total > 100
    total -= (total * 0.10)
  end
  total
end
