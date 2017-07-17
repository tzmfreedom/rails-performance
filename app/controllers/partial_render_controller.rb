class PartialRenderController < ApplicationController
  def index
    @contents = Content.limit(params.fetch(:size, 1000)).to_a
    case params[:type]
      when 'single'
        render :single and return
      when 'collection'
        render :collection and return
    end
  end
end