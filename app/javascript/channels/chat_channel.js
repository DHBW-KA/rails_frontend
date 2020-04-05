import consumer from "./consumer"

document.chat = consumer.subscriptions.create("ChatChannel", {
    connected() {
        if (document.querySelector("#actioncable-form"))
            document.querySelector("#actioncable-form").addEventListener("submit", this.speak.bind(this))
    },

    disconnected() {
        document.querySelector("#actioncable-form").removeEventListener("submit", this.speak.bind(this))
    },

    received(data) {
        if (data.form && document.querySelector("#actioncable-form"))
            document.querySelector("#actioncable-form").outerHTML = data.form
        else if (data.msg && document.querySelector("#actioncable-chat"))
            document.querySelector("#actioncable-chat").innerHTML += data.msg
    },

    speak(event) {
        event.stopPropagation()
        event.preventDefault()
        let input = event.target["message_msg"]
        if (input.value === "") {
            input.classList.add("is-danger")
        } else {
            this.perform('speak', {msg: input.value})
        }
    }
})
