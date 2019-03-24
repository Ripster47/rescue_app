class Api::AppointmentsController < ApplicationController

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
      client = Signet::OAuth2::Client.new(client_options)
      client.code = params[:code]
      response = client.fetch_access_token!

      exp_time =  CGI.escape(response["expires_in"].to_i.seconds.from_now.to_s)
      uri_encoded_rt = CGI.escape(response["refresh_token"])

      redirect_to "http://localhost:8080/catch/#{response["access_token"]}/#{exp_time}/#{uri_encoded_rt}"
  end


  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(
                      {
                        "access_token" => params[:at_google], 
                        "expires_in" => 3600, 
                        "refresh_token" => params[:rt_google], 
                        "scope"=>"https://www.googleapis.com/auth/calendar", 
                        "token_type"=>"Bearer"
                      }
                    )

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
    client.update!(
                      {
                        "access_token" => params[:at_google], 
                        "expires_in" => 3600, 
                        "refresh_token" => params[:rt_google], 
                        "scope"=>"https://www.googleapis.com/auth/calendar", 
                        "token_type"=>"Bearer"
                      }
                    )

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event_list = service.list_events("mpolinski12@gmail.com")
    
  end

  def new_event
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(
                        {
                          "access_token" => params[:at_google], 
                          "expires_in" => 3600, 
                          "refresh_token" => params[:rt_google], 
                          "scope"=>"https://www.googleapis.com/auth/calendar", 
                          "token_type"=>"Bearer"
                        }
                      )

      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client

      start_time = Time.parse(params[:start_time])
      submission = Submission.find(params[:submission_id])
      user = submission.user

      event = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time.strftime("%Y-%m-%eT%H:%M:%S.000-06:00")),
        end: Google::Apis::CalendarV3::EventDateTime.new(date_time: (start_time + 5.minutes).strftime("%Y-%m-%eT%H:%M:%S.000-06:00")),
        # 2019-03-08T19:30:00.000-06:00
        summary: "Adoption time!",
        attendees: [{
                      email: user.email,
                      displayName: user.full_name
                      }],
        sendUpdates: "all"
      })

      service.insert_event("mpolinski12@gmail.com", event)

      render json: {message: "calendar event request sent"}
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
