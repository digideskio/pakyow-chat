Pakyow::App.routes do
  default do
    redirect router.group(:message).path(:list)
  end

  restful :message, '/messages' do
    list do
      view.partial(:form).scope(:message).bind({})
      view.partial(:list).scope(:message).mutate(:list, with: data(:message).all).subscribe

      # rather than subscribing the mutation, you could also subscribe the component
      # view.component(:chat).subscribe
    end

    create do
      message = data(:message).create(params[:message])

      # example of sending an instruction directly to a subscribed component
      # ui.component(:chat).scope(:message).prepend(message)

      # example of sending a custom payload to a subscribed component
      # ui.component(:chat).push(:received)

      redirect router.group(:message).path(:list)
    end
  end
end
