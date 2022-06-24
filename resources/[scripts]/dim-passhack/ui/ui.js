let prompt = null
let done = false

window.addEventListener('message', function (event) {
    if ( event.data.type === "show" ) {

		let timer = 0
		done = false

		$("#passhack-input").show()
		$("#passhack-hint").show()
		$("#prog-bar").show()

		// Ugly way of doing this but it'll work for now
		switch (event.data.diff) {
			case 1:
				prompt = getRandomIntInRange(1000, 9999)
				timer = 1000
				break;
				
			case 2:
				prompt = getRandomIntInRange(10000, 99999)
				timer = 1500
				break;

			case 3:
				prompt = getRandomIntInRange(100000, 999999)
				timer = 2000
				break;

			case 4:
				prompt = getRandomIntInRange(1000000, 9999999)
				timer = 2500
				break;

			case 5:
				prompt = getRandomIntInRange(10000000, 99999999)
				timer = 3000
				break;

			case 6:
				prompt = getRandomIntInRange(100000000, 999999999)
				timer = 3500
				break;

			case 7:
				prompt = getRandomIntInRange(1000000000, 9999999999)
				timer = 4000
				break;

			case 8:
				prompt = getRandomIntInRange(10000000000, 99999999999)
				timer = 4500
				break;

			case 9:
				prompt = getRandomIntInRange(100000000000, 999999999999)
				timer = 5000
				break;

			case 10:
				prompt = getRandomIntInRange(1000000000000, 9999999999999)
				timer = 5500
				break;
		}

		$("#passhack-prompt").html(prompt)

		$("#body").fadeIn(300)
		document.getElementById("passhack-input").disabled = true
		setTimeout(() => {
			document.getElementById("passhack-input").disabled = false
			document.getElementById("passhack-input").focus()
			$("#passhack-prompt").html("*************")

			for (let i = 100; i > 0; i--) {
				let cock = setTimeout(function timer() {
					if ( done ) { clearTimeout(cock) }
					$("#prog-bar").css('width', 100 - i + "%")

					if ( i == 100 ) {
						if ( done ) { return }
						document.getElementById("passhack-input").style.border = "1px solid #ea686d"
						document.getElementById("passhack-input").disabled = true
						document.getElementById("passhack-prompt").innerHTML = "Failed Crack!"
						$("#passhack-input").hide()
						$("#passhack-hint").hide()
						$("#prog-bar").hide()
						setTimeout(() => {
							document.getElementById("passhack-input").disabled = true
							document.getElementById("passhack-input").style.border = "none"
							$.post('http://dim-passhack/failHack', JSON.stringify({}));
							$("#body").hide()
						}, 1500);
						done = true
					}
				}, i * 60);
			}

		}, timer);
	}
});

document.onkeyup = function (data) {
	if (data.which == 27) { // Escape key
		$("#body").hide()
		$.post('http://dim-passhack/close', JSON.stringify({}));
	}
};

$(document).ready(function() {
	$("#body").hide()

	document.getElementById("passhack-input").addEventListener("keyup", function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();

			if ( prompt == document.getElementById("passhack-input").value ) {
				
				if ( done ) { return }
				document.getElementById("passhack-input").style.border = "1px solid #4bc076"
				document.getElementById("passhack-input").disabled = true
				document.getElementById("passhack-prompt").innerHTML = "Password Cracked!"
				$("#passhack-input").hide()
				$("#passhack-hint").hide()
				$("#prog-bar").hide()
				setTimeout(() => {
					document.getElementById("passhack-input").disabled = false
					document.getElementById("passhack-input").style.border = "none"
					$.post('http://dim-passhack/passHack', JSON.stringify({}));
					$("#body").hide()
				}, 1500);
				done = true

			} else {

				if ( done ) { return }
				document.getElementById("passhack-input").style.border = "1px solid #ea686d"
				document.getElementById("passhack-input").disabled = true
				document.getElementById("passhack-prompt").innerHTML = "Failed Crack!"
				$("#passhack-input").hide()
				$("#passhack-hint").hide()
				$("#prog-bar").hide()
				setTimeout(() => {
					document.getElementById("passhack-input").disabled = false
					document.getElementById("passhack-input").style.border = "none"
					$.post('http://dim-passhack/failHack', JSON.stringify({}));
					$("#body").hide()
				}, 1500);
				done = true
			}

			document.getElementById("passhack-input").value = ""
		}
	});
})

function getRandomIntInRange(min, max) {
	return Math.floor(Math.random() * (max - min + 1) + min);
}

$('body').bind('copy paste',function(e) {
    e.preventDefault(); return false; 
});