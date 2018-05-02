class SearchController < ApplicationController
    def search
        @root_posts  = RootPost.ransack(body_cont: params[:q], 
                                        subject_cont: params[:q], 
                                        id_eq: params[:q], 
                                        m: 'or').result(distinct: true)
        @child_posts = ChildPost.ransack(body_cont: params[:q], 
                                        id_eq: params[:q], 
                                        m: 'or').result(distinct: true)

        respond_to do |format|
            format.html {}
            format.json {
                @root_posts.limit(5)
                @child_posts.limit(5)
            }
        end
    end
end
