require File.expand_path('../app/setup', __FILE__)

class Rack::Lint::HijackWrapper
  def <<(*args)
    write(*args)
  end
end

app = Pakyow::App
app.builder.run(app.stage(:development))
run app.builder.to_app
