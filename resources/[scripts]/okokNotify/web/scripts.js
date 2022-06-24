let Config

const containerElement = document.getElementById('container')
let containerElementTopOffset = 0

let notifications = []

function addNotification(title, message, time, type) {
	containerElementTopOffset = container.getBoundingClientRect().top

	let notificationElement = document.createElement('div')
	notificationElement.className = 'notification'

	if (Config.Types[type] !== undefined) {
		if (Config.Types[type].highlightColor) {
			notificationElement.style.setProperty('--color', ` ${Config.Types[type].highlightColor}`)
		}

		if (Config.Types[type].icon) {
			let iconElement = document.createElement('div')
			iconElement.className = 'icon'
			iconElement.classList.add(`${Config.Types[type].icon[0]}`)
			iconElement.classList.add(`${Config.Types[type].icon[1]}`)
			notificationElement.appendChild(iconElement)
		}
	}

	let contentElement = document.createElement('div')
	contentElement.className = 'content'
	notificationElement.appendChild(contentElement)

	let titleElement = document.createElement('div')
	titleElement.className = 'title'
	titleElement.innerHTML = title
	contentElement.appendChild(titleElement)

	let messageElement = document.createElement('div')
	messageElement.className = 'message'
	messageElement.innerHTML = message
	contentElement.appendChild(messageElement)

	notifications.unshift(notificationElement)

	containerElement.appendChild(notificationElement)

	anime({
		targets: notificationElement,
		translateX: [(Config.LeftAlign ? -1 : 1) * notificationElement.offsetWidth, 0],
		easing: 'spring(1, 70, 100, 10)',
		duration: 1000,
		endDelay: time / 2,
		direction: 'alternate',
		complete: function () {
			notifications.pop()

			if (notifications.length > 0) {
				anime.remove(containerElement)
				anime({
					targets: containerElement,
					translateY: [notificationElement.getBoundingClientRect().bottom - containerElementTopOffset, 0],
					easing: 'easeOutExpo',
					duration: 250
				})
			}

			notificationElement.remove()
		}
	})

	const sound = new Audio('sound.mp3')
	sound.volume = 0.8
	sound.play()
}

fetch(`https://${GetParentResourceName()}/request_config`).then(response => {
	if (response.ok) {
		response.json().then(data => {
			Config = data

			if (Config.LeftAlign) {
				containerElement.style.left = '1.5rem'
			} else {
				containerElement.style.right = '1.5rem'
			}

			window.addEventListener('message', (event) => {
				if (event.data.action == 'notify') {
					addNotification(event.data.title, event.data.message, event.data.time, event.data.type)
				}
			})
		})
	} else {
		console.log('okokNotify: NUI error (could not fetch config)')
	}
})