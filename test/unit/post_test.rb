require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def tests_creating_a_comments_with_posts_increments_counter
    post = Post.create! :title => 'foo'
    Comment.create! :text => 'foo', :post => post
    post.reload

    assert_equal 1, post.comments_count
  end

  def tests_creating_a_comments_with_posts_increments_counter_using_push
    post = Post.create! :title => 'foo'
    post.comments << Comment.create!(:text => 'foo')
    post.reload

    assert_equal 1, post.comments_count
  end

  def test_destroy_a_comment_decrements_counter
    post = Post.create :title => 'foo'
    comment = Comment.create! :text => 'foo', :post => post
    post.reload

    assert_equal 1, post.comments_count

    comment.destroy
    post.reload

    assert_equal 0, post.comments_count
  end

  def test_changing_a_comments_post_updates_the_counter
    rails_post = Post.create! :title => 'Rails'
    sinatra_post = Post.create! :title => 'Sinatra'

    comment = rails_post.comments.create! :text => 'foo'

    rails_post.reload

    assert_equal 1, rails_post.comments_count
    assert_equal 0, sinatra_post.comments_count

    comment.post = sinatra_post
    comment.save!

    rails_post.reload
    sinatra_post.reload

    assert_equal 0, rails_post.comments_count
    assert_equal 1, sinatra_post.comments_count
  end
end
