--
-- PostgreSQL database dump
--

-- Dumped from database version 11.22 (Debian 11.22-0+deb10u2)
-- Dumped by pg_dump version 11.22 (Debian 11.22-0+deb10u2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: bloguser
--

INSERT INTO public.sites (id, host_name, css, header, footer, twitter_handle, title, inserted_at, updated_at, root_page, per_page, description) VALUES (2, 'sophia.red', '<style>
* {margin:0; padding:0;}
fieldset {border:0;}
.center {
        text-align: center;
}
ol,ul {list-style:none;}
a:active, a:focus {outline: 0;}
h1,h2,h3,h4,h5,h6,span {font-size:100%;font-weight:normal;}
body {
	font-family: Questrial, Carrois Gothic, Helvetica, Arial, sans-serif;

	font-weight: bold;
	font-size: 22px;
	color: #fff;
	background-color:#000;
	margin: 40px 0 20px 0;
	padding: 0;
	}
a, a:visited {
	color: #EEE;
	font-family: QuicksandBold, Helvetica, Arial, sans-serif;
	font-weight: bold;
	border-bottom:1px solid #ccc;
	text-decoration: none;
	}
a:hover {
	border-bottom:none;
	}
em, i {
	font-family: QuicksandBookOblique, Helvetica, Arial, sans-serif;
	font-style: italic;
	}
strong, b {
	font-family: QuicksandBold, Helvetica, Arial, sans-serif;
	font-weight: bold;
	}
strong em, strong i, b em, b i {
	font-family: QuicksandBoldOblique, Helvetica, Arial, sans-serif;
	font-weight: bold;
	font-style: italic;
	}
a#InstallThisTheme {
	background: url(http://static.tumblr.com/thpaaos/dHHkt0jor/install_theme.png);
	display: block;
	height: 20px;
	position: absolute;
	right: 2px;
	text-indent: -9999px;
	top: 26px;
	width: 96px;
	z-index: 5000;
	}
#Main {
	width: 900px;
	margin: 0 auto;
	padding: 8px 0 0 0;
	}
	#Header {}
		#Header .Title {
			padding: 0 0 10px 0;
			position: relative;
			}
			#Header .Title a.Title {
				width: 688px;
				color: #fff;
				font-size: 45px;
				line-height: 1;
				font-family: QuicksandBold, Helvetica, Arial, sans-serif;
				font-weight: bold;
				letter-spacing: 3px;
				text-decoration: none;
				border-bottom: 0px;
				}
		#Header .PageLinks {
			font-size: 14px;
			margin:5px 0 14px;
			height:1%;
			overflow:hidden;
			}
			#Header .PageLinks a {
				display:block;
				float:left;
				margin-right:14px;
				}
		#Header .Description {
			font-size: 14px;
			padding: 8px 0px 34px;
			}
			#Header .Description a {
				text-decoration: none;
				}
	.DynamicHeader {
		font-size: 30px;
		font-family:QuicksandBook, Helvetica, Arial, sans-serif;
		}
		.DynamicHeader span {
			font-family:QuicksandBold, Helvetica, Arial, sans-serif;
			font-weight: bold;
			}
	.post {
		margin: 20px 0px 0px 0px;
		line-height: 1.4;
		}
		.post img {
			max-width: 890px;
            max-height: 645px;
            margin: 10px 7px 0 7px;
			border: 3px solid white;
		}
		.post a.Title {
			display:block;
			line-height: 1.4;
			color: #fff;
			margin-bottom:22px;
			font-family:QuicksandBold, Helvetica, Arial, sans-serif;
			font-weight: bold;
			letter-spacing: 2px;
			text-transform:uppercase;
			text-decoration:none;
			border-bottom:0px;
		  	}
			.post a.Title:hover {
				text-decoration:underline;
				}
		.post.Single a.Title {
			margin-bottom:60px;
			}

	/* Generic post stuff */
	.post {
			font-size:70%;
			line-height:1.2;
			}
		.post a {
			color: #fff;
			border-bottom:1px solid #aaa;
			text-decoration: none;
			}
		.post a:hover {
			color: #707070;
			border-bottom:none;
			}
		.post p {
			margin:10px;
			}
		.post ul {
			list-style: disc outside;
			padding-left:20px;
			margin-bottom:22px;
			}
		.post ol {
			list-style: decimal outside;
			padding-left:20px;
			margin-bottom:22px;
			}
		.post small {
			font-size: 11px;
			line-height:11px!important;
			}
		.post blockquote {
			border-left: 1px solid #AAA;
			margin-left: 40px;
			padding-left: 12px;
			margin-bottom:22px;
			}
		.post .Bottom {
			color: #aaa;
			width: 100%;
			font-size: 12px;
			line-height: 1.5;
			margin-top:5px;
			}
			.post .Bottom .Reblog {
				float:left;
				margin-right:13px;
				}
			.post .Bottom span {
				padding: 0 13px 0 0;
				}
				.post .Bottom .Reblog span,
				.post .Bottom span.Notes a,
				.post .Bottom span.ShortUrl span,
				.post .Bottom span.Tags span  {
					text-transform: uppercase;
					padding-right:0;
					}
			.post .Bottom em {font-style: normal;}
			.post .Bottom a {
				color: #a5a5a5;
				font-family:QuicksandBook, Helvetica, Arial, sans-serif;
				}
			.post .Bottom a:hover {
				text-decoration: underline;
				color:#000;
				}
			.post .Bottom .Tags {
				display:block;
				}
		.post .PermaPageNotes a.NotesAnchor {
			border-bottom: none;
			text-decoration: none;
			}
		ol.notes {
			width: 100%;
			border-bottom: solid 1px #ccc;
			padding: 48px 0 0 0px;
			margin: 8px 0px 0px 0px;
			list-style-type: none;
			}
			ol.notes a { color: #444444; }
			ol.notes li.note {
				color: #777;
				font-size: 10px;
				border-top: solid 1px #ccc;
				padding: 4px;
				}
				ol.notes li.note img.avatar {
			    vertical-align: -4px;
			    margin-right: 10px;
			    width: 16px;
			    height: 16px;
				}
				ol.notes li.note span.action { margin-bottom: 5px; }
				ol.notes li.note blockquote {
					border-color: #eee;
					padding: 4px 10px;
					margin: 10px 0px 0px 25px;
					}
					ol.notes li.note blockquote a { text-decoration: none; }
				ol.notes li.note a:hover { text-decoration: underline; }
	#Footer {
		padding: 20px 0 8px;
		font-size: 12px;
		color: #8E8E8E;
		line-height: 1.5em;
		overflow: hidden;
		}
		#Footer a {
			color: #b0b0b0;
			font-weight: bold;
			margin-right:10px;
			text-transform: uppercase;
			text-decoration: none;
			}
		#Footer .UtilityLinks {
			width:67%;
			float:left;
			height:20px;
			}
		#Footer .Pagination {
			width:33%;
			float:right;
			text-align: right;
			height:20px;
			}
			#Footer .Numeration {
				padding-right:12px;
				}
		#Footer .Search {
			clear:both;
			padding-top:24px;
			padding-bottom:20px;
			}
			#Footer form input.Text {
				width: 278px;
				}
		#Footer .Hints {
			font-size: 14px;
			padding-bottom:14px;
			}
		#Footer .Colophon {
			font-size: 12px;
			line-height: 1;
			padding-bottom:14px;
			}
		#Footer .Colophon a {
			color: #888;
			margin-right:0;
			}
