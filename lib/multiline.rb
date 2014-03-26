Dragonfly.app.configure do
  generator :multiline do |content, text, opts={}|
    args  = []
    drivers = ["mike", "bob","jim"]
    drivers_string = compose_driver_string(drivers)
    font_size = (opts['font_size'] || 12).to_i
    background = opts['background_color'] || 'none'

    # Settings
    args.push("-gravity NorthWest")
    args.push("-antialias")
    args.push("-pointsize #{font_size}")
    args.push("-font \"#{opts['font']}\"") if opts['font']
    #args.push("-family '#{opts['font_family']}'") if opts['font_family']
    args.push("-fill #{opts['color']}") if opts['color']
    args.push("-stroke #{opts['stroke_color']}") if opts['stroke_color']
    args.push("-background #{background}")
    args.push("label:'#{text}'")

    content.generate!(:convert, args.join(' '), 'png')
    content.add_meta('format' => 'png', 'name' => "text.png")
  end

  def compose_driver_string(drivers)
    string = ""
    drivers.each do |driver|
      string << "mike \n"
    end
    string
  end
end
