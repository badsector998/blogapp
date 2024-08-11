class ApplicationController < ActionController::Base
    before_action :set_tags

    private
    def set_tags
        @tags = Tag.all
    end
end