/* iPhone */
@media screen and (max-device-width: 481px) {
	#Header .Title a.Title {font-size:2.2em; -webkit-text-stroke-width: 1px; -webkit-text-stroke-color: #222;}
	.post .postBody {font-size:1.3em; }
}
/* End iPhone */
@media print {
	body {
		color:black;
		font-size:12pt;
		line-height:24pt;
		padding:20px 40px 40px 40px;
		}
	body * {
		font-family: "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
		float:none;
		}
	#Main {
		width:auto;
		margin:5%;
		padding:0;
		}
	#Header,
	#Pagination,
	#Footer,
	.post .Bottom .PrintpostLink,
	.post .Bottom .Notes,
	.post .Bottom .Words,
	.post .Bottom .Tags,
	#InstallThisTheme,
	#tumblr_controls {display:none!important;}
	.post {
		margin:0px!important;
		page-break-after: always;
		}
	.post.Single {
		page-break-after:auto;
		}
	.post a.Title {margin-top:20px!important;}
}
</style>
', '<div id="Main">
		<div id="Header">
			<div class="Title">
				<a href="http://sophia.red" class="Title">Photo Unrelated</a>
			</div>
				<div class="PageLinks" style="display: none; ">
				</div>
			<div class="Description">
				This is Sophia''s Blog. Stuff and Things.
			</div>
		</div>', '<div id="Footer">
			<div class="UtilityLinks">
				<a href="#" title="/archive">Archive</a>
				<a href="#" title="">RSS</a>
			</div>
			<div class="Colophon">
			</div>
		</div>', '@sophista_h', 'Sophia''s pictures', '2020-06-27 08:25:48', '2020-06-28 05:52:53', NULL, 5, NULL);
