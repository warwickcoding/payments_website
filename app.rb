require 'sinatra'
require 'stripe'

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  erb :index
end

get '/payment_frontend' do
  erb :payment_frontend
end


get '/payment_android_regular' do
  erb :payment_android_regular
end

post '/chargefrontend' do
  # Amount in cents
  @amount = 5000

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Frontend Charge',
    :currency    => 'gbp',
    :customer    => customer.id
  )

  erb :chargefrontend
end

post '/chargeandroid' do
  # Amount in cents
  @amount = 6000

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Android Charge',
    :currency    => 'gbp',
    :customer    => customer.id
  )

  erb :chargeandroid
end

__END__

@@ layout
  <!DOCTYPE html>
  <html>
    <head>
      <link rel="shortcut icon" href="brackets.ico">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">
      <link rel="stylesheet" href="styles.css">
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    </head>
    <body>
      <%= yield %>
    </body>
  </html>

@@ index
  <div class="container">
    <div class='row'>
      <div class="col-md-6 col-md-offset-3">
        <img src="logo_two_layers.png" alt="Warwick coding logo" />
     </div>
    </div>

    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <ul>
          <li><a href="/payment_frontend">Front-End Course Payment</a></li>
          <li><a href="/payment_android_regular">Android Course Payment</a></li>
          <li></li>
        </ul>
    </div>
  </div>

@@ payment_android_regular
  <div class="row">
    <div class="col-md-2 col-md-offset-5">
      <form action="/chargeandroid" method="post" class="payment">
        <article>
          <label class="amount">
            <span>Android: £60.00</span>
          </label>
        </article>

        <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
                data-key="<%= settings.publishable_key %>"
                data-description="Android course"
                data-amount="6000"
                data-currency="gbp"
                data-locale="auto"></script>
      </form>
    </div>
  </div>

@@ payment_frontend
  <div class="row">
    <div class="col-md-2 col-md-offset-5">

      <form action="/chargefrontend" method="post" class="payment">
        <article>
          <label class="amount">
            <span>Front-end: £50.00</span>
          </label>
        </article>

        <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
                data-key="<%= settings.publishable_key %>"
                data-description="Frontend course"
                data-amount="5000"
                data-currency="gbp"
                data-locale="auto"></script>
      </form>

    </div>
  </div>

@@ chargeandroid
  <div class="container">
    <div class='row'>
      <div class="col-md-6 col-md-offset-3">
        <img src="logo_two_layers.png" alt="Warwick coding logo" />
      </div>
    </div>
    <div class="col-md-6 col-md-offset-3">
      <h2>Thanks, you paid <strong>£60.00</strong>!</h2>
    </div>
  </div>

@@ chargefrontend
  <div class="container">
    <div class='row'>
      <div class="col-md-6 col-md-offset-3">
        <img src="logo_two_layers.png" alt="Warwick coding logo" />
      </div>
    </div>
    <div class="col-md-6 col-md-offset-3">
      <h2>Thanks, you paid <strong>£50.00</strong>!</h2>
    </div>
  </div>
