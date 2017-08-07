class ContactsController < ApplicationController
  def new
  @contact = Contact.new
  # creates a blank object {name: , email: , comments: }
  end
  def create
    @contact = Contact.new(contact_params) 
    # {name:Madhu, email:madhu.mishra@gmail.com, comment:hi}
    if @contact.save
      # params = { :contact => { :name => "Sonu", :email => 'sonu@gmail.com', :body => "whatever"}}
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver      flash[:success] = "Message sent"
      redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(",")
      # flash = {type: msg, type: msg}
      # flash = {danger:"name can't be blank, email can't be blank....",
      #           success: "Message sent}"
      
      redirect_to new_contact_path
      
    end
  end
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end