defmodule Exblog.ImporterTest do
  use Exblog.DataCase

  alias Exblog.Importer
  alias Exblog.Blog
  alias Exblog.Blog.Post

  @images ["IMG_0694.JPG", "0001.jpg", "0002.jpg", "0004.jpg", "0005.jpg"]

  describe "import_post" do
    setup do
      Application.put_env(:exblog, :image_uploader, FakeUploader)

      {:ok, post} =
        Meeseeks.parse(
          ~s{<item> <title>the inherent problems of sunsets</title> <description> &lt;p&gt;Yes, a post full of sunsets. This was also mid-september, around when my parents were here. The second one is a stitched pano, from two images. At least I’m not committing the sin of HDR.&lt;/p&gt; &lt;p&gt;There &lt;em&gt;are&lt;/em&gt; some problems with sunsets. First of all, they’re cliché. Like, forever and ever. Second, they’re the sort of thing anyone can look at and take a picture of that works. You look at a thousand of them, and there’s this dull sameness that’s like looking at glitter. Pretty, but not, you know, rising to the task of making &lt;em&gt;art&lt;/em&gt; most of the time. (note here that I’m talking about my personal definition of art and artmaking, you do you boo).&lt;/p&gt; &lt;p&gt;BUT. There’s definitely a part of me that thinks all of that is bullshit, and shoots sunsets anyway (sometimes just on my phone, trying to pretend I’m not serious about it). Cliche? That’s just something a jaded person says because they can’t admit something can be nice without being impossibly niche and unheard-of.&lt;/p&gt; &lt;p&gt;AND. “A picture anyone could take.” But no, not anyone did; I was there. I chose this exposure, this framing. I chose a place to stand and took the picture just when the sun hit the top of the clouds. Every picture, moment to moment, place to place, is unique. Sometimes all I want to say with a photo is: “This is where I was, and this is what I saw.” It’s not enough to be taken seriously in some circles, but I’m fine with that. Not every picture is the cover of NatGeo or the New York Times; none of these, I suspect, will ever hang on a gallery wall.&lt;/p&gt; &lt;p&gt;Anyway, it’s a complex subject and I’ve just barely scratched the surface. There are probably much more interesting photos to be made (my favorite of these is definitely the first one, which is not really a sunset picture). Maybe I should learn the lesson of the photography workshop I just went to and limit myself to one picture? I do need to be doing tighter edits in general. No more 30 picture posts.&lt;/p&gt; &lt;p&gt;&lt;span style="display:block;" class="center"&gt; &lt;img src="https://photomattmills.com/images/lots-of-sunsets/0001.jpg" alt="" /&gt; &lt;span class="caption"&gt;&lt;/span&gt; &lt;img src="https://photomattmills.com/images/lots-of-sunsets/0002.jpg" alt="" /&gt; &lt;span class="caption"&gt;&lt;/span&gt; &lt;img src="https://photomattmills.com/images/before-the-ok-trip/IMG_0694.JPG" alt="" /&gt; &lt;span class="caption"&gt;&lt;/span&gt; &lt;img src="https://photomattmills.com/images/lots-of-sunsets/0004.jpg" alt="" /&gt; &lt;span class="caption"&gt;&lt;/span&gt; &lt;img src="https://photomattmills.com/images/lots-of-sunsets/0005.jpg" alt="" /&gt; &lt;span class="caption"&gt;&lt;/span&gt; &lt;/span&gt;&lt;/p&gt; </description> <pubdate>2019-12-04T07:47:00+00:00</pubdate> <guid>/2019/12/03/the-inherent-problems-of-sunsets.html</guid> <link />/2019/12/03/the-inherent-problems-of-sunsets.html </item>}
        )
        |> Importer.import_post()

      %{post: post |> Repo.preload(:images)}
    end

    test "creates a blog.post" do
      assert %Post{} = Blog.get_post_by_slug!("the_inherent_problems_of_sunsets")
    end

    test "adds the post images to the image table", %{post: post} do
      assert length(post.images) == 5
    end

    test "removes images from tmp after copy" do
      for image <- @images do
        refute File.exists?("/tmp/#{image}")
      end
    end
  end
end
