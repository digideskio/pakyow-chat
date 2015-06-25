Pakyow::App.routes do
  default do
    redirect router.group(:message).path(:list)
  end

  restful :message, '/messages' do
    list do
      view.partial(:form).scope(:message).bind({})
      view.partial(:list).scope(:message).mutate(:list, with: data(:message).all)#.subscribe

      view.component(:chat).subscribe
    end

    create do
      message = data(:message).create(params[:message])

      # ui.component(:chat).push {
      #   scope(:message).prepend(message)
      # }

      #TODO auto push when an action is fired (e.g. `prepend`)
      #TODO pass qualifiers to `component`
      #TODO implement `insert`
      ui.component(:chat).scope(:message).prepend(message)

      #TODO make custom messaging work
      # ui.component(:chat).push(:foo)

      redirect router.group(:message).path(:list)
    end
  end
end
