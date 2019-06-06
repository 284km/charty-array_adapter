require "charty/array_adapter/version"
require "charty/plotter_adapter"
require "charty/plotter"

module Charty
  module ArrayAdapter
    class Error < StandardError; end
    # Your code goes here...
  end
end

class Array
  def plotter
    @plotter_adapter
  end
  def plotter=(adapter_name)
    @adapter_name = adapter_name
    @plotter_adapter =  Charty::PlotterAdapter.create(adapter_name)
  end
  def to_bar(x, y, **args, &block)
    seriesx, seriesy = *self
    xrange = (seriesx.min)..(seriesx.max)
    yrange = (seriesy.min)..(seriesy.max)
    bar = bar do
      series seriesx, seriesy
      range x: xrange, y: yrange
      xlabel x
      ylabel y
    end
  end
  def bar(**args, &block)
    context = Charty::RenderContext.new :bar, **args, &block
    context.apply(@plotter_adapter)
  end
end

