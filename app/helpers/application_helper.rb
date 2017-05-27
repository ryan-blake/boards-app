module ApplicationHelper
  @types_search = Type.all
  @distances_search = Distance.all
# find metadata proper
  def customer_name(customer)
   @charge = Stripe::Charge.retrieve(id: customer)
        @charge.metadata.customer.capitalize
  end

def meta_stripe_customer(charge)
   Stripe::Charge.retrieve(id: charge)
end

  def format_amount(amount)
    sprintf('$%0.2f', amount.to_f / 100.0).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end

  def format_date(created)
    Time.at(created).getutc.strftime("%m/%d/%Y")
  end

 def custom_user(user)
   if user.stripe_account.present?
   end
 end

private

def sortable(column, title = nil)
  title ||= column.titleize
  direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
  link_to title, params.merge(:sort => column, :direction => direction, :page => nil).permit!, remote: true

end

  def signed_on
    @user == current_user
  end

end