INSERT INTO public.sites (id, host_name, css, header, footer, twitter_handle, title, inserted_at, updated_at, root_page, per_page, description) VALUES (4, 'mills.studio', ' <style>
.grid_post img {max-width: 100%;}
.grid_post {
  display: grid;
  grid-template-columns: 33% 33% 33%;
}

.grid_cell {
  margin: 10px;

}



:root{
    /* --blue: #053f5e;
    --middle-blue: #053f5e;
    --light-blue: #115173;
    --yellow: #ffd700;
    --orange: #ea6227;
    --light-orange: #f2a51a;
    --green: #b9ebcc; */
  --blue: #a3a3a4;
  --middle-blue: #00028c;
  --light-blue: #6b76ff;
  --yellow: #000;
  --orange: #fd5f00;
  --light-orange: #f2a51a;
  --green: #000;

}
body {
  margin: auto;
  width: 78%;
  max-width: 2500px;
  padding: 10px;
  font-family: Helvetica Neue, Arial;
  color: black;
  line-height:1.4;
  text-align: right;
}

#header div {
  text-align: right;
}

div .image_editor {
  text-align: left;
}

div .post_editor {
  text-align: left;
}

form {
  text-align: left;
}

textarea {
  font-size: 1.3em;
  font-family: Georgia, serif;
  max-width: 100%;
}

p {
  font-family: Times, serif;
  font-size: 1.3em;
  line-height: 1.3;
  max-width: 30em;
  margin-left: auto;
  margin-right: 3vw;
  text-align: left;
}

li {
  font-family: Times, serif;
  font-size: 1.3em;
  line-height: 1.3;
  max-width: 30em;
  margin-left: auto;
  margin-right: 3vw;
  margin-bottom: 1em;
  text-align: left;
}


blockquote { margin-left: auto; margin-right: -3em; border-left: 10px solid var(--middle-blue); max-width: 45em;}
blockquote p { max-width: 100%; margin-left: 10px; }

h1 {text-align: center;}

h2 {
    font-size: 2em;
  }

h6 { 
  font-size: 2.5em; 
  margin: .2em;
}

img {
  max-width: 100%;
  max-height: 85vh;
}

a:link {
  color: var(--middle-blue);
  text-decoration: none;
}

/* visited link */
a:visited {
  color: var(--blue);
  text-decoration: none;
}

/* mouse over link */
a:hover {
  color: var(--orange);
  text-decoration: none;
}

/* selected link */
a:active {
  color: (--light-blue);
}



.footer img {
  width: auto;
}

/* @media only screen and (max-width: 800px) {
  body { width: 98% }
  p { font-size: 1em; margin:0; }
} */

tr:nth-child(odd) {
  background: #eee;
}

@media only screen and (max-width: 900px) {
  body { width: 96% }
  p { font-size: 1em; }
}


@media only screen and (max-width: 1200px) {
  p { font-family: Times, serif;
  font-size: 1em;
  line-height: 1.3;
  margin-left: auto;
  margin-right: 1vw;
  text-align: left; }
  img { max-width: 100%; max-height: 95vh; }
  
    blockquote { margin:0; margin-left: auto; max-width:30em;}
    blockquote p { max-width: 100%; margin-left: 10px; }
}

