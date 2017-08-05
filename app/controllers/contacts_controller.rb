class ContactsController < ApplicationController
  def new
  @contact = Contact.new
  # creates a blank object {name: , email: , comments: }
  end
  def create
    @contact = Contact.new(contact_params) 
    # {name:Madhu, email:madhu.mishra@gmail.com, comment:hi}
    if @contact.save
      flash[:success] = "Message sent"
      redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(",")
      # flash = {key: value, key: value}
      redirect_to new_contact_path
      
    end
  end
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end