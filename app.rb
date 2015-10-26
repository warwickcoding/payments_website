require 'sinatra'
require 'stripe'

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  erb :index
end

post '/charge' do
  # Amount in cents
  @amount = 7000

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'gbp',
    :customer    => customer.id
  )

  erb :charge
end

__END__

@@ layout
  <!DOCTYPE html>
  <html>
    <head></head>
    <body>
      <%= yield %>
    </body>
  </html>

@@ index
  <form action="/charge" method="post" class="payment">
    <article>
      <label class="amount">
        <span>Amount: £70.00</span>
      </label>
    </article>

    <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
            data-key="<%= settings.publishable_key %>"
            data-description="A month's subscription"
            data-amount="7000"
            data-locale="auto"></script>
  </form>

@@ charge
  <h2>Thanks, you paid <strong>$5.00</strong>!</h2>
