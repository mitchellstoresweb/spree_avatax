Spree::OrderContents.class_eval do
  def add_with_avatax(variant, quantity = 1, options = {})
    add_without_avatax(variant, quantity, options).tap do
      avatax_compute_tax
    end
  end

  def remove_with_avatax(variant, quantity = 1, options = {})
    remove_without_avatax(variant, quantity, options).tap do
      avatax_compute_tax
    end
  end

  def update_cart_with_avatax(params)
    if update_cart_without_avatax(params)
      avatax_compute_tax
      true
    else
      false
    end
  end

  def avatax_compute_tax
    SpreeAvatax::TaxComputer.new(order).compute
  end

  alias_method_chain :update_cart, :avatax
  alias_method_chain :add, :avatax
  alias_method_chain :remove, :avatax
end
