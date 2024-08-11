class ArticlesController < ApplicationController
    http_basic_authenticate_with name:"rlfpr", password: "secret", except: [:index, :show]
    before_action :new_article_path, only: [:show, :edit, :update, :destroy]

    def index
        @articles = Article.page(params[:page]).order(created_at: :desc)
        @featured = Article.featured
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.tags = process_tags(params[:article][:tags])

        if @article.save
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        tags_string = params[:article][:tags]
        processed_tags = process_tags(tags_string)

        @article = Article.find(params[:id])
        @article.tags = processed_tags

        if @article.update(article_params)
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path, status: :see_other
    end

    private
        def article_params
            params.require(:article).permit(:title, :body, :status, :featured, :image)
        end

        def process_tags(tags_string)
            return [] if tags_string.blank?

            tag_names = tags_string.split(',').map(&:strip).uniq
            tag_names.map { |name| Tag.find_or_create_by(name: name) }
        end
end