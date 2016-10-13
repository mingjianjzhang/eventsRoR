class EventsController < ApplicationController
  def dashboard
  	@user = User.find(session[:user_id])
  	@localevents = Event.with_owner("events.state == '#{@user.state}'")
  	@distantevents = Event.with_owner("events.state != '#{@user.state}'")
  	@joined_events = @user.joined_events.ids
  end


  def show
  	@event = Event.with_owner("events.id = #{params[:id]}")[0]
  	@joiners = Event.find(params[:id]).event_joiners
  	@comments = Event.find(params[:id]).comments
  end

  def edit
  	@event = Event.find(params[:id])
  	@joiners = @event.event_joiners
  	@comments = @event.comments
  end

  def create
  	# render json: event_params
  	event = Event.new(event_params)
  	if event.save  	  
  	  redirect_to :back
  	else
  	  flash[:errors] = event.errors.full_messages
  	  redirect_to :back
  	end
  end
  def update
  	event = Event.find(params[:id])
  	if event.update(event_params)
  	  flash[:success] = "Event successfully updated"
  	  redirect_to :back
  	else 
      flash[:errors] = event.errors.full_messages
      redirect_to :back
    end
  end
  def destroy

  end
  def cancel
    EventUser.destroy()
  end
  def join
  	EventUser.create(join_params)
  	redirect_to :back
  end
  def create_comment
  	comment = Comment.new(comment_params)
  	if comment.save
  	  redirect_to :back
  	else
  	  flash[:error] = comment.errors.full_messages[0]
  	  redirect_to :back
  	end
  end
  private

  def event_params
  	params.require(:event).permit(:name, :date, :city, :state, :owner_id)
  end
  def join_params
  	params.require(:eventuser).permit(:user_id, :event_id)
  end
  def comment_params
  	params.require(:comment).permit(:user_id, :event_id, :text)
  end
end
