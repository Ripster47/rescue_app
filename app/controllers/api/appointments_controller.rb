class Api::AppointmentsController < ApplicationController

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
      client = Signet::OAuth2::Client.new(client_options)

      client.code = params[:code]

      response = client.fetch_access_token!
      p "*" * 100
      p "*" * 100
      p response
      p "*" * 100
      p "*" * 100

      exp_time =  CGI.escape(response["expires_in"].to_i.seconds.from_now.to_s)

      uri_encoded_rt = CGI.escape(response["refresh_token"])

      redirect_to "http://localhost:8080/catch/#{response["access_token"]}/#{response["expires_in"]}/#{uri_encoded_rt}/#{exp_time}"
  end


  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists


    rescue Google::Apis::AuthorizationError
      response = client.refresh!

      session[:authorization] = session[:authorization].merge(response)

    retry
    
  end

  def events
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event_list = service.list_events(params[:calendar_id])
    
  end

  def new_event
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(session[:authorization])

      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client

      today = Date.today

      event = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
        end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
        summary: 'New event!',
        attendees: [{
                      email: submission.user.email
                      }]
      })

      service.insert_event(params[:calendar_id], event)

      redirect_to "/api/google/events/#{params[:calendar_id]}"
    end



  private

  def client_options
    {
      client_id: ENV['CALENDAR_CLIENT_ID'],
      client_secret:ENV['CALENDAR_CLIENT_SECRET'],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: 'http://localhost:3000/api/google/callback'
    }
  end



end
