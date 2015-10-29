namespace :posts do
  desc "TODO"
  task delete_if_old: :environment do
    Post.all.each do | post |
      post.delete_if_old
    end
  end
end
