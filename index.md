<html>
<head>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Dan Tombs + Video + Visuals</title>
    <link type="text/plain" rel="author" href="/humans.txt" />
    <meta name="keywords" content="dan tombs circuit bending live visuals vj glitch norwich pixel vision PXL 2000 nathan fake luke abbott border community factory floor jon hopkins walls transept notown gold panda will dutta perc tim burgess east india youth synthesis final cut pro certified trainer">
	<style>
	html, body, ul, li {
		padding: 0;
		margin: 0;
	}
	body {
		-webkit-font-smoothing: none;
		font-smoothing: none;
		background-color: white;
		font-size: 15vw;
		-webkit-overflow-scrolling: touch;
	}
	#bg-image {
		position: absolute;
		top: 0;
		left: 0;
		height: 500%;
		width: auto;
		min-width: 100%;
		image-rendering: pixelated;
        z-index: 0;
	}
	@media only screen and (orientation: landscape) {
		body {
			font-size: 15vh;
		}
		#bg-image {
			width: 500%;
			height: auto;
			min-height: 100%;
		}
	}
	#stuff {
		position: fixed;
        top: 0;
        left: 0;
		width: 100vw;
        z-index: 1;
	}
    #info, #info h1 {
        font-weight: normal;
		font-size: 1rem;
        color: white;
        text-shadow: 1px 1px 0px black, -1px -1px 0px black;
    }
	#info {
		position: fixed;
	    top: 0;
	    left: 0;
	    z-index: 1;
	    width: 50vw;
	    transform: skew(0, 0);
	}
	#info.skew {
		transform: skew(0deg, 80deg);
	}
	#links {
		position: relative;
		list-style: none;
	}
	.link {
		float: left;
	}
	a {
		color: black;
		text-decoration: none;
		display: inline-block;
		text-transform: lowercase;
		margin: .1em .1em .5em 0;
		padding: 0.1em 0.3em 0 0.2em;
		line-height: 0.7em;
		background-color: white;
	}
	a:hover {
		background-color: black;
		color: white;
	}
	</style>
</head>

<body>
    <section id="info">
        <h1>Dan Tombs + Video + Visuals</h1>
        <p>Obsolete, distorted, glitch(ed) and maligned across moving image, photography and design.</p>
        <p>Music video production, live video performances (VJ) for festivals, galleries and club nights. </p>
        <p>Mutek (CA), Sonar (ES), Bloc (UK), Semibreve Festival (PT), MiRA (ES), Nachdigital (DE), Bozar (BEL), Melkweg (NL), LEV (ES).</p>
        <p>Current collaborations with Jon Hopkins, East India Youth, Factory Floor, Gold Panda, Luke Abbott, Perc, Walls and Tim Burgess.</p>
        <p>Visiting lecturer on Film and Moving Image production at Norwich University of the Arts and Associate lecturer at University of East Anglia, School of Music.</p>
    </section>
	<section id="stuff" style="display:none;">
		<ul id="links">
			<li class="link shake-hard shake-constant"><a href="https://twitter.com/dantombs">@dantombs</a></li>
			<li class="link shake-hard shake-constant"><a href=".">Commisions</a></li>
			<li class="link shake-hard shake-constant"><a href=".">Showreel</a></li>
			<li class="link shake-hard shake-constant"><a href=".">Interviews</a></li>
			<li class="link shake-hard shake-constant"><a href=".">Work</a></li>
			<li class="link shake-hard shake-constant"><a href=".">Buy prints</a></li>
			<li class="link shake-hard shake-constant"><a href="mailto:info@dantombs.net">email</a></li>
		</ul>
	</section>
    <script>
        var _gaq = [
            ['_setAccount', 'UA-12705318-1'],
            ['_trackPageview']
        ];
        (function(d, t) {
            var g = d.createElement(t),
                s = d.getElementsByTagName(t)[0];
            g.src = ('https:' == location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g, s)
        }(document, 'script'));
        (function (bgImages) {
            var bgImage = new Image();
            bgImage.id = 'bg-image';
            bgImage.src = bgImages[Math.floor(Math.random() * bgImages.length)];
            bgImage.alt = '';
            bgImage.onload = function () {
                window.onload = function () {
                    window.setTimeout(function() { // make it work on iOS
                        document.getElementById('stuff').style.display = 'block';
                        document.getElementById('info').classList.add("skew");
                        window.scrollTo((bgImage.width / 2 - window.innerWidth / 2), (bgImage.height / 2 - window.innerHeight / 2))
                    }, 0);
                }
            }
            document.body.appendChild(bgImage);
        })([
    		{% assign image_files = site.static_files | where: "image", true %}
    		{% for myimage in image_files %}
    			'{{ myimage.path }}',
    		{% endfor %}
        ]);
    </script>
</body>
</html>