</style>', '<h2><a href="https://mills.studio">Mills Studio</a></h2>', '<h4><a href="https://mills.studio/materials">Materials</a> // <a href="https://mills.studio/design_philosophy">Philosophy</a>
// <a href="mailto:matt@mills.studio?subject=Sales Inquiry">Inquiries</a></h4>', 'mills_bags', 'Mills Studio', '2020-12-04 01:26:29', '2021-03-04 09:04:27', 'grid', 16, 'Custom Camera Bags and specialty gear');
INSERT INTO public.sites (id, host_name, css, header, footer, twitter_handle, title, inserted_at, updated_at, root_page, per_page, description) VALUES (1, 'matt.pictures', '<style>



:root{
    /* --blue: #053f5e;
    --middle-blue: #053f5e;
    --light-blue: #115173;
    --yellow: #ffd700;
    --orange: #ea6227;
    --light-orange: #f2a51a;
    --green: #b9ebcc; */
  --blue: #a3a3a4;
  --middle-blue: #00028c;
  --light-blue: #6b76ff;
  --yellow: #000;
  --orange: #fd5f00;
  --light-orange: #f2a51a;
  --green: #000;

}


.images-grid img {max-width: 100%;}
.images-grid {
  display: grid;
  grid-template-columns: 20% 20% 20% 20% 20%;
}


.images-grid-cell {
  margin: .2em;
}

body {
  margin: auto;
  width: 78%;
  max-width: 2000px;
  border: 0px solid var(--yellow);
  padding: 10px;
  font-family: Helvetica Neue, Arial;
  color: black;
  line-height:1.4;
  text-align: right;
}

#header div {
  text-align: right;
}

div .image_editor {
  text-align: left;
}

div .post_editor {
  text-align: left;
}

div .caption  {
    text-align: center;
    margin-top: -2em;
    font-style: italic;
    font-size: 80%;
}

form {
  text-align: left;
}

textarea {
  font-size: 1.3em;
  font-family: Georgia, serif;
  max-width: 100%;
}

p {
  font-family: Times, serif;
  font-size: 1.3em;
  line-height: 1.3;
  max-width: 37em;
  margin-left: auto;
  margin-right: 3vw;
  text-align: left;
}

li {
  font-family: Times, serif;
  font-size: 1.3em;
  line-height: 1.3;
  max-width: 30em;
  margin-left: auto;
  margin-right: 3vw;
  text-align: left;
}


blockquote { margin-left: auto; margin-right: -3em; border-left: 10px solid var(--middle-blue); max-width: 45em;}
blockquote p { max-width: 100%; margin-left: 10px; }

h1 {text-align: center;}

h2 {
    font-size: 2em;
    border-bottom: 5px solid black;
  }

h6 { 
  font-size: 2.5em; 
  margin: .2em;
}

img {
  max-width: 100%;
  max-height: 85vh;
}

a:link {
  color: var(--middle-blue);
  text-decoration: none;
}

/* visited link */
a:visited {
  color: var(--blue);
  text-decoration: none;
}

/* mouse over link */
a:hover {
  color: var(--orange);
  text-decoration: none;
}

/* selected link */
a:active {
  color: (--light-blue);
}



.footer img {
  width: auto;
}

/* @media only screen and (max-width: 800px) {
  body { width: 98% }
  p { font-size: 1em; margin:0; }
} */

tr:nth-child(odd) {
  background: #eee;
}

@media only screen and (max-width: 900px) {
  body { width: 96% }
  p { font-size: 1em; }
  li { font-size: 1em; }
}


@media only screen and (max-width: 1200px) {
  p { font-family: Times, serif;
  font-size: 1em;
  line-height: 1.3;
  margin-left: auto;
  margin-right: 1vw;
  text-align: left; }
   li { font-family: Times, serif;
  font-size: 1em;
  line-height: 1.3;
  margin-left: auto;
  margin-right: 1vw;
  text-align: left; }
  img { max-width: 100%; max-height: 95vh; }
  
    blockquote { margin:0; margin-left: auto; max-width:30em;}
    blockquote p { max-width: 100%; margin-left: 10px; }
}





</style>', '<div id="page">
      <div class="content">
        <div id="header">
          <div id="top">
            <h6><a href="/" class="title">matt.pictures</a></h6>
          </div>
          <div id="bottom">
            <div class="buttons">

              <a href="http://matt.pictures/rss">RSS</a> /
              <a href="https://photog.social/@Matt">Toots</a> /
              <a href="https://matt.pictures/portfolio">Portfolio</a> /
              <a href="mailto:sunrisetimes@gmail.com">email me</a> /

             </div>
          </div>
        </div>', '<div id="footer" class="footer">
      <p>Copyright &copy; 2008-Forever, Matt Mills.<br /></p>
      <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
    </div>
  </div>
</div>', '@photomattmills', 'matt''s pictures', '2020-04-04 09:23:34', '2023-02-15 09:24:33', NULL, 5, NULL);


--
-- Name: sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bloguser
--

SELECT pg_catalog.setval('public.sites_id_seq', 4, true);


--
-- PostgreSQL database dump complete
--

