import {Controller} from "stimulus"

export default class extends Controller {
    static targets = ["form"]

    speak(event) {
        event.preventDefault()
        event.stopPropagation()
        let input = event.target["message_msg"]
        if (input.value === "") {
            input.classList.add("is-danger")
        } else {
            this.send(input.value).then((response) => {
                response.text().then((text) => eval(text))
            })
        }
    }


    send(msg) {
        return fetch("/messages.js", {
            method: 'POST',
            body: JSON.stringify({message: {msg: msg}}),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.head.querySelector("[name='csrf-token']").getAttribute("content")
            }
        })
    }
}
