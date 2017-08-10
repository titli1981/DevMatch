class ContactsController < ApplicationController
  
  # GET request to/contact-us
  # Show new contact form
  def new
  @contact = Contact.new
  # creates a blank object {name: , email: , comments: }
  end
  
  # POST request /contacts
  def create
    # Mass assignment of form fields into Contact object
    @contact = Contact.new(contact_params) 
    # {name:Madhu, email:madhu.mishra@gmail.com, comment:hi}
    # Save the cotact object to the databse
    if @contact.save#
      # Store form fields via parameters, into variables
      # params = { :contact=>{:name=>"Madhu", :email=>"madhu@gmail.com, :body:=>"whatever"}}
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact]
      # Plug variable into contact Mailer
      # email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Store success msg in flash hash
      # and redirect to the new action
      flash[:success] = "Message sent"
      redirect_to new_contact_path
    else
      # If contact object does not ssave 
      # store errors in flash hash,
      # and redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(",")
      # flash = {type: msg, type: msg}
      # flash = {danger:"name can't be blank, email can't be blank....",
      #           success: "Message sent}"
      
      redirect_to new_contact_path
    end
  end
  
  private
    # To collect data from, we need to use 
    # strong parameters and whitelist the form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end