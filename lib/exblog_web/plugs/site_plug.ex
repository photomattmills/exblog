defmodule ExblogWeb.SitePlug do
  def init(options), do: options

  def call(conn, _default) do
    site = Exblog.Repo.get_by(Exblog.Domain.Site, host_name: conn.host) || default_site(conn)

    Plug.Conn.assign(conn, :site, site)
  end

  def default_site(conn) do
    %{
      id: 1,
      host_name: conn.host,
      css: default_css(),
      header: default_header(),
      footer: default_footer(),
      twitter_handle: "@photomattmills",
      title: "matt's pictures"
    }
  end

  def default_css do
    ~s|<style>
    body {
      margin: auto;
      width: 70%;
      /* border: 3px solid green; */
      padding: 10px;
      font-family: Roboto, "Helvetica Neue", Arial;
      color:black;
      line-height:1.4
    }

    p {
      font-family: Georgia, serif;
      font-size: 1.3em;
      line-height: 1.5;
      max-width: 33em;
      margin-left: 2em;
    }

    img {
      width: 100%;
    }

    .footer img {
      width: auto;
    }

    @media only screen and (max-width: 800px) {
      body { width: 98% }
      p { font-size: 1em; margin:0; }
    }</style>|
  end

  def default_header do
    ~s| <div id="page">
      <div class="content">
        <div id="header">
          <div id="top">
            <a href="/" class="title">matt.pictures</a>
          </div>
          <div id="bottom">
            <div class="buttons">

              <a href="https://patreon.com/user?u=738372">Patreon</a>
              <a href="http://matt.pictures/rss">RSS</a>
              <a href="http://instagram.com/photomattmills">Instagram</a>
              <a href="http://matt.pictures/portfolio">Portfolio</a>
              <a href="mailto:sunrisetimes@gmail.com">email me </a>
             </div>
          </div>
        </div>|
  end

  def default_footer do
    ~s|<div id="footer" class="footer">
      <p>Copyright &copy; 2008-Forever, Matt Mills.<br /></p>
      <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
    </div>
  </div>
</div>
|
  end
end
